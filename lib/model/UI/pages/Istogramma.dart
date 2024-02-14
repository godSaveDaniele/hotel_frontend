import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Istogramma extends StatelessWidget {
  late final Map<String, double> data;

  Istogramma(Map<String, double> data){
    //ORDINO LA MAPPA PER VALORI
    List<double> values = data.values.toList();
    values.sort();
    Map<String, double> mappaOrdinata = {};
    values.forEach((valore) {
      data.forEach((chiave, valoreMappa) {
        if (valoreMappa == valore) {
          mappaOrdinata[chiave] = valoreMappa;
        }
      });
    });
    this.data=mappaOrdinata;
  }

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return SizedBox();
    } else {
      List<BarChartGroupData> barGroups = [];
      data.forEach((key, value) {
        List<BarChartRodData> astine = [];
        astine.add(BarChartRodData(y: value, colors: [Colors.red]));

        barGroups.add(BarChartGroupData(
          x: data.keys.toList().indexOf(key),
          barRods: astine,
        ));
      });

      return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text("Score medio sulla base delle nazionalità dei reviewer",
              style: TextStyle(
                fontSize: 20.0, // dimensione del carattere
                fontWeight: FontWeight.bold, // grassetto
              ),
            ),
            SizedBox(height: 20),
            Center(
                child: SizedBox(
                    width: 500,
                    height: 240,
                    child: BarChart(
                      BarChartData(
                        backgroundColor: Colors.yellow.withOpacity(0.1),
                        alignment: BarChartAlignment.spaceAround,
                        minY: data.values.toList().reduce(min) - 0.2,
                        maxY: data.values.toList().reduce(max) + 0.2,
                        barGroups: barGroups,
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: SideTitles(
                            showTitles: true,
                            rotateAngle: 45,
                            getTextStyles: (value) =>
                            const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            margin: 20,
                            getTitles: (double value) {
                              // Converti l'indice in una chiave dalla mappa per ottenere le etichette desiderate
                              if (value >= 0 && value < data.keys.length) {
                                return data.keys.elementAt(value.toInt());
                              }
                              return '';
                            },
                          ),
                        ),
                      ),
                    )
                )
            )
          ]
      );
    }
  }
}

