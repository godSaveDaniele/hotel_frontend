import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_frontend/model/UI/pages/Istogramma.dart';
import '../../Model.dart';
import 'BarraDiRicerca.dart';

class AnalisiNazionalitaScore extends StatefulWidget{

  @override
  _AnalisiState createState() => _AnalisiState();
}

class _AnalisiState extends State<AnalisiNazionalitaScore> {
  GlobalKey<BarraDiRicercaState> childKey = GlobalKey<BarraDiRicercaState>();
  bool loading = true;
  late Map<String, double> dati;
  late List<String> campiSelezionati;

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
    campiSelezionati=childKey.currentState!.getCampiSelezionati();
    Map<String, double> datiIstogramma = seleziona(dati, campiSelezionati);
    return Row(
        children:[
          BarraDiRicerca(key: childKey),
          bottone(),
          Istogramma(datiIstogramma)
        ]
    );
  }

  Widget bottone(){
    return ElevatedButton(
      onPressed:setState(() {
        print("prova");
      }),
      child: Text("Ottieni istogramma"),
    );
  }


  Future<void> _getData() async {
    dati= (await Model.sharedInstance.getNationalityScore())!;
    setState(() {
      loading = false;
    });
  }

  Map<String, double> seleziona(Map<String, double> dati, List<String> campiSelezionati) {
    Map<String, double> ris= {};
    for (String campo in campiSelezionati){
      ris[campo]=dati[campo]!;
    }
    return ris;
  }
}