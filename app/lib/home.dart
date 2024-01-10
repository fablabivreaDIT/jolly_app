import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jolly/measure.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:jolly/lineChartExample.dart';
import 'package:jolly/graficone.dart';



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedOption = 'oggi'; // Valore predefinito


  List<Measure> misurazioni = List.empty();


  GlobalKey<GraficoneState> childKey = GlobalKey();



  @override
  Widget build(BuildContext context) {
    print(misurazioni.isEmpty);
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
            /*SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              series: [
                BarSeries(xValueMapper:(int index) => misurazioni.elementAt(index).pm10) ,
                    yValueMapper: (int index) => misurazioni.elementAt(index).pm20)
                )
              ],
            )*/
            /*misurazioni.isNotEmpty ? SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                // Chart title
                title: ChartTitle(text: 'Half yearly sales analysis'),
                // Enable legend
                legend: Legend(isVisible: true),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CartesianSeries<Measure, String>>[
                  LineSeries<Measure, String>(
                      dataSource: misurazioni,
                      xValueMapper: (Measure mes, _) => mes.date,
                      yValueMapper: (Measure mes, _) => mes.pm10,
                      name: 'Sales',
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true))
                ]) : SizedBox(),
            misurazioni.isNotEmpty ? Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                //Initialize the spark charts widget
                child: SfSparkLineChart.custom(
                  //Enable the trackball
                  trackball: SparkChartTrackball(
                      activationMode: SparkChartActivationMode.tap),
                  //Enable marker
                  marker: SparkChartMarker(
                      displayMode: SparkChartMarkerDisplayMode.all),
                  //Enable data label
                  labelDisplayMode: SparkChartLabelDisplayMode.all,
                  xValueMapper: ((int index) {misurazioni[index].date;misurazioni[index].stampa();}),
                  yValueMapper: (int index) => misurazioni[index].pm10,
                  dataCount: misurazioni.length,
                ),
              ),
            ) : SizedBox(),*/


            Graficone(scelta: selectedOption, misurazioni: misurazioni, key: childKey,)




        ]),
      ),
    );
  }



  Future<void> fetchData(String option) async {
    print("sono stata avuto girata");
    // Sostituisci con la tua URL di API
    String apiUrl = 'https://example.com/data';

    // Aggiungi eventuali parametri alla richiesta HTTP in base all'opzione selezionata
    Map<String, String> queryParams = {'option': option};
    String queryString = Uri(queryParameters: queryParams).query;
    String url = '$apiUrl?$queryString';
    print(url);

    // Esegui la richiesta HTTP
    final response = await http.get(Uri.parse(url));
    
    List<Measure> misurazioniTMP = Measure.creaListaMisurazioniDaJson('[{"pm10":"2","pm20":"10","date":"04:15"},{"pm10":"5","pm20":"10","date":"08:30"},{"pm10":"10","pm20":"7","date":"10:30"},{"pm10":"8","pm20":"1","date":"14:00"},{"pm10":"8","pm20":"4","date":"18:15"},{"pm10":"4","pm20":"4","date":"21:45"},{"pm10":"2","pm20":"4","date":"23:00"}]');
    setState(() {
      misurazioni = misurazioniTMP;
    });
    childKey.currentState?.updateMisurazioni(misurazioni);
    print(misurazioni);
    print(misurazioni.first.pm10);
    print(misurazioni.isEmpty);
    return;


    if (response.statusCode == 200) {
      // Elabora i dati ricevuti
      var data = jsonDecode(response.body);
      print(data);
      List<Measure> misurazioni = Measure.creaListaMisurazioniDaJson(data);
      // Aggiorna l'interfaccia utente o salva i dati come necessario

    } else {
      // Gestisci gli errori di richiesta HTTP
      print('Errore nella richiesta HTTP: ${response.reasonPhrase}');
    }
  }



}

