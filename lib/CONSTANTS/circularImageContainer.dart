import 'package:flutter/material.dart';

class Circularimagecontainer extends StatelessWidget {
  const Circularimagecontainer({super.key, required this.img});

  final String img;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.red,
      ),
      child: CircleAvatar(
        radius: 75,
        backgroundImage: AssetImage(img),
      ),
    );
  }
}