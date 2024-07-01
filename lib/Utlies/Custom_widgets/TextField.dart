import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String? labeltext;
  final String? hinttext;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.labeltext,
    required this.hinttext,
    required this.controller,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          fillColor: Colors.lightBlueAccent,
          labelText: widget.labeltext,
          hintText: widget.hinttext,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(0),
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(0),
            ),
            borderSide: BorderSide(color: Colors.blueGrey),
          ),
        ),
      ),
    );
  }
}
