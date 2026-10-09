import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:recipes_app/bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  runApp(buildApp(prefs));
}
