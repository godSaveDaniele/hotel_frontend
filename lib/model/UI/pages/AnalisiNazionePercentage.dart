import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Model.dart';

class AnalisiNazionePercentage extends StatefulWidget{

  @override
  _AnalisiState createState() => _AnalisiState();
}

class _AnalisiState extends State<AnalisiNazionePercentage> {
  bool loading = true;
  late Map<String, List<dynamic>> dati;


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
    return Mappa();
  }


  Widget Mappa(){
    print (Model.sharedInstance.getNationPercentage());
    TransformationController controller = TransformationController();
    controller.value = Matrix4.identity() // Imposta la trasformazione iniziale a identità
      ..translate(-800, -80)
      ..scale(4);
    return Center(
        child: Container(
          width: 500, // Larghezza desiderata dell'immagine ritagliata
          height: 250,
          child: InteractiveViewer(
            minScale: 0.1,
            maxScale: 5.0,
            transformationController: controller,
            scaleEnabled: true,
            boundaryMargin: EdgeInsets.all(20),
            child: SimpleMap(
              // String of instructions to draw the map.
              instructions: SMapWorld.instructions,
              fit: BoxFit.cover,

              // Default color for all countries.
              defaultColor: Colors.grey,

              // Matching class to specify custom colors for each area.
              colors: SMapWorldColors(
                  fR: Colors.blueAccent,
                  iT: Colors.indigoAccent,
                  eS: Colors.black,
                  aD: Colors.pinkAccent,
                  aT: Colors.limeAccent,
                  gB: Colors.deepOrange
              ).toMap(),
              callback: (id, name, tapdetails) {
                print(id);
              },
            ),
          )
        )
    );
  }

  Future<void> _getData() async {
    dati= (await Model.sharedInstance.getNationPercentage())!;
    setState(() {
      loading = false;
    });
  }
}