import 'package:flutter/services.dart';
import 'package:tenders/core/core.dart';
import 'package:tenders/widgets/root_widget.dart' as root;
import 'package:flutter/material.dart';

Future<void> main() async {
  await Core.init();
  runApp(root.RootWidget());
  await Core.postInit();
}
