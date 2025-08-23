import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/pages/login.dart';
import 'package:todo_app/pages/redirection_page.dart';
import 'package:todo_app/services/service_firebase.dart';
import 'package:todo_app/pages/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Auth().logout();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkTodoTheme,
      home: RedirectionPage(),
    );
  }
}
