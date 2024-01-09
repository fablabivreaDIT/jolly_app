import 'dart:convert';

class Misurazione{

  Misurazione({
    required this.pm20,
    required this.pm10,
    required this.co2,
    required this.data,
  });

  double pm20;
  double pm10;
  double co2;
  String data;

  factory Misurazione.fromJson(Map<String, dynamic> json) {
    return Misurazione(
      pm20: json['pm20'],
      pm10: json['pm10'],
      co2: json['co2'],
      data: json['data'],
    );
  }

  List<Misurazione> creaListaMisurazioniDaJson(dynamic data) {
    List<dynamic> misurazioniJson = data;

    List<Misurazione> listaMisurazioni = misurazioniJson
        .map((json) => Misurazione.fromJson(json))
        .toList();

    return listaMisurazioni;
  }
}