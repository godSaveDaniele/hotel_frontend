import 'package:flutter/material.dart';

import 'Analisi.dart';
import 'Prenotazione.dart';


class Layout extends StatelessWidget {
  final String title;


  const Layout({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold( //contenitore di un pannello
        appBar: AppBar( //barra dell'applicazione
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
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

