import 'package:bike_shop_app/screens/landing/wrapper.dart';
import 'package:bike_shop_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor100,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/onboarding_illustration.png",
                height: 400,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                "Bike Shop",
                style: greetingTextStyle,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                "How easy it is to service motorbikes and buy spare parts",
                style: descTextStyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: primaryColor700,
            minimumSize: const Size(100, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool("skipOnBoarding", true);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return const Wrapper();
                },
              ),
            );
          },
          child: Text(
            "Get Started",
            style: buttonTextStyle,
          ),
        ),
      ),
    );
  }
}
