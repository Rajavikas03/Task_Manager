import 'package:flutter/material.dart';
import 'package:task_manager_/FirebaseDatabase/Auth.dart';
import 'package:task_manager_/Pages/Home.dart';
import 'package:task_manager_/Pages/Login_page.dart';

class Widgettree extends StatefulWidget {
  const Widgettree({super.key});

  @override
  State<Widgettree> createState() => _WidgettreeState();
}

class _WidgettreeState extends State<Widgettree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authstatehanges,
        builder: (context, snaphot) {
          if (snaphot.hasData) {
            return HomePage();
          } else {
            return const LoginPage();
          }
        });
  }
}
