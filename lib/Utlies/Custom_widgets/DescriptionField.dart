import 'package:flutter/material.dart';

class DescriptionField extends StatefulWidget {
  final String? labeltext;
  final String? hinttext;
  final TextEditingController? controller;

  const DescriptionField({
    super.key,
    required this.labeltext,
    required this.hinttext,
    required this.controller,
  });

  @override
  _DescriptionFieldState createState() => _DescriptionFieldState();
}

class _DescriptionFieldState extends State<DescriptionField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: TextFormField(
        maxLength: 500,
        maxLines: 6,
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
