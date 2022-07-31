import 'package:bike_shop_app/screens/main/transaction/list_order_screen.dart';
import 'package:bike_shop_app/screens/main/transaction/null_screen.dart';
import 'package:bike_shop_app/viewModels/transaksi_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await context.read<TransaksiProvider>().getListTransaksi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransaksiProvider>(
      builder: (context, value, _) {
        final isLoading = value.transaksiState == TransaksiState.loading;
        final isError = value.transaksiState == TransaksiState.error;

        if (isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (isError) {
          return const NullScreen(
            messageTitle: "Jaringan Error",
            messageDesc: "Cek kuotamu!",
          );
        }

        return const ListOrderScreen();
      },
    );
  }
}
