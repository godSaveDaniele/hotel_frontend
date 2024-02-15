import 'package:flutter/material.dart';
import 'AnalisiNazionalitaScore.dart';
import 'AnalisiNazionePercentage.dart';


import '../analisys/Function1.dart';



class Analisi extends StatefulWidget {
  @override
  _Analisi createState() => _Analisi();
}

class _Analisi extends State<Analisi> with SingleTickerProviderStateMixin {
  int paginaCorrente=-1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drawer Example'),
      ),
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
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Pagina 1'),
              onTap: () {
                setState(() {
                  paginaCorrente=0;
                });
                Navigator.pop(context); // Chiudi il Drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Pagina 2'),
              onTap: () {
                setState(() {
                  paginaCorrente = 0;
                });
                Navigator.pop(context); // Chiudi il Drawer},
              }
            ),
          ],
        ),
      ),
    );
  }


  _visualizzaPagina(){
    switch(paginaCorrente){
      case(-1): return Text("Benvenuto");
      case(0):return AnalisiNazionalitaScore();
      case(1):return AnalisiNazionePercentage();
    }
  }
}
    /*
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleziona la tipologia di analisi che desideri eseguire'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Nationality Selection'),
            Tab(text: 'Score medio per nazionalità'),
            Tab(text: 'Tab 3'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Function1(),
          Center(child: AnalisiNazionalitaScore()),
          AnalisiNazionePercentage(),
        ],
      ),
    );
  }
}
*/