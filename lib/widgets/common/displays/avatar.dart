import 'package:flutter/material.dart';
import 'package:tenders/domain/member/member.dart';
import 'package:tenders/widgets/common/displays/no_avatar.dart';
import 'package:tenders/widgets/common/displays/url_image.dart';
import 'package:collection/collection.dart';

class Avatar extends StatelessWidget {
  final Member? member;
  final Size size;
  const Avatar({this.member, this.size = const Size(32, 32)});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: size.width,
        height: size.height,
        child: member?.avatarUrl == null
            ? NoAvatar(
                member: member,
                size: size.width,
              )
            : URLImage(
                member!.avatarUrl!,
                failedWidget: NoAvatar(member: member!, size: size.width),
              ),
      ),
    );
  }
}
