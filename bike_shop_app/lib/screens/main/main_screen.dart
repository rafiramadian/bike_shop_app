import 'package:bike_shop_app/screens/main/bottom_navbar.dart';
import 'package:bike_shop_app/screens/main/home/home_screen.dart';
import 'package:bike_shop_app/screens/main/setting/setting_screen.dart';
import 'package:bike_shop_app/screens/main/transaction/transaction_screen.dart';
import 'package:bike_shop_app/utils/theme.dart';
import 'package:bike_shop_app/viewModels/screen_index_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final screens = const [
    HomeScreen(),
    TransactionScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenIndexProvider>(
      builder: (context, manager, _) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            toolbarHeight: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: darkBlue500,
              statusBarIconBrightness: Brightness.light,
            ),
          ),
          backgroundColor: backgroundColor,
          body: screens[manager.index],
          bottomNavigationBar: BottomNavBar(
            selectedItemIcon: const [
              "assets/icons/home_fill.png",
              "assets/icons/receipt_fill.png",
              "assets/icons/settings_fill.png"
            ],
            unselectedItemIcon: const [
              "assets/icons/home_outlined.png",
              "assets/icons/receipt_outlined.png",
              "assets/icons/settings_outlined.png"
            ],
            label: const ["Home", "Transaction", "Settings"],
            manager: manager,
          ),
        );
      },
    );
  }
}
