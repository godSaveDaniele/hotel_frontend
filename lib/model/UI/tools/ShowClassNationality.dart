import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hotel_frontend/model/UI/tools/Communicator.dart';

class Analisi2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Communicator.sharedInstance.nationalityLoaded
      ? Scaffold(
        body: Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // DropdownButton a sinistra
                  DropdownButton<String>(
                    value: null, // Lasciare null
                    onChanged: (String? newValue) {
                      Communicator.sharedInstance.getNationalityClass(newValue!);
                    },
                    items: Communicator.sharedInstance.nationalityList
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
    )
      : Center(
        child: CircularProgressIndicator(
        strokeWidth: 2, // Imposta lo spessore della linea del cerchio
        ),
    );
  }
}

class PieChartWidget extends StatelessWidget {
  final List<Color> classColors = [Colors.blue, Colors.green, Colors.red];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child:
        Stack(
          alignment: Alignment.topCenter,
            children: [

                  Positioned(
                      left: 15,
                      child: Text(Communicator.sharedInstance.nationalitySelected,
                        style: TextStyle(
                        fontSize: 20, // Modifica la dimensione del carattere
                        fontWeight: FontWeight.bold, // Rende il testo in grassetto
                        color: Colors.blue, // Cambia il colore del testo
                        letterSpacing: 2, // Modifica lo spaziamento tra i caratteri
                      ),)
                  ),

                  Communicator.sharedInstance.nationalityClassificationLoaded
                      ?
                      Stack(
                        children: [
                          PieChart(
                            swapAnimationDuration: const Duration(milliseconds: 750),
                            swapAnimationCurve: Curves.easeInOutQuint, // animazione della modifica delle curve del grafico
                            PieChartData(
                              sections: pieChartSections(),
                              sectionsSpace: 0,
                              centerSpaceRadius: 40,
                              startDegreeOffset: 180,
                              borderData: FlBorderData(show: false),
                              //pieTouchData: PieTouchData(touchCallback: (FlTouchEvent event, pieTouchResponse) {}),
                            ),
                          ),
                           Positioned(
                             top: 300,
                               child: _buildLegendItem(Colors.blue, 'Classe 1')
                           ),
                          Positioned(
                              top: 330,
                              child: _buildLegendItem(Colors.green, 'Classe 2')
                          ),
                          Positioned(
                              top: 360,
                              child: _buildLegendItem(Colors.red, 'Classe 3')
                          ),

                        ],
                      )

                      : Text(""),

                  Communicator.sharedInstance.sendingRequest
                      ? Positioned(
                        top: 30,
                        left: 35,

                        child: CircularProgressIndicator( strokeWidth: 2 ) // Imposta lo spessore della linea del cerchio
                        )
                      : Text("")

                ],
              )


        );

  }

  List<PieChartSectionData> pieChartSections() {
      Map<String, double> classified = Communicator.sharedInstance.classification;
      List<PieChartSectionData> result = [];

      for (int i = 0; i < 3; i++) {
        String ind = i.toString();
        if (classified[ind] != 0)
          result.add(PieChartSectionData(
            color: classColors[i],
            value: classified[ind],
            title: classified[ind]!.toInt().toString()+"%",
            radius: i == 1? 60:50,
            //titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.white),
          ));
      }

      return result;
    }



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
      Text(label),
    ],
  );
}
