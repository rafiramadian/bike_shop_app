import 'package:flutter/material.dart';
import '../../../../utils/theme.dart';

Widget motorBaseCard() {
  return Container(
    margin: const EdgeInsets.only(top: 30.0),
    height: 133,
    width: 230,
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(20.0),
    ),
  );
}
