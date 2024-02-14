import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pie Chart with Legend'),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // DropdownButton a sinistra
                DropdownButton<String>(
                  value: 'Elemento 1',
                  onChanged: (String? newValue) {
                    // Azioni quando l'utente seleziona un nuovo valore
                  },
                  items: ['Elemento 1', 'Elemento 2', 'Elemento 3']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),

                // Diagramma a torta a destra
                PieChartWidget(),
              ],
            ),
          )
        ),
      ),
    );
  }
}

class PieChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: PieChart(
        PieChartData(
          sections: pieChartSections(),
          sectionsSpace: 0,
          centerSpaceRadius: 40,
          startDegreeOffset: 180,
          borderData: FlBorderData(show: false),
          pieTouchData: PieTouchData(touchCallback: (FlTouchEvent event, pieTouchResponse) {}),
        ),
      ),
    );
  }

  List<PieChartSectionData> pieChartSections() {
    return List.generate(4, (i) {
      final isTouched = i == 0;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: 40,
            title: 'A',
            radius: radius,
            //titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.white),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.green,
            value: 30,
            title: 'B',
            radius: radius,
            //titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.white),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.red,
            value: 20,
            title: 'C',
            radius: radius,
            //titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.white),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.orange,
            value: 10,
            title: 'D',
            radius: radius,
            //titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.white),
          );
        default:
          throw Error();
      }
    });
  }
}
