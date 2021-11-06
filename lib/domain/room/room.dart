import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tenders/domain/room_settings/room_settings.dart';

part 'room.freezed.dart';
part 'room.g.dart';

@freezed
class Room with _$Room {
  @JsonSerializable(explicitToJson: true)
  factory Room(
      {required String id,
      required DateTime createdAt,
      required RoomSettings settings}) = _Room;
  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}
