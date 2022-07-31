import 'package:flutter/material.dart';

Widget motorImageCard(String imageUrl) {
  return SizedBox(
    width: 160,
    height: 125,
    child: Image.asset(
      'assets/images/$imageUrl',
      fit: BoxFit.fill,
    ),
  );
}
