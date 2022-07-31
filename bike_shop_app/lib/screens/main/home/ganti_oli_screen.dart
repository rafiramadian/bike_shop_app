import 'package:bike_shop_app/utils/theme.dart';
import 'package:flutter/material.dart';

class GantiOliScreen extends StatelessWidget {
  const GantiOliScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Ganti Oli release soon!',
              style: titleTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
