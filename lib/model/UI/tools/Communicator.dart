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
    Map<String, List<dynamic>>? map = await Model.sharedIstance.getNationalityNegWords(country);
    isMap = true;
    aggiornaStato();
    List<dynamic>? wordWithFreq = map?[" "+country+" "];

    // Conversione di List<dynamic>? in una List<Map<dynamic, dynamic>> dal momento che
    // WorldCloud si aspetta di ricevere una List<Map<dynamic, dynamic>>
    List<Map<dynamic, dynamic>> formattedListMap = [];
    for (var item in wordWithFreq!) {
      if (item is List && item[0] is String && item[1] is num) {
        formattedListMap.add({item[0]: item[1]});
      }
    }


  }

  void setAggiornaStato(Function() aggiorna) {
    _aggiornaStatoPadre = aggiorna;
  }

  void aggiornaStato() {
    _aggiornaStatoPadre.call();
  }



}