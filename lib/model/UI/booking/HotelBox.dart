import 'package:flutter/material.dart';

class HotelBox extends StatelessWidget {
  late final List<String> _dati;


  late final bool format;

  HotelBox(List<String> datiHotelBox){
    if (datiHotelBox.isEmpty) {
      datiHotelBox.add("Nessun hotel da suggerire \nper il tag selezionato");
      format = false;
    } else {
      format = true;
    }
    _dati = datiHotelBox;
  }

  Widget build(BuildContext context) {
    return Container(
          height:400,
          width:350,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black, // Colore del bordo
              width: 2.0, // Spessore del bordo
            ),
          ),
          margin:EdgeInsets.all(15) ,
          child:
            Scaffold(
              appBar: AppBar(title: Text("Hotel consigliati per i tag scelti")),
              body :Scrollbar(
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
                                  color: Colors.blue[50],
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
    if (format) {
      List<String> parole = string.split(" ");
      if (parole.length >= 5) {
        // Prendo le prime tre parole e le ultime due parole
        String primaParte = parole.sublist(0, 3).join(" ");
        String secondaParte = parole.sublist(parole.length - 2).join(" ");
        return '$primaParte,\n $secondaParte';
      } else {
        return '';
      }
    }
    return string;
  }
}
