import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tenders/application/room/cubit/room_cubit.dart';
import 'package:tenders/core/utility/route_controllers.dart';
import 'package:tenders/domain/member/member.dart';
import 'package:tenders/domain/room/room.dart';
import 'package:tenders/domain/room_settings/room_settings.dart';
import 'package:tenders/services/implementation/room.dart';
import 'package:tenders/services/interfaces/i_auth.dart';
import 'package:tenders/services/interfaces/i_room.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_auth_state.dart';
part 'room_auth_cubit.freezed.dart';

//// manages authentication on a room
/// creates and closes dependent cubits on the room
class RoomAuthCubit extends Cubit<RoomAuthState> {
  IRoom _roomService;
  RoomAuthCubit({required IRoom roomService})
      : _roomService = roomService,
        super(const RoomAuthState()) {
    // imediately authenticate user anonymously
    // firebase caches this as currentUser
    GetIt.I<IAuth>().getUser().then((value) {
      getMember();
    });
  }

  /// loads my member info
  Future<Member> getMember() async {
    if (state.me != null) {
      return state.me!;
    }
    final currentUser = await GetIt.I<IAuth>().getUser();
    final me = await GetIt.I<IAuth>().getMember(currentUser.uid);
    emit(state.copyWith(me: me));
    return me;
  }

  Future<bool> saveMember(Member member) async {
    final success = await GetIt.I<IAuth>().saveMember(member);
    if (success) {
      emit(state.copyWith(me: member));
    }
    return success;
  }

  /// create a room, auto joins after
  Future<bool> createRoom({required RoomSettings settings}) async {
    if (state.currentRoomCubit != null) {
      // TODO: alert dialog for already being in a room
      return false;
    }
    try {
      final newRoom = await _roomService.create(settings: settings);
      return joinRoom(newRoom.id);
    } catch (er) {
      // TODO: alert dialog for failing to create a room
      return false;
    }
  }

  Future<Member?> connectWithFacebook() async {
    try {
      final res = await GetIt.I<IAuth>().connectWithFacebook();
      final newMember = state.me!.copyWith(
          avatarUrl: res.providerData.firstOrNull?.photoURL,
          name: res.providerData.firstOrNull?.displayName ??
              res.displayName ??
              state.me!.name);
      if (await saveMember(newMember)) {
        return newMember;
      }
      return null;
    } catch (er) {
      log("error connecting with facebook: $er");
      return null;
    }
  }

  Future<Member?> disconnectFromFacebook() async {
    try {
      final res = await GetIt.I<IAuth>().disconnectFromFacebook();
      final newMember = state.me!.copyWith(avatarUrl: null, name: "User");
      if (await saveMember(newMember)) {
        return newMember;
      }
      return null;
    } catch (er) {
      log("error removing  facebook: $er");
      return null;
    }
  }

  /// join a room by id
  Future<bool> joinRoom(String id) async {
    Member member;
    try {
      member = await getMember();
    } catch (er) {
      return false;
    }
    try {
      final info = await _roomService.join(member, id);
      final cubit = RoomCubit(room: info.item2, me: info.item1);
      if (state.currentRoomCubit != null) {
        await leaveRoom();
      }
      emit(state.copyWith(currentRoomCubit: cubit));
      return true;
    } on BadVersionException catch (er) {
      await showDialog(
        context: RootRouteController.key.currentContext!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Bad Version"),
            content: Text(
                "Tell your friend to update their app. They have an old version so you can't join!"),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("I will tell them"),
              ),
            ],
          );
        },
      );
      return false;
    } catch (er) {
      // TODO:
      return false;
    }
  }

  Future<bool> leaveRoom() async {
    final currentRoom = state.currentRoomCubit?.state.room;
    final currentUser = state.currentRoomCubit?.state.me;
    state.currentRoomCubit?.close();
    emit(state.copyWith(currentRoomCubit: null));
    if (currentRoom != null && currentUser != null) {
      await _roomService.leave(currentUser, currentRoom.id);
    }
    return true;
  }
}
