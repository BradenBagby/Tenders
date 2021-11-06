import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';
import 'package:tenders/domain/member/member.dart';
import 'package:tenders/domain/restauraunt/restauraunt.dart';
import 'package:tenders/domain/room/room.dart';
import 'package:tenders/services/interfaces/i_restauraunt.dart';
import 'package:tenders/services/interfaces/i_room.dart';

part 'room_state.dart';
part 'room_cubit.freezed.dart';

class RoomCubit extends Cubit<RoomState> {
  StreamSubscription<Room?>? roomDataStreamSubscription;
  StreamSubscription<Iterable<Member>>? memberDataStreamSubscription;
  StreamSubscription<Iterable<Restauraunt>>? matchStreamSubscription;
  IRestauraunt _restaurauntService;
  RoomCubit({required Room room, required Member me})
      : _restaurauntService = GetIt.I<IRestauraunt>(),
        super(RoomState(room: room, me: me, members: [me], restauraunts: [])) {
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
        GetIt.I<IRoom>().matchUpdates(room.id).listen((event) {
      final current = List<Restauraunt>.from(state.matchesNeedDisplay);
      current.addAll(event);
      emit(state.copyWith(matchesNeedDisplay: current));
    });

    loadRestauraunts();
  }

  // TODO: clean this up this is so bad
  // TODO: max radius in settings
  String? nextPageToken;
  int radiusMeters = 5000;
  Future<bool> loadRestauraunts() async {
    bool needsFilter = nextPageToken == null;
    final location = state.currentLocation ?? await _loadLocation();
    if (location == null) {
      throw Exception("Enable location in settings"); // TODO: error bloc
    }
    final info = await _restaurauntService.load(
        pageToken: nextPageToken,
        location: location,
        radiusMeters: radiusMeters);

    nextPageToken = info.item2;
    List<Restauraunt> results = info.item1;
    log("radius: $radiusMeters nextPage: ${nextPageToken?.substring(0, 10) ?? 'none'} resultLength: ${results.length} currentAmount: ${state.restauraunts.length} at: ${state.currentViewIndex}");

    /// we have increased the radius and need to filtder results so we dont show again
    results = results
        .where((element) =>
            state.restauraunts
                .firstWhereOrNull((current) => element.id == current.id) ==
            null)
        .toList();

    if (results.length < 20 && nextPageToken == null) {
      radiusMeters += 5000;
    }

    final currentCount = state.restauraunts.length + results.length;
    emit(state.copyWith(
        restauraunts: List<Restauraunt>.from(state.restauraunts)
          ..addAll(results)));

    // load at least 20 until we are done
    if (currentCount - state.currentViewIndex < 20) {
      log("Recursion current count: $currentCount needed: ${state.currentViewIndex + 20} ");
      return loadRestauraunts();
    }

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
    if (accepted) {
      final acceptedRestauraunt = state.currentViewRestauraunt;
      final acceptedAmount = await GetIt.I<IRoom>().acceptRestauraunt(
          acceptedRestauraunt!,
          forRoom: state.room,
          forMember: state.me);
      if (acceptedAmount == state.members.length) {
        // report as a match
        await GetIt.I<IRoom>()
            .reportMatch(acceptedRestauraunt, forRoom: state.room);
      }
    }
    emit(state.copyWith(currentViewIndex: state.currentViewIndex + 1));

    // load more if we are within 5 from the end
    if (state.restauraunts.length - state.currentViewIndex < 5) {
      loadRestauraunts();
    }
  }

  void popMatch() {
    final current = List<Restauraunt>.from(state.matchesNeedDisplay)
      ..removeAt(0);
    emit(state.copyWith(matchesNeedDisplay: current));
  }

  @override
  Future<void> close() {
    roomDataStreamSubscription?.cancel();
    memberDataStreamSubscription?.cancel();
    matchStreamSubscription?.cancel();
    return super.close();
  }
}
