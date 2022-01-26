import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tenders/core/utility/environment.dart';
import 'package:tenders/core/utility/utility.dart';
import 'package:tenders/domain/accepted/accepted.dart';
import 'package:tenders/domain/member/member.dart';
import 'package:tenders/domain/restauraunt/restauraunt.dart';
import 'package:tenders/domain/room/room.dart';
import 'package:tenders/domain/room_settings/room_settings.dart';
import 'package:tenders/services/interfaces/i_room.dart';
import 'package:tuple/tuple.dart';
import 'package:uuid/uuid.dart';

class BadVersionException extends Error {}

class FireRoom implements IRoom {
  // collection definitions
  static get ROOM_COLLECTION =>
      (Environment.testRoomsInDebug && kDebugMode) ? 'roomsDebug' : 'rooms';
  static const MEMBERS_COLLECTION = 'members';
  static const ACCEPTED_COLLECTION = 'accepted';
  static const MATCHES_COLLECTION = 'matches';
  static CollectionReference get roomCollection =>
      FirebaseFirestore.instance.collection(ROOM_COLLECTION);

  @override
  Future<Room> create({required RoomSettings settings}) async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version;

      final uuid = const Uuid().v4(); // TODO: for now
      final room = Room(
          id: uuid,
          createdAt: DateTime.now().toUtc(),
          settings: settings,
          started: false,
          version: version);
      final data = room.toJson();

      //data["settings"] = data["settings"].toJson();
      await roomCollection.doc(uuid).set(data);
      return room;
    } catch (er) {
      // TODO: make nice exceptions
      throw Exception("Failed to create room");
    }
  }

  @override
  Future<Tuple2<Member, Room>> join(Member member, String id) async {
    final roomDoc = roomCollection.doc(id);
    final roomData = await roomDoc.get();

    if (!roomData.exists) {
      throw Exception("Room doesnt exist");
    }
    final roomObject = Room.fromJson(roomData.data() as Map<String, dynamic>);

    if (!isVersionNumberGreaterOrEqual(
        roomObject.version ?? '0.0.0', Environment.minimumRequiredVersion)) {
      throw BadVersionException();
    }

    final memberData = member.toJson();
    memberData['joinedAt'] = FieldValue.serverTimestamp();
    roomDoc.collection(MEMBERS_COLLECTION).doc(member.id).set(memberData);
    return Tuple2(member, roomObject);
  }

  @override
  Stream<Room?> roomUpdates(String id) =>
      roomCollection.doc(id).snapshots().map((event) {
        final data = event.data() as Map<String, dynamic>?;
        if (data == null) return null;
        return Room.fromJson(data);
      });

  @override
  Stream<Iterable<Member>> memberUpdates(String id) => roomCollection
      .doc(id)
      .collection(MEMBERS_COLLECTION)
      .snapshots()
      .map((event) => event.docs.map((e) => Member.fromJson(e.data())));

  @override
  Stream<Iterable<Restauraunt>> matchUpdates(String id) => roomCollection
      .doc(id)
      .collection(MATCHES_COLLECTION)
      .snapshots()
      .map((event) => event.docChanges
          .where((e) => e.doc.data() != null)
          .map((e) => Restauraunt.fromJson(e.doc.data()!)));

  @override
  Future<List<String>> acceptRestauraunt(Restauraunt restauraunt,
      {required Room forRoom, required Member forMember}) async {
    final docRef = roomCollection
        .doc(forRoom.id)
        .collection(ACCEPTED_COLLECTION)
        .doc(restauraunt.id);
    final doc = await docRef.get();
    if (doc.exists) {
      final currentAccepted =
          List<String>.from(doc.data()!['accepted'] as Iterable<dynamic>);
      if (!currentAccepted.contains(forMember.id)) {
        currentAccepted.add(forMember.id);
        await docRef.update({"accepted": currentAccepted});
      }

      return currentAccepted;
    } else {
      final accepted = [forMember.id];
      await docRef
          .set({"accepted": accepted, "restaurant": restauraunt.toJson()});
      return accepted;
    }
  }

  @override
  Future<void> reportMatch(Restauraunt restauraunt, {required Room forRoom}) {
    final json = restauraunt.toJson();
    return roomCollection
        .doc(forRoom.id)
        .collection(MATCHES_COLLECTION)
        .doc(restauraunt.id)
        .set(json);
  }

  @override
  Future<bool> leave(Member member, String roomId) async {
    final roomDoc = roomCollection.doc(roomId);
    try {
      await roomDoc
          .collection(MEMBERS_COLLECTION)
          .doc(member.id)
          .update({"disconnected": true});
      return true;
    } catch (er) {
      return false; // room no longer existed anyways
    }
  }

  @override
  Future<bool> startSwiping(String roomId) async {
    try {
      await roomCollection.doc(roomId).update({"started": true});
      return true;
    } catch (er) {
      return false;
    }
  }

  @override
  Future<List<Accepted>> getAllAccepted(String roomId) async {
    try {
      final info = await roomCollection
          .doc(roomId)
          .collection(ACCEPTED_COLLECTION)
          .get();
      final accepted = info.docs
          .map(
            (e) => Accepted.fromJson(
              e.data(),
            ),
          )
          .toList();
      accepted.sort((a, b) => b.accepted.length.compareTo(a.accepted.length));
      return accepted;
    } catch (er) {
      return [];
    }
  }

  @override
  Future<bool> updateRoomInfo(Room room) async {
    await roomCollection.doc(room.id).update(room.toJson());
    return true;
  }
}
