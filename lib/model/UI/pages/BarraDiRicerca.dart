import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BarraDiRicerca extends StatefulWidget {
  BarraDiRicerca({Key? key}) : super(key: key);
  @override
  BarraDiRicercaState createState() => BarraDiRicercaState();
}

class BarraDiRicercaState extends State<BarraDiRicerca> {

  List<String> _campiMenuTendina = [
    "Francese",
    "Spagnolo",
    "Inglese",
    "Poloacco",
    "Rumeno",
    "Ungherese",
    "Moldavo",
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G"
  ];

  List<String> _campiSelezionati=[];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 500,
        width:500,
        child: Row(
          children: [
            Row(
              children: [
                SizedBox(width: 10.0),
                DropdownButton<String>(
                  value: null, // Imposta il valore solo se è stato selezionato
                  onChanged: (String? newValue) {
                    setState(() {
                      _campiSelezionati.add(newValue!);
                      _campiMenuTendina.remove(newValue);
                    });
                  },
                  items: _campiMenuTendina.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _campiSelezionati
                    .map(
                      (string) => Container(
                        padding: EdgeInsets.all(8.0),
                        margin: EdgeInsets.symmetric(vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Colors.lime[200],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      child:
                          Row(
                            children:[
                              Text(
                                string,
                                style: TextStyle(fontSize: 16.0),
                              ),
                              SizedBox( width:20),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _campiSelezionati.remove(string);
                                    _campiMenuTendina.add(string);
                                  });
                                },
                                child:
                                  SizedBox(
                                    width: 30,
                                    child:
                                      Icon(Icons.close)
                                  ),
                              ),
                            ],
                          )
                  ),
                ).toList(),
              )
          ],
        ),
      );
  }

  List<String> getCampiSelezionati(){
    return _campiSelezionati;
  }
}