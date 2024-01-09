import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jolly/misurazione.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedOption = 'oggi'; // Valore predefinito

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter HTTP Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: selectedOption,
              onChanged: (String? newValue) {
                setState(() {
                  selectedOption = newValue!;
                });
              },
              items: <String>['oggi', 'settimana', 'mese'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                fetchData(selectedOption);
              },
              child: Text('Esegui Chiamata HTTP'),
            ),
            SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              series: [
                BarSeries(xValueMapper:(Misurazione misurazioni) => misurazioni.data ,
                    yValueMapper: (Misurazione misurazioni) => misurazioni.pm20
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Future<void> fetchData(String option) async {
  // Sostituisci con la tua URL di API
  String apiUrl = 'https://example.com/data';

  // Aggiungi eventuali parametri alla richiesta HTTP in base all'opzione selezionata
  Map<String, String> queryParams = {'option': option};
  String queryString = Uri(queryParameters: queryParams).query;
  String url = '$apiUrl?$queryString';

  // Esegui la richiesta HTTP
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // Elabora i dati ricevuti
    var data = jsonDecode(response.body);
    print(data);
    List<Misurazione> misurazioni = creaListaMisurazioniDaJson(data);
    // Aggiorna l'interfaccia utente o salva i dati come necessario

  } else {
    // Gestisci gli errori di richiesta HTTP
    print('Errore nella richiesta HTTP: ${response.reasonPhrase}');
  }
}
