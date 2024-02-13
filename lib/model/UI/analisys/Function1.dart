import 'package:flutter/material.dart';
import 'package:hotel_frontend/model/UI/tools/Communicator.dart';

import '../tools/SearchBar.dart';


class Function1 extends StatefulWidget {

  @override
  _Function1 createState() => _Function1();

}

class _Function1 extends State<Function1> {
  String? selectedCountry;

  @override
  void initState() {
    super.initState();
    Communicator.sharedInstance.setAggiornaStato(aggiorna);
  }

  aggiorna(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BarraDiRicerca();
  }
}