import 'dart:convert';

class Measure{

  Measure({
    required this.pm20,
    required this.pm10,
    required this.co2,
    required this.date
  });

  double pm20;
  double pm10;
  double co2;
  String date;

  factory Measure.fromJson(Map<String, dynamic> json) {
    print(json);
    print(json['pm20']);
    print(json['pm20'] != null ? json['pm20'] : 0);
    return Measure(
      pm20: json['pm20'] != null ? double.parse(json['pm20']) : 0,
      pm10: json['pm10'] != null ? double.parse(json['pm10']) : 0,
      co2: json['co2'] != null ? double.parse(json['co2']) : 0,
      date: json['date'] != null ? json['date'] : "",
    );
  }

  static List<Measure> creaListaMisurazioniDaJson(dynamic data) {
    List<dynamic> misurazioniJson = jsonDecode(data);

    List<Measure> listaMisurazioni = misurazioniJson
        .map((json) => Measure.fromJson(json))
        .toList();

    return listaMisurazioni;
  }

  void stampa() {
    print("${this.pm10} --- ${this.date}");
  }
}