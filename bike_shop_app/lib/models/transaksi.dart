import 'package:bike_shop_app/models/item.dart';
import 'package:bike_shop_app/models/motor.dart';

class Transaksi {
  final String jenisPesanan;
  final String tanggalPesan;
  final String tanggalDatang;
  final int totalHarga;
  final List<Item> listPesanan;
  final Motor motor;
  final String? id;

  Transaksi({
    required this.jenisPesanan,
    required this.tanggalPesan,
    required this.tanggalDatang,
    required this.totalHarga,
    required this.listPesanan,
    required this.motor,
    this.id,
  });

  factory Transaksi.fromFirestore(Map<String, dynamic> json, String id) => Transaksi(
        id: id,
        jenisPesanan: json["jenisPesanan"],
        tanggalPesan: json["tanggalPesan"],
        tanggalDatang: json["tanggalDatang"],
        totalHarga: json["totalHarga"],
        listPesanan: Transaksi.fromListMap(json['listPesanan']),
        motor: Motor.fromFirestore(json["motor"]),
      );

  static Map<String, dynamic> toMap(Transaksi transaksi) => {
        "jenisPesanan": transaksi.jenisPesanan,
        "tanggalPesan": transaksi.tanggalPesan,
        "tanggalDatang": transaksi.tanggalDatang,
        "totalHarga": transaksi.totalHarga,
        "listPesanan": Transaksi.toListMap(transaksi.listPesanan),
        "motor": Motor.toMap(transaksi.motor),
      };

  static List<Item> fromListMap(List<dynamic> listJson) {
    return listJson.map((item) => Item.fromFirestore(item)).toList();
  }

  static List<Map<String, dynamic>> toListMap(List<Item> listItem) {
    return listItem.map((item) => Item.toMap(item)).toList();
  }
}
