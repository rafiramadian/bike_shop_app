import 'package:bike_shop_app/screens/main/transaction/history_screen.dart';
import 'package:bike_shop_app/screens/main/transaction/order_screen.dart';
import 'package:bike_shop_app/utils/theme.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor100,
      appBar: AppBar(
        title: Text(
          "Transaksi",
          style: titleTextStyle.copyWith(color: colorWhite),
        ),
        backgroundColor: darkBlue500,
        elevation: 0.0,
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelStyle: tabBarTextStyle,
          labelColor: colorWhite,
          unselectedLabelColor: primaryColor300,
          indicatorColor: colorWhite,
          tabs: const [
            Tab(
              text: "Pesanan",
            ),
            Tab(
              text: "Riwayat",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          OrderScreen(),
          HistoryScreen(),
        ],
      ),
    );
  }
}
