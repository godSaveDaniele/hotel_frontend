import 'dart:math';

import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../Model.dart';

class AnalisiNazionePercentage extends StatefulWidget{

  @override
  _AnalisiState createState() => _AnalisiState();
}

class _AnalisiState extends State<AnalisiNazionePercentage> {
  bool loading = true;
  late Map<String, List<dynamic>> dati;
  Map<String, bool> graficiInseriti={"Italy":false, "Netherlands": false, "France":false, "Spain":false, "Kingdom":false, "Austria":false};


  @override
  Widget build(BuildContext context) {
    if (loading) {
      _getData();
      return Scaffold(
          body:
          Center(
              child: CircularProgressIndicator()
          )
      );
    } else {
      return contenuto();
    }
  }

  Widget contenuto() {
    return Center(
        child: Row(
        children: [
          Column(
            children: [
              Grafico("France"),
              Legenda(),
            ]
          ),
          Column(
            children:[
              Grafico("Kingdom"),
              SizedBox(height:20),
              Grafico("Spain"),
            ]
          ),
          Column(
            children: [
              Titolo(),
              Mappa(),
              StrisciaSfumata(),
            ]
          ),
          Column(
            children:[
              Grafico("Netherlands"),
              SizedBox(height:20),
              Grafico("Italy"),
            ]
          ),
          Grafico("Austria"),
        ]
      )
    );
  }

  Widget Titolo(){
    return Padding(
      padding: EdgeInsets.only(bottom:10, top:10),
      child:Column(
        children: [
          Text(
          "Quali sono le nazioni europee con gli hotel migliori?",
          style: TextStyle (
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          )
        ),
          Text(
              "Clicca su una nazione per visualizzare in dettaglio",
              style: TextStyle (
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              )
          ),
        ]
      )
    );
  }
  Widget Mappa() {
    print(Model.sharedInstance.getNationPercentage());
    TransformationController controller = TransformationController();
    controller.value =
    Matrix4.identity() // Imposta la trasformazione iniziale a identità
      ..translate(-800, -80)
      ..scale(4);
    return Center(
        child: Container(
            width: 500, // Larghezza desiderata dell'immagine ritagliata
            height: 250,
            child: InteractiveViewer(
              minScale: 0.1,
              maxScale: 5.0,
              transformationController: controller,
              scaleEnabled: true,
              boundaryMargin: EdgeInsets.all(20),
              child: SimpleMap(
                // String of instructions to draw the map.
                instructions: SMapWorld.instructions,
                fit: BoxFit.cover,

                // Default color for all countries.
                defaultColor: Colors.grey,

                // Matching class to specify custom colors for each area.
                colors: SMapWorldColors(
                    fR: getColorFromValue(getValueFromNation("France")),
                    eS: getColorFromValue(getValueFromNation("Spain")),
                    iT: getColorFromValue(getValueFromNation("Italy")),
                    nL: getColorFromValue(getValueFromNation("Netherlands")),
                    aT: getColorFromValue(getValueFromNation("Austria")),
                    gB: getColorFromValue(getValueFromNation("Kingdom"))
                ).toMap(),
                callback: (id, name, tapdetails) {
                  Map<String, String> stati={"it":"Italy","nl": "Netherlands", "fr":"France","es": "Spain", "gb":"Kingdom", "at":"Austria"};
                  setState(() {
                    graficiInseriti[stati[id]!]=true;
                  });
                },
              ),
            )
        )
    );
  }

  Widget Grafico(String nazione){
    return SizedBox(
      width:190,
      height:180,
      child: graficiInseriti[nazione]!?PieChartWidget(nazione):SizedBox()
    );
  }

  Widget PieChartWidget(String nazione) {
    return Column(
        children: [
          SizedBox(
            height:35,
            width:190,
            child: Text(nazione,
              style: const TextStyle(
                fontSize: 20, // Modifica la dimensione del carattere
                fontWeight: FontWeight.bold, // Rende il testo in grassetto
                color: Colors.blue, // Cambia il colore del testo
                letterSpacing: 2, // Modifica lo spaziamento tra i caratteri
              ),
            ),
          ),
          SizedBox(
            height:145,
            width:190,
              child:
                  PieChart(
                    PieChartData(
                      sections: pieChartSections(nazione),
                      sectionsSpace: 3,
                      centerSpaceRadius: 25,
                      startDegreeOffset: 180,
                      borderData: FlBorderData(show: false),
                    ),
                  ),
            )
      ]
    );
  }
  Widget Legenda(){
    return SizedBox(
      height:100,
      width:170,
      child:
        Stack(
        children: [
          Positioned(
              top: 20,
              child: _buildLegendItem(Colors.blue, "Hotel scarsi")
          ),
          Positioned(
              top: 50,
              child: _buildLegendItem(Colors.green, "Hotel intermedi")
          ),
          Positioned(
              top: 80,
              child: _buildLegendItem(Colors.red, "Hotel eccellenti")
          ),
        ]
      )
    );
  }


  List<PieChartSectionData> pieChartSections(String nazione) {
    return List.generate(3, (i) {
      final isTouched = (i == 1);
      final double radius = isTouched ? 45 :45;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: dati[nazione]?[i].toDouble(),
            title: dati[nazione]![i].toStringAsFixed(2) +"%",
            titleStyle: TextStyle (color: Colors.black,fontWeight: FontWeight.bold, fontSize: 15),
            radius: radius,
            );
        case 1:
          return PieChartSectionData(
            color: Colors.green,
            value: dati[nazione]?[i].toDouble(),
            title: dati[nazione]![i].toStringAsFixed(2) +"%",
            radius: radius,
            titleStyle: TextStyle (color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.red,
            value: dati[nazione]?[i].toDouble(),
            title: dati[nazione]![i].toStringAsFixed(2) +"%",
            titleStyle: TextStyle (color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
          );
        default:
          throw Error();
      }
    });

  }

    Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        SizedBox(width: 4),
        Text(label,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ],
      );
    }

    Widget StrisciaSfumata(){
      return Row(
        children: [
          Text( "NAZIONE CON UN BASSO \n TASSO DI HOTEL BUONI",
            style: TextStyle(fontSize:10, fontWeight: FontWeight.bold),
          ),
          Container(
            margin: EdgeInsets.all(15),
            width: 200,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.deepPurple],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              border: Border.all(color: Colors.black, width: 1),
            ),
          ),
            Text( "NAZIONE CON UN ELEVATO \n TASSO DI HOTEL BUONI",
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)
            )
        ]
      );
    }

  Future<void> _getData() async {
    dati = (await Model.sharedInstance.getNationPercentage())!;
    setState(() {
      loading = false;
    });
  }

// Funzione che restituisce il value per la colorazione di una certa nazione
  double  getValueFromNation(String nation){
    return dati[nation]?.last.toDouble()/dati[nation]?.first.toDouble();
  }


// Funzione per convertire un valore in un colore sulla base di una gradazione
  Color? getColorFromValue(double value) {
    double maxValue = dati.keys.map(getValueFromNation).reduce(max);
    double minValue = dati.keys.map(getValueFromNation).reduce(min);
    Color startColor = Colors.white;
    Color endColor = Colors.deepPurple;

    double percent = (value  - minValue+0.3) / (maxValue - minValue +0.3);
    Color? interpolatedColor = Color.lerp(startColor, endColor, percent);
    return interpolatedColor;
  }

}