class Motor {
  final String motorType;
  final String? nopol;
  final String? tahun;
  final int? kilometer;

  Motor({
    required this.motorType,
    this.nopol,
    this.tahun,
    this.kilometer,
  });

  factory Motor.fromFirestore(Map<String, dynamic> json) => Motor(
        motorType: json["motorType"],
        nopol: json["nopol"],
        tahun: json["tahun"],
        kilometer: json["kilometer"],
      );

  static Map<String, dynamic> toMap(Motor motor) => {
        "motorType": motor.motorType,
        "nopol": motor.nopol,
        "tahun": motor.tahun,
        "kilometer": motor.kilometer,
      };
}
