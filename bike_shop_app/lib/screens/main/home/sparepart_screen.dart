import 'package:bike_shop_app/models/item.dart';
import 'package:bike_shop_app/models/motor.dart';
import 'package:bike_shop_app/screens/main/home/cart_screen.dart';
import 'package:bike_shop_app/screens/main/home/widgets/build_header.dart';
import 'package:bike_shop_app/utils/theme.dart';
import 'package:bike_shop_app/viewModels/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SparepartScreen extends StatefulWidget {
  final Motor motor;
  final List<Item> item;
  const SparepartScreen({Key? key, required this.motor, required this.item}) : super(key: key);

  @override
  State<SparepartScreen> createState() => _SparepartScreenState();
}

class _SparepartScreenState extends State<SparepartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            buildHeader(context, 'Sparepart'),
            Expanded(child: _buildContent(context)),
          ],
        ),
      ),
      floatingActionButton: FittedBox(
        child: Stack(
          alignment: const Alignment(1.5, -3.0),
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(motor: widget.motor),
                  ),
                );
              },
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 25,
              ),
              backgroundColor: darkBlue500,
            ),
            Consumer<CartProvider>(builder: (context, value, _) {
              if (value.items.isEmpty) {
                return const SizedBox();
              }

              return Container(
                child: Center(
                  child: Text(value.items.length.toString(), style: titleTextStyle.copyWith(fontSize: 18.0)),
                ),
                padding: const EdgeInsets.all(8),
                constraints: const BoxConstraints(minHeight: 24, minWidth: 24),
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(spreadRadius: 1, blurRadius: 5, color: Colors.black.withAlpha(50))],
                  shape: BoxShape.circle,
                  color: colorYellow,
                ),
              );
            }),
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
                    widget.motor.motorType,
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
                  width: 80,
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
                        maxLines: 1,
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
                          icon: const Icon(Icons.shopping_bag_rounded),
                          onPressed: () {
                            context.read<CartProvider>().addToCart(item);
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
    });
  }
}
