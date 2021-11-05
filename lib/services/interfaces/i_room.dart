import 'package:tenders/domain/member/member.dart';
import 'package:tenders/domain/room/room.dart';
import 'package:tuple/tuple.dart';

abstract class IRoom {
  /// create a room. returns [String] of room ID
  Future<Room> create();

  /// join a room by room id
  /// auto generates yourself a uniqueue id for using while in the room
  /// this returns [Member] [Room] encapsolated in a tuple
  Future<Tuple2<Member, Room>> join(String id);

  /// listens to room updates, is null if this room has been deleted
  Stream<Room?> roomUpdates(String id);

  /// member update stream for room id
  Stream<Iterable<Member>> memberUpdates(String id);
}
