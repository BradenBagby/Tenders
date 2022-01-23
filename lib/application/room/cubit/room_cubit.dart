import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';
import 'package:tenders/application/ads/ads_cubit.dart';
import 'package:tenders/core/utility/environment.dart';
import 'package:tenders/core/utility/route_controllers.dart';
import 'package:tenders/domain/member/member.dart';
import 'package:tenders/domain/restauraunt/restauraunt.dart';
import 'package:tenders/domain/room/room.dart';
import 'package:tenders/services/interfaces/i_auth.dart';
import 'package:tenders/services/interfaces/i_restauraunt.dart';
import 'package:tenders/services/interfaces/i_room.dart';

part 'room_state.dart';
part 'room_cubit.freezed.dart';

class RoomCubit extends Cubit<RoomState> {
  StreamSubscription<Room?>? roomDataStreamSubscription;
  StreamSubscription<Iterable<Member>>? memberDataStreamSubscription;
  StreamSubscription<Iterable<Restauraunt>>? matchStreamSubscription;
  IRestauraunt _restaurauntService;

  int showAdCounter = 8;
  int adsShown = 0;
  RoomCubit({required Room room, required Member me})
      : _restaurauntService = GetIt.I<IRestauraunt>(),
        super(RoomState(room: room, me: me, members: [me], restauraunts: [])) {
    /// simulate memberj oinging
    if (Environment.marketing) {
      Future.delayed(const Duration(seconds: 3)).then((value) {
        final current = List<Member>.from(state.members);
        current.add(Member(id: "asdf", disconnected: true, name: "John"));
        emit(state.copyWith(members: current));
      });
    }
    showAdCounter = math.Random().nextInt(4) + 8;

    // listen to room updates and update state accordinly
    roomDataStreamSubscription =
        GetIt.I<IRoom>().roomUpdates(room.id).listen((event) {
      if (event == null) {
        emit(state.copyWith(
            closed:
                true)); // TODO: listen top layer for closed and show ui for it
      } else {
        emit(state.copyWith(room: event));
      }
    });

    memberDataStreamSubscription =
        GetIt.I<IRoom>().memberUpdates(room.id).listen((event) {
      emit(state.copyWith(members: event.toList()));
    });
    matchStreamSubscription =
        GetIt.I<IRoom>().matchUpdates(room.id).listen((event) async {
      final current = List<Restauraunt>.from(state.matches);
      for (final Restauraunt rest in event) {
        if (current.where((element) => element.id == rest.id).isEmpty) {
          current.add(rest);
          await RootRouteController.showMatch(
              RootRouteController.key.currentContext!,
              restauraunt: rest);
        }
      }
      emit(state.copyWith(matches: current));
    });

    loadRestauraunts();
  }

  void possibleShowAd() {
    print("Possibly show ad: Coutner:${showAdCounter}");
    if (showAdCounter < 1) {
      adsShown++;
      GetIt.I<AdsCubit>().show();
      showAdCounter = math.Random().nextInt(4) + 8 + (adsShown * 2);
    }
    showAdCounter--;
  }

  Future<bool> loadRestauraunts() async {
    final location = state.currentLocation ?? await _loadLocation();
    emit(state.copyWith(currentLocation: location));
    if (location == null) {
      emit(state.copyWith(showNeedsLocation: true));
      throw Exception("Enable location in settings"); // TODO: error bloc
    }
    final info = await _restaurauntService.load(
        pageToken: state.pageToken,
        location: location,
        settings: state.room.settings);

    emit(state.copyWith(
        hasLoaded: true,
        pageToken: info.item2,
        restauraunts: List<Restauraunt>.from(state.restauraunts)
          ..addAll(info.item1)));

    return true; // TODO: TODO: TODO:
  }

  Future<LocationData?> _loadLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return await location.getLocation();
  }

  Future<void> next({required bool accepted}) async {
    possibleShowAd();
    if (accepted) {
      final acceptedRestauraunt = state.currentViewRestauraunt;
      final acceptedUserIds = await GetIt.I<IRoom>().acceptRestauraunt(
          acceptedRestauraunt!,
          forRoom: state.room,
          forMember: state.me);

      /// see if all active members have accepted this
      /// if there is only one active member, don't count it as a match
      bool match = true;
      final activeMembers =
          state.members.where((element) => !element.disconnected).toList();
      if (activeMembers.length > 1 || Environment.marketing) {
        // TODO: remove the or true
        for (final active in activeMembers) {
          if (!acceptedUserIds.contains(active.id)) {
            match = false;
          }
        }
      } else {
        match = false;
      }

      if (match) {
        // report as a match
        await GetIt.I<IRoom>()
            .reportMatch(acceptedRestauraunt, forRoom: state.room);
      }
    }
    emit(state.copyWith(currentViewIndex: state.currentViewIndex + 1));

    // load more if we are within 5 from the end and we have more to load
    if (state.restauraunts.length - state.currentViewIndex < 5 &&
        state.pageToken != null) {
      loadRestauraunts();
    }
  }

  Future<void> startSwiping() async {
    final success = await GetIt.I<IRoom>().startSwiping(state.room.id);
    if (success) {
      emit(state.copyWith(room: state.room.copyWith(started: true)));
    }
  }

  @override
  Future<void> close() {
    roomDataStreamSubscription?.cancel();
    memberDataStreamSubscription?.cancel();
    matchStreamSubscription?.cancel();
    return super.close();
  }
}
