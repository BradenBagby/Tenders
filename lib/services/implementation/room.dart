import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tenders/domain/member/member.dart';
import 'package:tenders/domain/room/room.dart';
import 'package:tenders/services/interfaces/i_room.dart';
import 'package:tuple/tuple.dart';
import 'package:uuid/uuid.dart';

class FireRoom implements IRoom {
  // collection definitions
  static const ROOM_COLLECTION = 'rooms';
  static const MEMBERS_COLLECTION = 'members';
  static CollectionReference get roomCollection =>
      FirebaseFirestore.instance.collection(ROOM_COLLECTION);

  @override
  Future<Room> create() async {
    try {
      final uuid = "testID"; // TODO: for now Uuid().v4();
      final room =
          Room(id: uuid, memberCount: 0, createdAt: DateTime.now().toUtc());
      await roomCollection.doc(uuid).set(room.toJson());
      return room;
    } catch (er) {
      // TODO: make nice exceptions
      throw Exception("Failed to create room");
    }
  }

  @override
  Future<Tuple2<Member, Room>> join(String id) async {
    final roomDoc = roomCollection.doc(id);
    final roomData = await roomDoc.get();
    if (!roomData.exists) {
      throw Exception("Room doesnt exist");
    }

    final roomObject = Room.fromJson(roomData.data() as Map<String, dynamic>);
    final uuid = "testUserID"; // TODO: for now Uuid().v4()
    final myMember = Member(
        joinedAt: DateTime.now().toUtc(),
        id: uuid); // TODO: your id should be from firebase anonymous auth
    roomDoc
        .collection(MEMBERS_COLLECTION)
        .doc(myMember.id)
        .set(myMember.toJson());
    return Tuple2(myMember, roomObject);
  }

  @override
  Stream<Room?> roomUpdates(String id) =>
      roomCollection.doc(id).snapshots().map((event) {
        final data = event.data() as Map<String, dynamic>?;
        if (data == null) return null;
        return Room.fromJson(data);
      });
}
