import 'package:hotel_frontend/model/Model.dart';

// Questa classe mette in comunicazione i vari widget tra loro, evitando di esporre il
// loro stato

class Communicator {

  static Communicator sharedInstance = Communicator();

  late String countryToShow;

  bool isCountry = false;

  late Function _aggiornaStatoPadre;


  void setCountry(String country) {
    isCountry = true;
    countryToShow = country;
  }

  void setAggiornaStato(Function() aggiorna) {
    _aggiornaStatoPadre = aggiorna;
  }

  void aggiornaStato() {
    _aggiornaStatoPadre.call();
  }



}