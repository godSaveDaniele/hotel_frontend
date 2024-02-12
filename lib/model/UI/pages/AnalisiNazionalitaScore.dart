import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_frontend/model/UI/pages/Istogramma.dart';

import '../../Model.dart';

class AnalisiNazionalitaScore extends StatefulWidget{

  @override
  _AnalisiState createState() => _AnalisiState();
}

class _AnalisiState extends State<AnalisiNazionalitaScore> {

  bool loading = true;
  late Map<String, double> dati;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      _getData();
      return Container(
          child:
          Center(
              child: CircularProgressIndicator()
          )
      );
    } else {
      return contenuto();
    }
  }

  Widget contenuto(){
    return Istogramma(dati);
  }


  Future<void> _getData() async {
    dati= (await Model.sharedInstance.getNationalityScore())!;
    setState(() {
      loading = false;
    });
  }
}