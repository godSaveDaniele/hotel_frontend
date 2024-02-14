import 'package:flutter/material.dart';

import '../analisys/Function1.dart';
import '../analisys/Function2.dart';


class Analisi extends StatefulWidget {
  @override
  _Analisi createState() => _Analisi();
}

class _Analisi extends State<Analisi> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // 3 è il numero di schede
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleziona la tipologia di analisi che desideri eseguire'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Nationality Selection'),
            Tab(text: 'Tab 2'),
            Tab(text: 'Clustering Nationality'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Function1(),
          Center(child: Text('Tab 2 content')),
          Function2(),
        ],
      ),
    );
  }
}

