import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../tools/Analisi2.dart';
import '../tools/Communicator.dart';


class Function2 extends StatefulWidget {

  @override
  _Function2 createState() => _Function2();

}

class _Function2 extends State<Function2> {

  @override
  void initState() {
    super.initState();
    Communicator.sharedInstance.setAggiornaStato2(aggiorna);
    Communicator.sharedInstance.loadNationality();
  }

  aggiorna(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Analisi2();
  }

}