import 'package:bike_shop_app/models/motor.dart';
import 'package:bike_shop_app/screens/main/home/add_motor_screen.dart';
import 'package:flutter/material.dart';
import '../../../../utils/theme.dart';

Widget motorTopCard(BuildContext context, Motor motor) {
  return InkWell(
    onTap: () {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const AddMotorScreen(
              isAdd: false,
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
      padding: const EdgeInsets.fromLTRB(30, 10, 20, 10),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    motor.motorType,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: titleTextStyle.copyWith(
                      color: colorWhite,
                      fontSize: 14,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    motor.nopol!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: subtitleTextStyle.copyWith(
                      color: colorWhite,
                      fontSize: 12,
                    ),
                  ),
                )
              ],
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
    decoration: BoxDecoration(
      color: colorYellow,
      borderRadius: BorderRadius.circular(30.0),
    ),
    child: const Icon(
      Icons.arrow_circle_right,
      color: darkBlue500,
    ),
  );
}
