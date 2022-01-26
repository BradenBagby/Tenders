import 'package:tenders/domain/accepted/accepted.dart';
import 'package:tenders/domain/member/member.dart';
import 'package:tenders/domain/restauraunt/restauraunt.dart';
import 'package:tenders/domain/room/room.dart';
import 'package:tenders/domain/room_settings/room_settings.dart';
import 'package:tuple/tuple.dart';

abstract class IRoom {
  /// create a room. returns [String] of room ID
  Future<Room> create({required RoomSettings settings});

  /// join a room by room id
  /// auto generates yourself a uniqueue id for using while in the room
  /// this returns [Member] [Room] encapsolated in a tuple
  Future<Tuple2<Member, Room>> join(Member member, String roomId);

  /// leave a room
  Future<bool> leave(Member member, String roomId);

  /// listens to room updates, is null if this room has been deleted
  Stream<Room?> roomUpdates(String id);

  Future<bool> updateRoomInfo(
    Room room,
  );

  /// get match updates on a room
  /// TODO: somehow pipe stream so one by one
  Stream<Iterable<Restauraunt>> matchUpdates(String id);

  /// member update stream for room id
  Stream<Iterable<Member>> memberUpdates(String id);

  /// gets current doc on rest if someone else already accepted
  /// adds self's name to it
  /// returns list of userId's that have accepted this
  Future<List<String>> acceptRestauraunt(Restauraunt restauraunt,
      {required Room forRoom, required Member forMember});

  /// report this restauraunt as a match
  Future<void> reportMatch(Restauraunt restauraunt, {required Room forRoom});

  Future<bool> startSwiping(String roomId);

  Future<List<Accepted>> getAllAccepted(String roomId);
}
