import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Istogramma extends StatelessWidget {
  final Map<String, double> data;

  Istogramma(this.data);

  @override
  Widget build(BuildContext context) {
    List<BarChartGroupData> barGroups = [];
    data.forEach((key, value) {
      List<BarChartRodData> astine = [];
        astine.add(BarChartRodData(y: value, colors: [Colors.red]));

      barGroups.add(BarChartGroupData(
        x: data.keys.toList().indexOf(key),
        barRods: astine,
      ));
    });

    return Container(
      child: Center(
        child: SizedBox(
          width: 500,
          height:200,
          child: BarChart(
                BarChartData(
                  backgroundColor: Colors.yellow.withOpacity(0.1),
                  alignment: BarChartAlignment.spaceAround,
                  minY: data.values.toList().reduce(min) -2,
                  maxY: data.values.toList().reduce(max) + 0.5,
                  barGroups: barGroups,
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: SideTitles(
                      showTitles: true,
                      rotateAngle: 45,
                      getTextStyles: (value) => const TextStyle(
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
    );
  }
}

