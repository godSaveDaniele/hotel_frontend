import 'dart:math';

import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Model.dart';

class AnalisiNazionePercentage extends StatefulWidget{

  @override
  _AnalisiState createState() => _AnalisiState();
}

class _AnalisiState extends State<AnalisiNazionePercentage> {
  bool loading = true;
  late Map<String, List<dynamic>> dati;


  @override
  Widget build(BuildContext context) {
    if (loading) {
      _getData();
      return Container(
          child:
          Center(
              child: CircularProgressIndicator()
          )
      );
    } else {
      return contenuto();
    }
  }

  Widget contenuto() {
    return Mappa();
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
                  print(id);
                },
              ),
            )
        )
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
    Color endColor = Colors.red;

    double percent = (value  - minValue+0.3) / (maxValue - minValue +0.3);
    Color? interpolatedColor = Color.lerp(startColor, endColor, percent);
    return interpolatedColor;
  }

}