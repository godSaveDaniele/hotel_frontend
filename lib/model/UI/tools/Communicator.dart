import 'package:hotel_frontend/model/Model.dart';

// Questa classe mette in comunicazione i vari widget tra loro, evitando di esporre il
// loro stato

class Communicator {

  static Communicator sharedInstance = Communicator();

  bool isCountry = false;

  bool isMap = false;

  late Function _aggiornaStatoPadre;


  Future<void> setCountry(String country) async {
    isCountry = true;
    isMap = false;
    aggiornaStato();
    var map = await Model.sharedIstance.getNationalityNegWords(country);
    isMap = true;
    aggiornaStato();

  }

  void setAggiornaStato(Function() aggiorna) {
    _aggiornaStatoPadre = aggiorna;
  }

  void aggiornaStato() {
    _aggiornaStatoPadre.call();
  }



}