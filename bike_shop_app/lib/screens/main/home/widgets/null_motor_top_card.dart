import 'package:bike_shop_app/screens/main/home/add_motor_screen.dart';
import 'package:flutter/material.dart';
import '../../../../utils/theme.dart';

Widget nullMotorTopCard(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const AddMotorScreen(
              isAdd: true,
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 600),
        ),
      );
    },
    child: Container(
      margin: const EdgeInsets.only(top: 100),
      padding: const EdgeInsets.only(
        right: 10,
        left: 30,
      ),
      height: 55,
      width: 210,
      decoration: BoxDecoration(
        color: darkBlue500,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              'Tambah Motor',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: titleTextStyle.copyWith(
                color: colorWhite,
                fontSize: 14,
              ),
            ),
          ),
          _buildAddMotorButton(context),
        ],
      ),
    ),
  );
}

Widget _buildAddMotorButton(BuildContext context) {
  return Container(
    height: 30,
    width: 30,
    decoration: BoxDecoration(color: colorYellow, shape: BoxShape.circle),
    child: const Icon(
      Icons.add_circle,
      color: darkBlue500,
    ),
  );
}
