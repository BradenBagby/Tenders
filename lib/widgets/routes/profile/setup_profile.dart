import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/domain/member/member.dart';
import 'package:tenders/services/interfaces/i_auth.dart';
import 'package:tenders/widgets/common/custom/input.dart';
import 'package:tenders/widgets/common/custom/input_controllers.dart';
import 'package:tenders/widgets/common/custom/resize_input.dart';
import 'package:tenders/widgets/common/displays/avatar.dart';
import 'package:tenders/widgets/common/displays/no_avatar.dart';
import 'package:tenders/widgets/common/displays/url_image.dart';

class SetupProfile extends StatefulWidget {
  final embedded;
  final Member? preloaded;
  final VoidCallback? onGo;
  const SetupProfile(
      {this.preloaded, this.embedded = true, Key? key, this.onGo})
      : super(key: key);
  @override
  State<SetupProfile> createState() => SetupProfileState();
}

class SetupProfileState extends State<SetupProfile> {
  Member? edited;
  late final InputController controller;

  @override
  void initState() {
    super.initState();
    controller = InputController(text: widget.preloaded?.name ?? "");
    if (widget.preloaded == null) {
      GetIt.I<RoomAuthCubit>().getMember().then((value) {
        if (controller.text.isEmpty) {
          controller.text = value.name;
        }
        setState(() {
          edited = value;
        });
      });
    } else {
      edited = widget.preloaded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: widget.embedded ? Colors.transparent : null,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Avatar(
                member: edited,
                size: Size(200, 200),
              ),
              ResizeInput(
                controller: controller,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.go,
                onSubmitted: (val) {
                  widget.onGo?.call();
                },
                hint: "Name",
                style: Theme.of(context).textTheme.headline4,
                textCapitalization: TextCapitalization.words,
              )
            ],
          ),
        ),
      ),
    );
  }
}
