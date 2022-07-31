import 'package:bike_shop_app/models/transaksi.dart';
import 'package:bike_shop_app/screens/main/transaction/detail_transasksi_screen.dart';
import 'package:bike_shop_app/screens/main/transaction/null_screen.dart';
import 'package:bike_shop_app/viewModels/transaksi_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/theme.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await context.read<TransaksiProvider>().getRiwayat();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransaksiProvider>(
      builder: (context, value, _) {
        final isLoading = value.transaksiState == TransaksiState.loading;
        final isError = value.transaksiState == TransaksiState.error;

        if (isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (isError) {
          return const NullScreen(
            messageTitle: "Jaringan Error",
            messageDesc: "Cek kuotamu!",
          );
        }

        return _buildListRiwayat(value.listRiwayat);
      },
    );
  }

  _buildListRiwayat(List<Transaksi> listRiwayat) {
    if (listRiwayat.isEmpty) {
      return const NullScreen(
        messageTitle: "Belom ada yang dipesen nih :)",
        messageDesc: "Yu buruan pesen!",
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Column(
          children: listRiwayat.map((item) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
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
                            isOrder: false,
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
                                  item.tanggalPesan,
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
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
