
import 'package:flutter/material.dart';

class HotelBox extends StatelessWidget {
  late final List<String> _dati;

  HotelBox(List<String> datiHotelBox){
    _dati = datiHotelBox;
  }

  Widget build(BuildContext context) {
    return
    SizedBox(
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black, // Colore del bordo
              width: 1.0, // Spessore del bordo
            ),
          ),
          margin:EdgeInsets.all(30) ,
          child:
          Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                  controller: new ScrollController(
                    keepScrollOffset: true
                  ), // Necessario altrimenti non si puo' afferrare la barra
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: _dati.map(
                            (string) => SizedBox(
                          child: Container(
                              padding: EdgeInsets.all(8.0),
                              margin: EdgeInsets.symmetric(vertical: 4.0),
                              decoration: BoxDecoration(
                                color: Colors.red[200],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child:
                              Row(
                                children:[
                                  Text(
                                    modifyHotelString(string),
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              )
                          ),
                        )


                    ).toList(),
                  )
              )
          )

      )
    );

  }

  String modifyHotelString(String string) {
    List<String> parole  = string.split(" ");
    if (parole.length >= 5) {
      // Prendo le prime tre parole e le ultime due parole
      String primaParte = parole.sublist(0, 3).join(" ");
      String secondaParte = parole.sublist(parole.length - 2).join(" ");

      return '$primaParte, $secondaParte';
    } else { return ''; }
  }
}
