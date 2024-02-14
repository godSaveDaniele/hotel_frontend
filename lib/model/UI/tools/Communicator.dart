import 'package:hotel_frontend/model/Model.dart';

// Questa classe mette in comunicazione i vari widget tra loro, evitando di esporre il
// loro stato

class Communicator {

  static Communicator sharedInstance = Communicator();

  bool isCountry = false;
  bool isMap = false;
  List<Map<dynamic, dynamic>> wordCloudListMap = [];

  // Used for Function1
  late Function _aggiornaStatoPadre1;

  // Used for Function2
  late Function _aggiornaStatoPadre2;

  bool nationalityLoaded = false;
  late List<String> nationalityList;

  String nationalitySelected = "Select nationality";
  bool nationalityClassificationLoaded = false;
  late Map<String, double> nationalityClassification;
  bool sendingRequest = false;


  Future<void> setCountry(String country) async {
    isCountry = true;
    isMap = false;
    aggiornaStato();
    Map<String, List<dynamic>>? map = await Model.sharedIstance.getNationalityNegWords(country);

    List<dynamic>? wordWithFreq = map?[" "+country+" "];

    // Conversione di List<dynamic>? in una List<Map<dynamic, dynamic>> dal momento che
    // WorldCloud si aspetta di ricevere una List<Map<dynamic, dynamic>>
    List<Map<dynamic, dynamic>> formattedListMap = [];
    for (var item in wordWithFreq!) {
      if (item is List && item[0] is String && item[1] is num) {
        formattedListMap.add({'word':item[0], 'value':item[1]});
      }
    }

    wordCloudListMap = formattedListMap;

    isMap = true;
    aggiornaStato();
  }

  // Used for Function1
  void setAggiornaStato1(Function() aggiorna) {
    _aggiornaStatoPadre1 = aggiorna;
  }
  void aggiornaStato() {
    _aggiornaStatoPadre1.call();
  }

  // Used for Function2
  void setAggiornaStato2(Function() aggiorna) {
    _aggiornaStatoPadre2 = aggiorna;
  }
  void aggiornaStato2() {
    _aggiornaStatoPadre2.call();
  }

  // Questo metodo serve a caricare le nazionalità dal backend nel momento in cui
  // il widget Function2 viene caricato. Una volta caricate rimangono in ram.
  Future<void> loadNationality() async {
    nationalityList = (await Model.sharedIstance.getAllNationality())!.map((e) => e.trim()).toList();
    nationalityList.sort();
    nationalityLoaded = true;
    aggiornaStato2();
  }

  Future<void> getNationalityClass(String nationality) async {
    sendingRequest = true;
    aggiornaStato2();
    nationalitySelected = nationality;
    nationalityClassification = (await Model.sharedIstance.getNationalityClass(nationality))!;
    if (nationalityClassification['0'] == null)
      nationalityClassification['0'] = 0.0;
    if (nationalityClassification['1'] == null)
      nationalityClassification['1'] = 0.0;
    if (nationalityClassification['2'] == null)
      nationalityClassification['2'] = 0.0;
    nationalityClassificationLoaded = true;
    sendingRequest = false;
    aggiornaStato2();
  }


}