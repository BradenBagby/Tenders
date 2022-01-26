import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tenders/application/room/cubit/room_cubit.dart';
import 'package:tenders/widgets/root_widget.dart';
import 'package:tenders/widgets/routes/welcome/welcome_page.dart';

class NoResults extends StatefulWidget {
  @override
  State<NoResults> createState() => _NoResultsState();
}

class _NoResultsState extends State<NoResults> {
  late final Timer hintTimer;
  late String hint;
  final controller = TextEditingController();

  @override
  void initState() {
    hint = WelcomePageState.queryExamples.first;
    hintTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int next = WelcomePageState.queryExamples.indexOf(hint) + 1;
      if (next >= WelcomePageState.queryExamples.length) {
        next = 0;
      }
      hint = WelcomePageState.queryExamples[next];
      if (mounted) setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
          )),
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/stcharles.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: IconButton(
                    color: Theme.of(context).colorScheme.onBackground,
                    onPressed: () {
                      BlocProvider.of<RoomCubit>(context).close();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).colorScheme.onSurface,
                    )),
                elevation: 0,
              ),
              body: SafeArea(
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Your Custom Search",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(height: 8),
                      BlocBuilder<RoomCubit, RoomState>(
                          builder: (context, state) {
                        return Text(
                          state.room.settings.query,
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(fontWeight: FontWeight.bold),
                        );
                      }),
                      SizedBox(height: 6),
                      Text(
                        "returned no results",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 32, right: 32, top: 8, bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                "Enter new Search:",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ),
                            Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: TextField(
                                  controller: controller,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: primaryColor),
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.text,
                                  onSubmitted: (val) {
                                    FocusScope.of(context).unfocus();
                                    _submit();
                                  },
                                  textCapitalization: TextCapitalization.words,
                                  textInputAction: TextInputAction.go,
                                  decoration: InputDecoration(
                                    focusColor: primaryColor,
                                    fillColor: primaryColor,
                                    border: InputBorder.none,
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            color: primaryColor.withAlpha(155),
                                            fontWeight: FontWeight.w300),
                                    hintText: "e.g. $hint",
                                  ),
                                )),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _submit();
                          },
                          child: Text("Submit"))
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _submit() {
    if (controller.text.isEmpty) return;
    BlocProvider.of<RoomCubit>(context).changeQuery(controller.text);
  }
}
