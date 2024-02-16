
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
  late List<Coppia> dati;
  late List<String> campiSelezionati;
  late List<String> campiMenuTendina;

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
    if (tmp==null ){
      tmp=[];
    }
    campiSelezionati=tmp;
    List<String> datiHotelBox = seleziona(dati, campiSelezionati);
    return Row(
        children:[
          BarraDiRicercaBooking(key: childKey, aggiorna: aggiorna, campiMenuTendina: campiMenuTendina),
          HotelBox(datiHotelBox)
        ]
    );
  }

  List<String> seleziona(List<Coppia> dati, List<String> campiSelezionati) {
    List<String> ris= [];

    for (String tag in campiSelezionati){
      List<String> hotel = estraiTopHotel(tag,dati);
      ris.addAll(hotel);
    }
    return ris.toSet().toList();
  }

  List<String> estraiTopHotel(String tag, List<Coppia> dati) {
    List<String> hotels = [];
    for(Coppia coppia in dati){
      if(coppia.item2.elementAt(0) == tag || coppia.item2.elementAt(1) == tag || coppia.item2.elementAt(2) == tag)
        hotels.add(coppia.item1);
    }
    return hotels;
  }

  Future<void> _getData() async {
    dati= (await Model.sharedInstance.getHotelTags())!;
    campiMenuTendina= (await Model.sharedInstance.getAllTags())!;
    setState(() {
      loading = false;
    });
  }

  aggiorna(){
    setState(() {
    });
  }


}