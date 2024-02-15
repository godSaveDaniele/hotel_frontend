import 'package:flutter/material.dart';
import '../analisys/ClassificazioneNazionalità.dart';
import 'AnalisiNazionalitaScore.dart';
import 'AnalisiNazionePercentage.dart';


import '../analisys/WordCloudNationality.dart';



class Layout2 extends StatefulWidget {
  @override
  _Layout2State createState() => _Layout2State();
}

class _Layout2State extends State<Layout2> with SingleTickerProviderStateMixin {
  int paginaCorrente=-1;

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Analisi recensioni hotel di lusso europei")),
      body: Center(
        child: _visualizzaPagina(),
      ),
      drawer: Drawer(
          child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text("Menù",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ExpansionTile(
                  title: Text('Analisi dei dati'),
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.bar_chart),
                      title: Text("Score medio per nazionalità"),
                      onTap: () {
                        setState(() {
                          paginaCorrente=0;
                        });
                        Navigator.pop(context); // Chiudi il Drawer
                      },
                    ),
                    ListTile(
                        leading: Icon(Icons.pie_chart),
                        title: Text("Nazioni europee con migliori hotel"),
                        onTap: () {
                          setState(() {
                            paginaCorrente = 1;
                          });
                          Navigator.pop(context); // Chiudi il Drawer
                        }
                    ),
                    ListTile(
                        leading: Icon(Icons.abc),
                        title: Text("WordCloud per nazionalità"),
                        onTap: () {
                          setState(() {
                            paginaCorrente = 2;
                          });
                          Navigator.pop(context); // Chiudi il Drawer
                        }
                    ),
                    ListTile(
                        leading: Icon(Icons.pie_chart),
                        title: Text("Classificazione della significatività per nazionalità"),
                        onTap: () {
                          setState(() {
                            paginaCorrente = 3;
                          });
                          Navigator.pop(context); // Chiudi il Drawer
                        }
                    ),
                  ],
                ),
                ExpansionTile(
                    title: Text('Booking'),
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.bar_chart),
                        title: Text("Booking fittizio"),
                        onTap: () {
                          setState(() {
                            paginaCorrente=4;
                          });
                          Navigator.pop(context); // Chiudi il Drawer
                        },
                      )
                    ]
                )
              ]
          )
      ),
    );
  }


  _visualizzaPagina(){
    switch(paginaCorrente){
      case(0):return AnalisiNazionalitaScore();
      case(1):return AnalisiNazionePercentage();
      case(2):return Function1();
      case(3):return Function2();
    }
  }
}
