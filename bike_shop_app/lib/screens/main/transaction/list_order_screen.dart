import 'package:bike_shop_app/models/transaksi.dart';
import 'package:bike_shop_app/screens/main/transaction/detail_transasksi_screen.dart';
import 'package:bike_shop_app/screens/main/transaction/null_screen.dart';
import 'package:bike_shop_app/utils/theme.dart';
import 'package:bike_shop_app/viewModels/transaksi_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListOrderScreen extends StatelessWidget {
  const ListOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TransaksiProvider>(
      builder: (context, value, child) {
        if (value.listTransaksiSparepart.isNotEmpty || value.transaksi != null) {
          return _buildListTransaksi(value.listTransaksiSparepart);
        }

        return const NullScreen(
          messageTitle: "Belom ada yang dipesen nih :)",
          messageDesc: "Yu buruan pesen!",
        );
      },
    );
  }

  _buildListTransaksi(List<Transaksi> listTransaksiSparepart) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 12.0,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  'Servis & Ganti Oli',
                  style: titleTextStyle,
                ),
              ),
            ],
          ),
          _buildCardServis(),
          const SizedBox(
            height: 12.0,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  'Sparepart',
                  style: titleTextStyle,
                ),
              ),
            ],
          ),
          Consumer<TransaksiProvider>(
            builder: (context, value, _) {
              if (value.listTransaksiSparepart.isNotEmpty) {
                return Expanded(
                  child: _buildCardListSparepart(context, listTransaksiSparepart),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(top: 150.0),
                child: Center(
                  child: Text(
                    'Belum ada pesanan Sparepart',
                    style: subtitleTextStyle,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCardServis() {
    return Consumer<TransaksiProvider>(builder: (context, value, _) {
      if (value.transaksi != null) {
        return Card(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: primaryColor100, width: 1),
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 2.5,
          color: colorWhite,
          shadowColor: primaryColor500,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailTransaksiScreen(
                    transaksi: value.transaksi!,
                    isOrder: true,
                  ),
                ),
              );
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
                          value.transaksi!.jenisPesanan,
                          style: titleTextStyle,
                        ),
                        Text(
                          value.transaksi!.tanggalPesan,
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
        );
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
            padding: const EdgeInsets.only(
              left: 12.0,
              top: 22.0,
              bottom: 22.0,
              right: 12.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Kamu belum pesen paket servis',
                        style: titleTextStyle,
                      ),
                      Text(
                        'Yuk pesen!',
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
    });
  }

  Widget _buildCardListSparepart(BuildContext context, List<Transaksi> listTransaksiSparepart) {
    return Column(
      children: listTransaksiSparepart.map((item) {
        return SingleChildScrollView(
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailTransaksiScreen(
                      transaksi: item,
                      isOrder: true,
                    ),
                  ),
                );
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
                            item.jenisPesanan,
                            style: titleTextStyle,
                          ),
                          Text(
                            item.tanggalDatang,
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
      }).toList(),
    );
  }
}
