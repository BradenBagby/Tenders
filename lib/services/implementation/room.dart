import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tenders/domain/member/member.dart';
import 'package:tenders/domain/restauraunt/restauraunt.dart';
import 'package:tenders/domain/room/room.dart';
import 'package:tenders/domain/room_settings/room_settings.dart';
import 'package:tenders/services/interfaces/i_room.dart';
import 'package:tuple/tuple.dart';
import 'package:uuid/uuid.dart';

class FireRoom implements IRoom {
  // collection definitions
  static const ROOM_COLLECTION = 'rooms';
  static const MEMBERS_COLLECTION = 'members';
  static const ACCEPTED_COLLECTION = 'accepted';
  static const MATCHES_COLLECTION = 'matches';
  static CollectionReference get roomCollection =>
      FirebaseFirestore.instance.collection(ROOM_COLLECTION);

  @override
  Future<Room> create({required RoomSettings settings}) async {
    try {
      final uuid = "testID"; // TODO: for now Uuid().v4();
      final room =
          Room(id: uuid, createdAt: DateTime.now().toUtc(), settings: settings);
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
  Future<Tuple2<Member, Room>> join(String id) async {
    final roomDoc = roomCollection.doc(id);
    final roomData = await roomDoc.get();
    if (!roomData.exists) {
      // TODO: for now throw Exception("Room doesnt exist");
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
  Future<int> acceptRestauraunt(Restauraunt restauraunt,
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

      return currentAccepted.length;
    } else {
      await docRef.set({
        "accepted": [forMember.id]
      });
      return 1;
    }
  }

  @override
  Future<void> reportMatch(Restauraunt restauraunt, {required Room forRoom}) {
    return roomCollection
        .doc(forRoom.id)
        .collection(MATCHES_COLLECTION)
        .doc(restauraunt.id)
        .set(restauraunt.toJson());
  }
}
