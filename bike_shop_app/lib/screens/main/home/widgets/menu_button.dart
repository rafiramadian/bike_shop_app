import 'package:flutter/material.dart';

import '../../../../utils/theme.dart';

Widget menuButton({icon, iconColor, baseColor, text, required Function onTap}) {
  return Column(
    children: [
      GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          margin: const EdgeInsets.only(top: 30.0, bottom: 4.0),
          height: 65,
          width: 65,
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Icon(
            icon,
            size: 40,
            color: iconColor,
          ),
        ),
      ),
      Text(
        text,
        style: subtitleTextStyle.copyWith(
          color: colorWhite,
          fontSize: 12,
        ),
      ),
    ],
  );
}
