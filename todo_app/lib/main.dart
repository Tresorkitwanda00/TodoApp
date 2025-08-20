import 'package:flutter/material.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/pages/login.dart';
import 'package:todo_app/pages/sign_up.dart';
import 'package:todo_app/pages/theme/theme.dart';
import 'package:todo_app/pages/todo_title.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkTodoTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const Login(),
        '/home': (context) => const HomePage(),
        '/signup': (context) => const SignUp(),
        '/todo': (context) => const TodoTitle(),
      },
    ),
  );
}
