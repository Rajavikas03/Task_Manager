import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_manager_/FirebaseDatabase/Auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = ' ';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signWithEmailWithPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createuserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title() {
    return const Text('Firebase Auth');
  }

  Widget _entryField(
    String labelText,
    String hintText,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Column(
        children: [
          const Gap(10),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              fillColor: Colors.lightBlueAccent,
              labelText: labelText,
              hintText: hintText,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(0),
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(0),
                ),
                borderSide: BorderSide(color: Colors.blueGrey),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(0),
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(0),
                ),
                borderSide: BorderSide(color: Colors.red),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(0),
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(0),
                ),
                borderSide: BorderSide(color: Colors.blueGrey),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(0),
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(0),
                ),
                borderSide: BorderSide(color: Colors.blueGrey),
              ),
              disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(0),
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(0),
                ),
                borderSide: BorderSide(color: Colors.blueAccent),
              ),
            ),
          ),
          const Gap(10),
        ],
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : '$errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
        onPressed: isLogin
            ? signWithEmailWithPassword
            : createuserWithEmailAndPassword,
        child: Text(isLogin ? "Login" : "Register"));
  }

  Widget _loginOrRegisterutton() {
    return TextButton(
        onPressed: () {
          setState(() {
            isLogin = !isLogin;
          });
        },
        child: Text(isLogin ? "Register insted" : "Login instead"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Gap(50),
            Center(
                child: CircleAvatar(
              radius: 80,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Image.asset("assets/icons/user.png"),
              ),
            )),
            Gap(80),
            _entryField("Email", "Enter Email Address", _controllerEmail),
            _entryField("Password", "Enter Password", _controllerPassword),
            _errorMessage(), const Gap(10), _submitButton(), const Gap(50),
            _loginOrRegisterutton(), const Gap(10),
          ],
        ),
      ),
    );
  }
}
