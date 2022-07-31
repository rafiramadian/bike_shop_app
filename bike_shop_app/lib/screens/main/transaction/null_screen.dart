import 'package:bike_shop_app/screens/main/transaction/widgets/no_transaction_message.dart';
import 'package:bike_shop_app/utils/theme.dart';
import 'package:flutter/material.dart';

class NullScreen extends StatelessWidget {
  final String messageTitle;
  final String messageDesc;
  const NullScreen({
    Key? key,
    required this.messageTitle,
    required this.messageDesc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: NoTransactionMessage(
            messageTitle: messageTitle,
            messageDesc: messageDesc,
          ),
        ),
      ),
    );
  }
}
