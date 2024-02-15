import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Model.dart';

class BarraDiRicerca extends StatefulWidget {
  final VoidCallback aggiorna;
  BarraDiRicerca({Key? key, required this.aggiorna}) : super(key: key);

  @override
  BarraDiRicercaState createState() => BarraDiRicercaState();
}

class BarraDiRicercaState extends State<BarraDiRicerca> {

  List<String> _campiMenuTendina =[];
  List<String> _campiSelezionati=[];

  @override
  Widget build(BuildContext context) {
    _getNazionalita();
    return SizedBox(
        height: 500,
        width:650,
        child: Row(
          children: [
            Row(
              children: [
                SizedBox(width: 10.0),
                DropdownButton<String>(
                  value:null,
                  onChanged: (String? newValue) {
                    setState(() {
                      _campiSelezionati.add(newValue!);
                      _campiMenuTendina.remove(newValue);
                      widget.aggiorna();
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
            SizedBox(width: 20.0),
            Container(
              height:400,
              width:250,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Colore del bordo
                  width: 2.0, // Spessore del bordo
                ),
              ),
              margin:EdgeInsets.all(30) ,
              child:
                Scrollbar(
                  child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                        widget.aggiorna();
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
                  )
              )

            )
          ],
        ),
      );
  }

  Future<void> _getNazionalita() async {
    _campiMenuTendina= (await Model.sharedInstance.getAllNationality())!;
    setState(() {
    });
  }

  List<String> getCampiSelezionati(){
    return _campiSelezionati;
  }
}