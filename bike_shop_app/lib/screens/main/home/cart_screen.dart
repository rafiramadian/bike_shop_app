import 'package:bike_shop_app/models/item.dart';
import 'package:bike_shop_app/models/motor.dart';
import 'package:bike_shop_app/models/transaksi.dart';
import 'package:bike_shop_app/screens/main/home/widgets/build_header.dart';
import 'package:bike_shop_app/screens/main/main_screen.dart';
import 'package:bike_shop_app/utils/theme.dart';
import 'package:bike_shop_app/viewModels/cart_provider.dart';
import 'package:bike_shop_app/viewModels/transaksi_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  final Motor motor;
  const CartScreen({Key? key, required this.motor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            buildHeader(context, 'Keranjang'),
            Expanded(child: _buildContent(context)),
            _buildButtonPesan(context, context.read<CartProvider>().items, context.read<CartProvider>().total),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, value, _) {
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
                child: value.items.isNotEmpty
                    ? Column(
                        children: [
                          Text(
                            'Sparepart',
                            style: titleTextStyle,
                          ),
                          ..._buildListServis(context, value.items),
                        ],
                      )
                    : Column(
                        children: [
                          Column(
                            children: [
                              Text(
                                'Sparepart',
                                style: titleTextStyle,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                                child: Divider(
                                  color: primaryColor300,
                                ),
                              ),
                              Text(
                                'Keranjang kosong!',
                                style: subtitleTextStyle,
                              ),
                              const SizedBox(
                                height: 12.0,
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
    });
  }

  _buildListServis(BuildContext context, List<Item> items) {
    return items.map(
      (item) {
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
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: colorYellow,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              context.read<CartProvider>().removeFromCart(item);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildButtonPesan(BuildContext context, List<Item> items, totalHarga) {
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
                'Rp. ${Provider.of<CartProvider>(context).total}',
                style: titleTextStyle.copyWith(color: colorYellow, fontSize: 16),
              ),
            ],
          ),
          Consumer<TransaksiProvider>(builder: (context, value, _) {
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
              width: 120,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ElevatedButton(
                onPressed: () async {
                  DateTime now = DateTime.now();
                  final String tanggalPesan = DateFormat("dd-MM-yyyy").format(now);
                  String tanggalDatang = tanggalPesan;

                  final transaksi = Transaksi(
                    jenisPesanan: 'Sparepart',
                    tanggalPesan: tanggalPesan,
                    tanggalDatang: tanggalDatang,
                    totalHarga: totalHarga,
                    listPesanan: items,
                    motor: motor,
                  );

                  message = await value.addTransaksiSparepart(transaksi);

                  if (message == 'Success') {
                    context.read<CartProvider>().items = [];
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainScreen(),
                      ),
                      (route) => false,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pemesanan sparepart berhasil!')),
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
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.yellow.withOpacity(0.6);
                      }
                      return colorYellow;
                    },
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
