import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/domain/member/member.dart';
import 'package:tenders/services/interfaces/i_auth.dart';
import 'package:tenders/widgets/common/custom/input.dart';
import 'package:tenders/widgets/common/custom/input_controllers.dart';
import 'package:tenders/widgets/common/custom/resize_input.dart';
import 'package:tenders/widgets/common/custom/spinner.dart';
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
  bool loading = false;

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
    Widget body = SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Stack(
                children: [
                  Avatar(
                    member: edited,
                    size: Size(200, 200),
                  ),
                  if (edited?.avatarUrl == null && false) // TODO:
                    Center(
                      child: Icon(
                        Icons.add_a_photo,
                        size: 50,
                        color: Colors.black.withAlpha(78),
                      ),
                    )
                ],
              ),
            ),
            ResizeInput(
              controller: controller,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.go,
              onSubmitted: (val) {
                if (!widget.embedded) {
                  _save();
                }
                widget.onGo?.call();
              },
              hint: "Name",
              style: Theme.of(context).textTheme.headline4,
              textCapitalization: TextCapitalization.words,
            ),
            if (!widget.embedded) ...[
              Expanded(
                child: SizedBox(),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child: Text(
                      "Save",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    onPressed: _save,
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );

    /// add background
    if (!widget.embedded) {
      body = Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/stcharles.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(child: body)
        ],
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: widget.embedded ? Colors.transparent : null,
      appBar: widget.embedded
          ? null
          : AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [if (loading) Loader()],
              leading: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
      body: body,
    );
  }

  Future<void> _save() async {
    setState(() {
      loading = true;
    });
    try {
      final name = controller.text;
      edited = edited!.copyWith(name: name);
      await GetIt.I<RoomAuthCubit>().saveMember(edited!);
      Navigator.of(context).pop();
    } catch (er) {}
  }
}
