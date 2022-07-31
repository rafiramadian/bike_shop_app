import 'package:flutter/material.dart';

import '../../../../utils/theme.dart';

class NoTransactionMessage extends StatelessWidget {
  final String messageTitle;
  final String messageDesc;
  const NoTransactionMessage({
    Key? key,
    required this.messageTitle,
    required this.messageDesc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 16,
            ),
            Image.asset(
              "assets/images/no_transaction_illustration.png",
              width: 150,
              color: darkBlue300,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              messageTitle,
              style: titleTextStyle.copyWith(color: darkBlue300, fontSize: 18.0),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              messageDesc,
              style: descTextStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 32.0,
            ),
          ],
        ),
      ),
    );
  }
}
