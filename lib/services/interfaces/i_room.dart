abstract class IRoom {
  /// create a room. returns [String] of room ID
  Future<String> create();

  /// join a room by room id
  Future<void> join(String code);
}
