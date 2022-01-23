import 'package:flutter/material.dart';
import 'package:tenders/domain/member/member.dart';
import 'package:tenders/widgets/common/displays/no_avatar.dart';
import 'package:tenders/widgets/common/displays/url_image.dart';

class Avatar extends StatelessWidget {
  final Member? member;
  final Size size;
  const Avatar({this.member, this.size = const Size(24, 24)});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: size.width,
        height: size.height,
        child: member?.avatarUrl == null
            ? NoAvatar(id: member?.id ?? "")
            : URLImage(
                member!.avatarUrl!,
                failedWidget: NoAvatar(
                  id: member!.id,
                ),
              ),
      ),
    );
  }
}
