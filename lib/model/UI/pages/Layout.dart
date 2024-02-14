import 'package:flutter/material.dart';

import 'Analisi.dart';
import 'Prenotazione.dart';


class Layout extends StatelessWidget {
  final String title;


  const Layout({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold( //contenitore di un pannello
        appBar: AppBar( //barra dell'applicazione

          title: Text(title),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Analisi"),
              Tab(text: "Prenotazione"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Analisi(),
            Prenotazione()
          ],
        ),
      ),
    );
  }
}

