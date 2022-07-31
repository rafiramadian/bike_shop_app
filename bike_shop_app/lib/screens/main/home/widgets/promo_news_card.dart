import 'package:flutter/material.dart';

import '../../../../utils/theme.dart';

class PromoNewsListView extends StatelessWidget {
  final String title;
  final List item;
  const PromoNewsListView({
    Key? key,
    required this.title,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> itemList = [];
    for (int i = 0; i < item.length; i++) {
      itemList.add(PromoNewsCard(imageAsset: item[i]));
      itemList.add(const SizedBox(width: 16.0));
    }
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          16.0,
          20.0,
          0.0,
          0.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: subtitleTextStyle.copyWith(
                color: darkBlue500,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: itemList,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PromoNewsCard extends StatelessWidget {
  final String imageAsset;
  const PromoNewsCard({
    Key? key,
    required this.imageAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: primaryColor500,
      borderRadius: BorderRadius.circular(6),
      onTap: () {},
      child: Container(
        height: 120,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              'assets/images/$imageAsset',
            ),
          ),
        ),
      ),
    );
  }
}
