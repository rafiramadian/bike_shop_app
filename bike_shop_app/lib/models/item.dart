class Item {
  final String namaItem;
  final String deskripsiItem;
  final int hargaItem;
  final String? image;

  Item({required this.namaItem, required this.deskripsiItem, required this.hargaItem, this.image});

  factory Item.fromFirestore(Map<String, dynamic> json) => Item(
        namaItem: json["namaItem"],
        deskripsiItem: json["deskripsiItem"],
        hargaItem: json["hargaItem"],
        image: json["image"],
      );

  static Map<String, dynamic> toMap(Item item) => {
        "namaItem": item.namaItem,
        "deskripsiItem": item.deskripsiItem,
        "hargaItem": item.hargaItem,
        "image": item.image,
      };
}
