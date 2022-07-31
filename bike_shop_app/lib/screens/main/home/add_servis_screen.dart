import 'package:bike_shop_app/models/item.dart';
import 'package:bike_shop_app/models/motor.dart';
import 'package:bike_shop_app/models/transaksi.dart';
import 'package:bike_shop_app/screens/main/home/widgets/build_header.dart';
import 'package:bike_shop_app/screens/main/main_screen.dart';
import 'package:bike_shop_app/utils/theme.dart';
import 'package:bike_shop_app/viewModels/transaksi_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddServisScreen extends StatefulWidget {
  final String title;
  final List<Item> item;
  final Motor motor;
  const AddServisScreen({Key? key, required this.title, required this.item, required this.motor}) : super(key: key);

  @override
  State<AddServisScreen> createState() => _AddServisScreenState();
}

class _AddServisScreenState extends State<AddServisScreen> {
  int totalHarga = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await context.read<TransaksiProvider>().getTransaksiServis();
    });
    for (int i = 0; i < widget.item.length; i++) {
      totalHarga += widget.item[i].hargaItem;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            buildHeader(context, 'Pemesanan'),
            Expanded(child: _buildContent(context)),
            _buildButtonPesan(),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            12.0,
            12.0,
            12.0,
            12.0,
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: primaryColor100, width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 2.5,
            color: colorWhite,
            shadowColor: primaryColor500,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                children: [
                  Text(
                    widget.title,
                    style: titleTextStyle,
                  ),
                  ..._buildListServis(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildListServis() {
    return widget.item.map((item) {
      return Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
            child: Divider(
              color: primaryColor300,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: colorYellow,
                  ),
                  child: item.image == ""
                      ? const Icon(Icons.settings)
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            'assets/images/${item.image}',
                            fit: BoxFit.fill,
                          ),
                        ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.namaItem,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: titleTextStyle.copyWith(fontSize: 16),
                      ),
                      Text(
                        item.deskripsiItem,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: subtitleTextStyle.copyWith(fontSize: 12),
                      ),
                      Text(
                        'Rp. ${item.hargaItem}',
                        style: titleTextStyle.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildButtonPesan() {
    return Consumer<TransaksiProvider>(builder: (context, value, _) {
      final isLoading = value.transaksiState == TransaksiState.loading;
      final isError = value.transaksiState == TransaksiState.error;
      String? message;

      if (isError) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 1),
              content: Text(message ?? ""),
            ),
          );
          value.changeState(TransaksiState.none);
        });
      }

      return Container(
        height: 80,
        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
        decoration: const BoxDecoration(
          color: darkBlue500,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Estimasi Harga',
                  style: titleTextStyle.copyWith(color: colorWhite, fontSize: 14),
                ),
                Text(
                  'Rp. $totalHarga',
                  style: titleTextStyle.copyWith(color: colorYellow, fontSize: 16),
                ),
              ],
            ),
            Container(
              width: 120,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ElevatedButton(
                onPressed: () async {
                  if (value.transaksi != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Ada servis yang belom selesai bang!'),
                      ),
                    );
                    return;
                  }

                  DateTime now = DateTime.now();
                  final String tanggalPesan = DateFormat("dd-MM-yyyy").format(now);
                  String tanggalDatang;
                  if (widget.title != "Sparepart") {
                    final duration = now.add(const Duration(days: 1));
                    tanggalDatang = DateFormat("dd-MM-yyyy").format(duration);
                  } else {
                    tanggalDatang = tanggalPesan;
                  }

                  final transaksi = Transaksi(
                    jenisPesanan: widget.title,
                    tanggalPesan: tanggalPesan,
                    tanggalDatang: tanggalDatang,
                    totalHarga: totalHarga,
                    listPesanan: widget.item,
                    motor: widget.motor,
                  );

                  message = await value.addTransaksiServis(transaksi);

                  if (message == 'Success') {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainScreen(),
                      ),
                      (route) => false,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pemesanan servis berhasil!')),
                    );
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    !isLoading
                        ? Text(
                            'Pesan',
                            style: titleTextStyle,
                          )
                        : const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator.adaptive(
                              backgroundColor: darkBlue500,
                            ),
                          ),
                  ],
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.resolveWith(
                    (states) {
                      if (value.transaksi != null) {
                        return primaryColor100;
                      }
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.yellow.withOpacity(0.6);
                      }
                      return colorYellow;
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
