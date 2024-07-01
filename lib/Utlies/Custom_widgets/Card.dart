import 'package:flutter/material.dart';

class CardView extends StatefulWidget {
  const CardView({super.key});

  @override
  State<CardView> createState() => _CardState();
}

class _CardState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 100,
      width: 400,
      child: Card(),
    );
  }
}
