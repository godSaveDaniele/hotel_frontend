

import 'package:flutter/material.dart';


class BarraDiRicercaBooking extends StatefulWidget {
  final VoidCallback aggiorna;
  final List<String> campiMenuTendina;
  final List<String> tagSuggeriti;
  BarraDiRicercaBooking({Key? key, required this.aggiorna, required this.campiMenuTendina, required this.tagSuggeriti}) : super(key: key);

  @override
  BarraDiRicercaBookingState createState() => BarraDiRicercaBookingState();
}

class BarraDiRicercaBookingState extends State<BarraDiRicercaBooking> {

  List<String> _campiSelezionati=[];

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          SizedBox(
            height: 10,
            width: 20,
          ),

          SizedBox(
              height: 30,
              width: 300,
              child:
              DropdownButton<String>(
                value:null,
                onChanged: (String? newValue) {
                  setState(() {
                    if(!_campiSelezionati.contains(newValue))
                      _campiSelezionati.add(newValue!);
                    widget.aggiorna();
                  });
                },
                items: widget.campiMenuTendina.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
          ),

          SizedBox(
            height: 10,
            width: 30,
          ),
          SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _campiSelezionati
                  .map(
                    (string) => Container(
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.green[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child:
                    Row(
                      children:[
                        Text(
                          string,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _campiSelezionati.remove(string);
                              widget.aggiorna();
                            });
                          },
                          child:
                          SizedBox(
                              child:
                              Icon(Icons.close)
                          ),
                        ),
                      ],
                    )
                  ),
              ).toList(),
            )
          ),
          SizedBox(width: 20),
          SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: widget.tagSuggeriti
                    .map(
                      (string) => Container(
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.yellow[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child:
                      Row(
                        children:[
                          Text(
                            string,
                            style: TextStyle(fontSize: 16.0),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _campiSelezionati.add(string);
                                widget.tagSuggeriti.remove(string);
                                widget.aggiorna();
                              });
                            },
                            child:
                            SizedBox(
                                child:
                                Icon(Icons.add)
                            ),
                          ),
                        ],
                      )
                  ),
                ).toList(),
              )
          ),


        ],
    );
  }

  List<String> getCampiSelezionati(){
    return _campiSelezionati;
  }

}