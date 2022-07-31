import 'package:bike_shop_app/screens/landing/onboarding_screen.dart';
import 'package:bike_shop_app/screens/landing/wrapper.dart';
import 'package:bike_shop_app/services/auth_service.dart';
import 'package:bike_shop_app/utils/theme.dart';
import 'package:bike_shop_app/viewModels/auth_state_provider.dart';
import 'package:bike_shop_app/viewModels/cart_provider.dart';
import 'package:bike_shop_app/viewModels/contact_manager.dart';
import 'package:bike_shop_app/viewModels/motor_provider.dart';
import 'package:bike_shop_app/viewModels/motor_selected_value.dart';
import 'package:bike_shop_app/viewModels/screen_index_value.dart';
import 'package:bike_shop_app/viewModels/transaksi_provider.dart';
import 'package:bike_shop_app/viewModels/user_app_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  //Initializing firebase to flutter project
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //Get onboarding data from shared preferences
  final prefs = await SharedPreferences.getInstance();
  final skipOnBoarding = prefs.getBool('skipOnBoarding') ?? false;

  runApp(MyApp(skipOnBoarding: skipOnBoarding));
}

class MyApp extends StatelessWidget {
  final bool skipOnBoarding;

  const MyApp({Key? key, required this.skipOnBoarding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthStateProvider(),
        ),
        Provider(
          create: (context) => AuthService(),
        ),
        Provider(
          create: (context) => UserAppProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ScreenIndexProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MotorSelectedValue(),
        ),
        ChangeNotifierProvider(
          create: (context) => MotorProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransaksiProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ContactProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bike Shop App',
        theme: ThemeData(
          primarySwatch: createMaterialColor(primaryColor500),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: skipOnBoarding ? const Wrapper() : const OnBoardingScreen(),
      ),
    );
  }
}
