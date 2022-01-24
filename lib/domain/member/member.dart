import 'package:freezed_annotation/freezed_annotation.dart';

part 'member.freezed.dart';
part 'member.g.dart';

@freezed
class Member with _$Member {
  factory Member({
    required String id,
    @Default(false) bool disconnected,
    @Default("user") String name,
    String? avatarUrl,
    @Default(0xffFF512F) int color,
  }) = _Member;
  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
}
