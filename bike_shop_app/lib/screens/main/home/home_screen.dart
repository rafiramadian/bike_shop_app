import 'package:bike_shop_app/screens/main/home/contact_api/contact_screen.dart';
import 'package:bike_shop_app/screens/main/home/ganti_oli_screen.dart';
import 'package:bike_shop_app/screens/main/home/servis_screen.dart';
import 'package:bike_shop_app/screens/main/home/sparepart_screen.dart';
import 'package:bike_shop_app/screens/main/home/widgets/custom_app_bar.dart';
import 'package:bike_shop_app/screens/main/home/widgets/menu_button.dart';
import 'package:bike_shop_app/screens/main/home/widgets/motor_base_card.dart';
import 'package:bike_shop_app/screens/main/home/widgets/motor_image_card.dart';
import 'package:bike_shop_app/screens/main/home/widgets/motor_top_card.dart';
import 'package:bike_shop_app/screens/main/home/widgets/null_motor_top_card.dart';
import 'package:bike_shop_app/screens/main/home/widgets/promo_news_card.dart';
import 'package:bike_shop_app/utils/constant.dart';
import 'package:bike_shop_app/utils/theme.dart';
import 'package:bike_shop_app/viewModels/motor_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<MotorProvider>().getMotor();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _buildHeader(context),
          const PromoNewsListView(title: 'Promo untuk Anda', item: promo),
          const PromoNewsListView(title: 'Berita Terkini', item: news),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          16.0,
          0.0,
          16.0,
          20.0,
        ),
        decoration: const BoxDecoration(
          color: darkBlue500,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                motorBaseCard(),
                Consumer<MotorProvider>(
                  builder: (context, value, _) {
                    final motor = value.motor;
                    final isLoading = value.motorState == MotorState.loading;
                    final isError = value.motorState == MotorState.error;

                    if (isLoading) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (isError) {
                      return motorImageCard('null_motor.png');
                    }

                    if (motor != null) {
                      if (motor.motorType == "YAMAHA MIO") {
                        return motorImageCard('yamaha_mio.png');
                      } else if (motor.motorType == "HONDA BEAT") {
                        return motorImageCard('honda_beat.png');
                      } else if (motor.motorType == "KAWASAKI NINJA") {
                        return motorImageCard('kawasaki_ninja.png');
                      }
                    }
                    return motorImageCard('null_motor.png');
                  },
                ),
                Consumer<MotorProvider>(
                  builder: (context, value, _) {
                    final motor = value.motor;
                    final isLoading = value.motorState == MotorState.loading;
                    final isError = value.motorState == MotorState.error;

                    if (isLoading) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 120),
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (isError) {
                      return nullMotorTopCard(context);
                    }

                    if (motor != null) {
                      return motorTopCard(context, motor);
                    } else {
                      return nullMotorTopCard(context);
                    }
                  },
                ),
              ],
            ),
            Consumer<MotorProvider>(
              builder: (context, value, _) {
                final motor = value.motor;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    menuButton(
                      icon: Icons.settings,
                      iconColor: darkBlue500,
                      baseColor: backgroundColor,
                      text: 'Servis',
                      onTap: () {
                        if (motor != null) {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) {
                                return ServisScreen(motor: motor);
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
                          return;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Tambah Motor dulu dong!'),
                          ),
                        );
                      },
                    ),
                    menuButton(
                      icon: Icons.format_color_fill_outlined,
                      iconColor: darkBlue500,
                      baseColor: backgroundColor,
                      text: 'Ganti Oli',
                      onTap: () {
                        if (motor != null) {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) {
                                return const GantiOliScreen();
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
                          return;
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Tambah Motor dulu dong!'),
                          ),
                        );
                      },
                    ),
                    menuButton(
                      icon: Icons.add_chart_outlined,
                      iconColor: darkBlue500,
                      baseColor: backgroundColor,
                      text: 'Spare Part',
                      onTap: () {
                        if (motor != null) {
                          if (motor.motorType == "HONDA BEAT") {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) {
                                  return SparepartScreen(motor: motor, item: sparepartHonda);
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
                            return;
                          } else if (motor.motorType == "YAMAHA MIO") {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) {
                                  return SparepartScreen(motor: motor, item: sparepartYamaha);
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
                            return;
                          } else if (motor.motorType == "KAWASAKI NINJA") {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) {
                                  return SparepartScreen(motor: motor, item: sparepartKawasaki);
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
                            return;
                          }
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Tambah Motor dulu dong!'),
                          ),
                        );
                      },
                    ),
                    menuButton(
                      icon: Icons.widgets_rounded,
                      iconColor: backgroundColor,
                      baseColor: primaryColor700,
                      text: 'Lain-lain',
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) {
                              return const ContactScreen();
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
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
