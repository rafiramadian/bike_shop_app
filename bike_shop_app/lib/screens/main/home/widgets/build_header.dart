import 'package:bike_shop_app/utils/theme.dart';
import 'package:flutter/material.dart';

Widget buildHeader(BuildContext context, String title) {
  return Container(
    height: 65,
    width: MediaQuery.of(context).size.width,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30.0),
        bottomRight: Radius.circular(30.0),
      ),
      color: darkBlue500,
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: colorWhite,
            icon: const Icon(Icons.arrow_back),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: titleTextStyle.copyWith(
                    color: colorWhite,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
