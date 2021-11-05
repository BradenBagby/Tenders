import 'package:tenders/core/core.dart';
import 'package:tenders/widgets/root_widget.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await Core.init();

  runApp(RootWidget());
}
