import 'package:bike_shop_app/models/item.dart';
import 'package:bike_shop_app/utils/theme.dart';
import 'package:flutter/material.dart';

final List<Item> sparepartHonda = [
  Item(
    namaItem: 'Headlamp',
    deskripsiItem: 'Headlamp Honda',
    hargaItem: 50000,
    image: 'headlamp_honda.png',
  ),
  Item(
    namaItem: 'Filter',
    deskripsiItem: 'Filter Honda',
    hargaItem: 50000,
    image: 'filter_honda.png',
  ),
  Item(
    namaItem: 'Roller',
    deskripsiItem: 'Roller Honda',
    hargaItem: 50000,
    image: 'roller_honda.png',
  ),
  Item(
    namaItem: 'Rumah Roller',
    deskripsiItem: 'Rumah Roller Honda',
    hargaItem: 50000,
    image: 'rumah_roller_honda.png',
  ),
  Item(
    namaItem: 'Shockbreaker',
    deskripsiItem: 'Shockbreaker Honda',
    hargaItem: 50000,
    image: 'shock_honda.png',
  ),
  Item(
    namaItem: 'Vanbelt',
    deskripsiItem: 'Vanbelt Honda',
    hargaItem: 50000,
    image: 'vanbelt_honda.png',
  ),
];

final List<Item> sparepartYamaha = [
  Item(
    namaItem: 'Headlamp',
    deskripsiItem: 'Headlamp Yamaha',
    hargaItem: 50000,
    image: 'headlamp_yamaha.png',
  ),
  Item(
    namaItem: 'Filter',
    deskripsiItem: 'Filter Yamaha',
    hargaItem: 50000,
    image: 'filter_yamaha.png',
  ),
  Item(
    namaItem: 'Roller',
    deskripsiItem: 'Roller Yamaha',
    hargaItem: 50000,
    image: 'roller_yamaha.png',
  ),
  Item(
    namaItem: 'Rumah Roller',
    deskripsiItem: 'Rumah Roller Yamaha',
    hargaItem: 50000,
    image: 'rumah_roller_yamaha.png',
  ),
  Item(
    namaItem: 'Shockbreaker',
    deskripsiItem: 'Shockbreaker Yamaha',
    hargaItem: 50000,
    image: 'shock_yamaha.png',
  ),
  Item(
    namaItem: 'Vanbelt',
    deskripsiItem: 'Vanbelt Yamaha',
    hargaItem: 50000,
    image: 'vanbelt_yamaha.png',
  ),
];

final List<Item> sparepartKawasaki = [
  Item(
    namaItem: 'Headlamp',
    deskripsiItem: 'Headlamp Kawasaki',
    hargaItem: 50000,
    image: 'headlamp_kawasaki.png',
  ),
  Item(
    namaItem: 'Gear',
    deskripsiItem: 'Gear Kawasaki',
    hargaItem: 50000,
    image: 'gear_kawasaki.png',
  ),
  Item(
    namaItem: 'Rantai',
    deskripsiItem: 'Rantai Kawasaki',
    hargaItem: 50000,
    image: 'rante_kawasaki.png',
  ),
];

final List<Item> servisBerat = [
  Item(
    namaItem: 'Tune Up',
    deskripsiItem: 'Pengecekan menyeluruh supaya kendaraan kembali optimal',
    hargaItem: 0,
    image: "",
  ),
  Item(
    namaItem: 'Servis Saluran Udara',
    deskripsiItem: 'Menggunakan X-TEN THROTTLE BODY INTAKE CLEANER',
    hargaItem: 19000,
    image: 'servis_saluran_udara.png',
  ),
  Item(
    namaItem: 'Servis CVT',
    deskripsiItem: 'Menggunakan X_TEN D&G CLEANER',
    hargaItem: 11000,
    image: 'servis_cvt.png',
  ),
  Item(
    namaItem: 'Servis CVT Belt',
    deskripsiItem: 'Menggunakan X_TEN CVT CONDITIONER BELT',
    hargaItem: 9000,
    image: 'servis_cvt_belt.png',
  ),
  Item(
    namaItem: 'Servis Injektor (ACU)',
    deskripsiItem: 'Menggunakan X-TEN AUTO CLEAN UP',
    hargaItem: 23000,
    image: 'servis_injektor.png',
  ),
  Item(
    namaItem: 'Pembersihan Endapan Oli (ATU)',
    deskripsiItem: 'Menggunakan X-TEN AUTO TUNE UP',
    hargaItem: 25000,
    image: 'endapan_oli.png',
  ),
];

final List<Item> servisRingan = [
  Item(
    namaItem: 'Tune Up',
    deskripsiItem: 'Pengecekan menyeluruh supaya kendaraan kembali optimal',
    hargaItem: 0,
    image: "",
  ),
  Item(
    namaItem: 'Servis Saluran Udara',
    deskripsiItem: 'Menggunakan X-TEN THROTTLE BODY INTAKE CLEANER',
    hargaItem: 19000,
    image: 'servis_saluran_udara.png',
  ),
  Item(
    namaItem: 'Servis CVT',
    deskripsiItem: 'Menggunakan X_TEN D&G CLEANER',
    hargaItem: 11000,
    image: 'servis_cvt.png',
  ),
  Item(
    namaItem: 'Servis CVT Belt',
    deskripsiItem: 'Menggunakan X_TEN CVT CONDITIONER BELT',
    hargaItem: 9000,
    image: 'servis_cvt_belt.png',
  ),
];

const List<String> promo = [
  'promo_1.png',
  'promo_2.png',
  'promo_3.png',
  'promo_4.png',
  'promo_5.png',
  'promo_6.png',
];

const List<String> news = [
  'news_1.png',
  'news_2.png',
  'news_3.png',
  'news_4.png',
  'news_6.png',
];

List<DropdownMenuItem<String>> get dropdownItems {
  final List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        child: Text(
          "Honda Beat",
          style: subtitleTextStyle.copyWith(fontSize: 14),
        ),
        value: "Honda Beat"),
    DropdownMenuItem(
        child: Text(
          "Yamaha Mio",
          style: subtitleTextStyle.copyWith(fontSize: 14),
        ),
        value: "Yamaha Mio"),
    DropdownMenuItem(
        child: Text(
          "Kawasaki Ninja",
          style: subtitleTextStyle.copyWith(fontSize: 14),
        ),
        value: "Kawasaki Ninja"),
  ];
  return menuItems;
}
