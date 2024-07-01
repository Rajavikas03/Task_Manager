import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class date_Time extends StatefulWidget {
  final String? labeltext;
  final String? hinttext;
  final TextEditingController? controller;

  const date_Time({
    super.key,
    required this.labeltext,
    required this.hinttext,
    required this.controller,
  });

  @override
  State<date_Time> createState() => _date_TimeState();
}

class _date_TimeState extends State<date_Time> {


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: GestureDetector(onTap: () {
       
      },
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
      ),
    );
  }
}
