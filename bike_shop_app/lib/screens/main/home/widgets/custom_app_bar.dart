import 'package:bike_shop_app/utils/theme.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: darkBlue500,
      elevation: 0.0,
      title: Text(
        'Bike Shop',
        style: titleTextStyle.copyWith(
          color: colorWhite,
          fontSize: 24,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
