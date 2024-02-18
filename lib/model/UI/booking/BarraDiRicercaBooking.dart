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
  List<String> _campiMenuTendinaCorrenti=[];


  @override
  void initState() {
    super.initState();
    _campiMenuTendinaCorrenti=widget.campiMenuTendina;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          SizedBox( height: 10,  width: 15),
          SizedBox(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Seleziona i tag che preferisci", style: TextStyle( fontSize:20, fontWeight: FontWeight.bold, color: Colors.blue)),
                  SizedBox(height:50),
                  MenuTendina(),
                ]
              )
          ),
          SizedBox( height: 10,  width: 30),
          Container(
              decoration: BoxDecoration(
                border: Border.all( color: Colors.black, width: 2.0),
              ),
              width:250,
              height:400,
              child: Scaffold(
                appBar: AppBar(title: Text("Tag selezionati")),
                body: TagSelezionatiBox()
              )
          ),
          SizedBox(width: 20),
          Container(
              decoration: BoxDecoration(
                  border: Border.all( color: Colors.black, width: 2.0),
              ),
              width:250,
              height:400,
              child: Scaffold(
                  appBar: AppBar(
                      title: Text("Spesso gli utenti \n selezionano anche...",
                          style: TextStyle( fontSize: 20)
                      )
                  ),
                  body: TagSuggeritiBox()
              )
          ),
        ]
      );
  }


  Widget MenuTendina(){
    return DropdownButton<String>(
      value:null,
      items: _campiMenuTendinaCorrenti.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _campiMenuTendinaCorrenti.remove(newValue!);
          _campiSelezionati.add(newValue!);
          widget.aggiorna();
        });
      },
    );
  }

  Widget TagSelezionatiBox(){
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _campiSelezionati.map((string) => Container(
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.symmetric(vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children:[
                    Text( string,  style: TextStyle(fontSize: 14), ),
                    GestureDetector(
                      child:  Icon(Icons.close),
                      onTap: () {
                        setState(() {
                          _campiSelezionati.remove(string);
                          _campiMenuTendinaCorrenti.add(string);
                          widget.aggiorna();
                        });
                      },
                    ),
                  ],
                )
              ),
          ).toList(),
        )
    );
  }

  Widget TagSuggeritiBox(){
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widget.tagSuggeriti.map( (string) => Container(
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.symmetric(vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.yellow[50],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child:
                  Row(
                    children:[
                      Text( string, style: TextStyle(fontSize: 13)),
                      GestureDetector(
                        child: Icon(Icons.add),
                        onTap: () {
                          setState(() {
                            _campiSelezionati.add(string);
                            widget.tagSuggeriti.remove(string);
                            widget.aggiorna();
                          });
                        },
                      ),
                    ],
                )
            ),
          ).toList(),
        )
    );
  }


  List<String> getCampiSelezionati(){
    return _campiSelezionati;
  }

}