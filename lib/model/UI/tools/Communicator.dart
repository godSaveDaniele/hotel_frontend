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

  String nationalitySelected = "Seleziona una nazione";
  bool nationalityClassificationLoaded = false;
  late Map<String,Map<String, double>> nationalityClassification;
  bool sendingRequest = false;
  late Map<String, double> classification;


  Future<void> setCountry(String country) async {
    isCountry = true;
    isMap = false;
    aggiornaStato();
    List<dynamic>? wordWithFreq = await Model.sharedInstance.getNationalityNegWords(country == ""? "a" :country);
    if (wordWithFreq == null) {
      isCountry = false;
      aggiornaStato();
      return;
    }

    // Conversione di List<dynamic>? in una List<Map<dynamic, dynamic>> dal momento che
    // WorldCloud si aspetta di ricevere una List<Map<dynamic, dynamic>>
    List<Map<dynamic, dynamic>> formattedListMap = [];
    for (var item in wordWithFreq) {
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
  // Aggiunta: il metodo carica anche tutte le classificazioni di ogni nazionalità.
  Future<void> loadNationality() async {
    nationalityList = (await Model.sharedInstance.getAllNationality2())!.map((e) => e.trim()).toList();
    nationalityList.sort();
    nationalityClassification = (await Model.sharedInstance.getNationalityClass())!;
    nationalityLoaded = true;
    aggiornaStato2();
  }

  // Il seguente metodo non esegue piu' una chiamata http ma accede normalmente alla
  // mappa nationalityClassification e restituisce la classificazione per la nationality passata.
  void getNationalityClass(String nationality)  {
    sendingRequest = true;
    aggiornaStato2();
    nationalitySelected = nationality;
    classification = nationalityClassification[nationality]!;
    if (classification['0'] == null)
      classification['0'] = 0.0;
    if (classification['1'] == null)
      classification['1'] = 0.0;
    if (classification['2'] == null)
      classification['2'] = 0.0;
    nationalityClassificationLoaded = true;
    sendingRequest = false;
    aggiornaStato2();
  }


}