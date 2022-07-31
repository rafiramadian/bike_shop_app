import 'package:bike_shop_app/models/transaksi.dart';
import 'package:bike_shop_app/screens/main/home/widgets/build_header.dart';
import 'package:bike_shop_app/screens/main/main_screen.dart';
import 'package:bike_shop_app/utils/theme.dart';
import 'package:bike_shop_app/viewModels/screen_index_value.dart';
import 'package:bike_shop_app/viewModels/transaksi_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailTransaksiScreen extends StatelessWidget {
  final Transaksi transaksi;
  final bool isOrder;
  const DetailTransaksiScreen({Key? key, required this.transaksi, required this.isOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            buildHeader(context, 'Detail Transaksi'),
            const SizedBox(
              height: 12.0,
            ),
            _buildCardTransaksi(),
            Expanded(child: _buildContent(context)),
            _buildButtonSelesai(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCardTransaksi() {
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
                      transaksi.jenisPesanan,
                      style: titleTextStyle,
                    ),
                    Text(
                      'Tanggal Pesan : ${transaksi.tanggalPesan}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: subtitleTextStyle.copyWith(fontSize: 14),
                    ),
                    Text(
                      'Tanggal Datang : ${transaksi.tanggalDatang}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: subtitleTextStyle.copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
                    'List Pesanan',
                    style: titleTextStyle,
                  ),
                  ..._buildListServis(),
                  const Padding(
                    padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                    child: Divider(
                      color: primaryColor300,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Total Harga : ',
                        style: titleTextStyle,
                      ),
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          color: darkBlue500,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'Rp. ${transaksi.totalHarga}',
                          style: titleTextStyle.copyWith(color: colorWhite),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildListServis() {
    return transaksi.listPesanan.map((item) {
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

  Widget _buildButtonSelesai(BuildContext context) {
    if (isOrder == true) {
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
          width: MediaQuery.of(context).size.width,
          height: 50,
          margin: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 20.0, top: 8.0),
          child: ElevatedButton(
            onPressed: () async {
              if (transaksi.jenisPesanan != 'Sparepart') {
                message = await value.deleteTransaksiServis();
              } else {
                message = await value.deleteTransaksiSparepart(transaksi.id!);
              }

              if (message == 'Success') {
                await value.addRiwayat(transaksi);
                context.read<ScreenIndexProvider>().setCurrentIndex(1);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(),
                  ),
                  (route) => false,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pesanan selesai!')),
                );
              }
            },
            child: !isLoading
                ? Text(
                    'Selesaikan Pesanan',
                    style: buttonTextStyle.copyWith(color: darkBlue500),
                  )
                : const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: darkBlue500,
                    ),
                  ),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) {
                  if (states.contains(MaterialState.pressed)) {
                    return colorYellow.withOpacity(0.8);
                  }
                  return colorYellow;
                },
              ),
            ),
          ),
        );
      });
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: const BoxDecoration(
        color: darkBlue500,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
    );
  }
}
