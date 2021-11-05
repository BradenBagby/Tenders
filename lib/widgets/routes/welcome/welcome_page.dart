import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tenders/application/cubit/room_cubit.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => BlocProvider.of<RoomCubit>(context)
                  .createRoom(), // TODO: if fail show message
              child: Text("Create"),
            ),
            SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () {}, // TODO:
              child: Text("Join"),
            ),
          ],
        ),
      ),
    );
  }
}
