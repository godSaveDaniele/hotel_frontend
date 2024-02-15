import 'dart:async';
import 'dart:convert';
import 'managers/RestManager.dart';
import 'support/Constants.dart';

// Contiene i metodi che fanno chiamate al server (backend)
class Model {
  static Model sharedIstance= Model();

  RestManager _restManager = RestManager();

  Future<Map<String, double>?> getNationalityScore() async{
    try{
      String bodyRisposta= await _restManager.makeGetRequest(
          Constants.SERVER_ADDRESS, Constants.REQUEST_NATIONALITY_SCORE);
      print(bodyRisposta);
      print(json.decode(bodyRisposta));
      Map<String, double> output=  Map<String, double>.from(json.decode(bodyRisposta));
      return output;
    }catch(err){
      print(err);
    }
    return null;
  }

  Future<Map<String, List>?> getNationalityNegWords(String nationality) async {
    try{
      String result = await _restManager.makeGetRequest("localhost:8080", "Function1/"+nationality);
      //print(json.decode(result));
      return Map<String, List<dynamic>>.from(json.decode(result));
    }catch(err){
      print(err);
    }
    return null;
  }

  Future<List<String>?> getAllNationality() async {
    try{
      String result = await _restManager.makeGetRequest("localhost:8080", "GetAllNationality");
      //print(json.decode(result));
      return List<String>.from(json.decode(result));
    }catch(err){
      print(err);
    }
    return null;
  }

  Future<Map<String,Map<String, double>>?> getNationalityClass() async {
    try{
      String result = await _restManager.makeGetRequest("localhost:8080", "Function2");
      //String result = '{" Angola ":{"0":80.32258064516128,"2":20.67741935483871}}';

      // Decodifica il JSON in un Map<String, dynamic>
      Map<String, dynamic> jsonMap = json.decode(result);

      // Mappa in cui verranno memorizzati i valori convertiti
      Map<String, Map<String, double>> newResult = {};

      // Itera attraverso ogni coppia chiave-valore nel JSON
      jsonMap.forEach((key, value) {
        // Converte il valore interno in un Map<String, double>
        Map<String, double> innerMap = {};
        value.forEach((innerKey, innerValue) {
          innerMap[innerKey] = innerValue.toDouble();
        });

        // Aggiunge la coppia chiave-valore alla mappa risultante
        newResult[key.trim()] = innerMap;
      });

      return newResult;
    }catch(err){
      print(err);
    }
    return null;
  }


}
