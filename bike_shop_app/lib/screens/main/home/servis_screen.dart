import 'package:bike_shop_app/models/motor.dart';
import 'package:bike_shop_app/screens/main/home/add_servis_screen.dart';
import 'package:bike_shop_app/screens/main/home/widgets/build_header.dart';
import 'package:bike_shop_app/utils/constant.dart';
import 'package:bike_shop_app/utils/theme.dart';
import 'package:flutter/material.dart';

class ServisScreen extends StatelessWidget {
  final Motor motor;
  const ServisScreen({Key? key, required this.motor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            buildHeader(context, 'Pilihan Servis'),
            _buildContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildCardHeader(),
          const SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text(
              'Pilihan Paket',
              style: titleTextStyle,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          _buildCardServis(
            title: 'Servis Ringan',
            subtitle: 'Servis secara berkala 5.000 km atau setiap 2-3 bulan',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddServisScreen(
                    title: 'Servis Ringan',
                    item: servisRingan,
                    motor: motor,
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 12.0,
          ),
          _buildCardServis(
            title: 'Servis Komplit',
            subtitle: 'Servis secara berkala 10.000 km atau setiap 4-6 bulan dilengkapi dengan cairan pembersih khusus',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddServisScreen(
                    title: 'Servis Komplit',
                    item: servisBerat,
                    motor: motor,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCardHeader() {
    String img;
    if (motor.motorType == "HONDA BEAT") {
      img = "honda_beat.png";
    } else if (motor.motorType == "YAMAHA MIO") {
      img = "yamaha_mio.png";
    } else {
      img = "kawasaki_ninja.png";
    }
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: primaryColor100, width: 1),
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 2.5,
      color: colorWhite,
      shadowColor: primaryColor500,
      child: InkWell(
        onTap: () {},
        splashColor: primaryColor100,
        borderRadius: BorderRadius.circular(30),
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 12.0, bottom: 12.0),
          child: Row(
            children: [
              Container(
                width: 120,
                height: 100.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/$img'),
                  ),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    motor.motorType,
                    style: titleTextStyle,
                  ),
                  Text(
                    motor.nopol!,
                    style: subtitleTextStyle,
                  ),
                  Text(
                    motor.tahun!,
                    style: subtitleTextStyle,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardServis({required String title, required String subtitle, required Function onTap}) {
    return SizedBox(
      height: 130,
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: primaryColor100, width: 1),
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 2.5,
        color: colorWhite,
        shadowColor: primaryColor500,
        child: InkWell(
          onTap: () {
            onTap();
          },
          splashColor: primaryColor100,
          borderRadius: BorderRadius.circular(30),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 30.0,
              top: 22.0,
              bottom: 22.0,
              right: 12.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: titleTextStyle,
                      ),
                      Text(
                        subtitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: subtitleTextStyle.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  size: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
