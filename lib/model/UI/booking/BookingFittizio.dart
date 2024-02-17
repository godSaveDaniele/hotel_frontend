import 'package:flutter/material.dart';
import 'package:hotel_frontend/model/UI/booking/BarraDiRicercaBooking.dart';

import '../../Model.dart';
import 'HotelBox.dart';

class BookingFittizio extends StatefulWidget {
  @override
  _BookingFittizio createState() => _BookingFittizio();

}

class _BookingFittizio extends State<BookingFittizio> {
  GlobalKey<BarraDiRicercaBookingState> childKey = GlobalKey<BarraDiRicercaBookingState>();
  bool loading = true;
  late List<Coppia> dati;  //lista di coppie hotel-listaDiTag
  late List<String> campiSelezionati;   //tag selezionati dall'utente
  late List<String> campiMenuTendina;   //tag proposti all'utemte
  late List<List<dynamic>> coppieTag;   //tag suggeriti all'utente

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
    List<String>? tmp= childKey.currentState?.getCampiSelezionati();
    if (tmp==null)  campiSelezionati=[];
    else campiSelezionati=tmp;
    List<String> datiHotelBox = selezionaHotel();
    List<String> tagSuggeriti = selezionaTag();
    return Row(
        children:[
          BarraDiRicercaBooking(key: childKey, aggiorna: aggiorna, campiMenuTendina: campiMenuTendina, tagSuggeriti: tagSuggeriti),
          HotelBox(datiHotelBox)
        ]
    );
  }

  List<String> selezionaHotel() {
    List<String> ris= [];
    for (String tag in campiSelezionati){
      List<String> hotel = estraiTopHotel(tag);
      ris.addAll(hotel);
    }
    return ris.toSet().toList();
  }

  List<String> estraiTopHotel(String tag) {
    List<String> hotels = [];
    for(Coppia coppia in dati){
      if(coppia.item2.elementAt(0) == tag || coppia.item2.elementAt(1) == tag || coppia.item2.elementAt(2) == tag)
        hotels.add(coppia.item1);
    }
    return hotels;
  }

  List<String> selezionaTag(){
    List<String> ris=[];
    for (String tag in campiSelezionati){
      String toInsert=tagAssociato(tag);
      if (!campiSelezionati.contains(toInsert))
        ris.insert(0, tagAssociato(tag));
    }
    return ris.toSet().toList();
  }

  String tagAssociato(String tag){
    for(int i=0; i<coppieTag.length; i++){
      if (coppieTag[i][0].toString()==tag) return coppieTag[i][1].toString();
      if (coppieTag[i][1].toString()==tag) return coppieTag[i][0].toString();
    }
    return "Nessun suggerimento";
  }

  Future<void> _getData() async {
    dati= (await Model.sharedInstance.getHotelTags())!;
    campiMenuTendina= (await Model.sharedInstance.getAllTags())!;
    coppieTag=(await Model.sharedInstance.getCoppieTag())!;
    setState(() {
      loading = false;
    });
  }

  aggiorna(){
    setState(() {
    });
  }
}