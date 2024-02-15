import 'dart:async';
import 'dart:convert';
import 'managers/RestManager.dart';
import 'support/Constants.dart';

// Contiene i metodi che fanno chiamate al server (backend)
class Model {
  static Model sharedInstance= Model();

  RestManager _restManager = RestManager();

  Future<Map<String, double>?> getNationalityScore() async{
    try{
      String bodyRisposta= await _restManager.makeGetRequest(
          Constants.SERVER_ADDRESS, Constants.REQUEST_NATIONALITY_SCORE);
      Map<String, double> output=  Map<String, double>.from(json.decode(bodyRisposta));
      return output;
    }catch(err){
      print(err);
    }
    return null;
  }


  Future<List<String>?> getAllNationality() async{
    try{
      String bodyRisposta= await _restManager.makeGetRequest(
          Constants.SERVER_ADDRESS, Constants.REQUEST_NATIONALITY);
      List<String> output=  List<String>.from(json.decode(bodyRisposta));
      return output;
    }catch(err){
      print(err);
    }
    return null;
  }

  Future<Map<String, List>?> loadNationalityNegWords() async {
    try{
      String result = await _restManager.makeGetRequest(Constants.SERVER_ADDRESS, "Function1");
      //print(json.decode(result));
      return Map<String, List<dynamic>>.from(json.decode(result));
    }catch(err){
      print(err);
    }
    return null;
  }

  Future<Map<String, List<dynamic>>?> getNationPercentage() async{
    try{
      String bodyRisposta= await _restManager.makeGetRequest(
          Constants.SERVER_ADDRESS, Constants.REQUEST_NATION_PERCENTAGE);
      Map<String, List<dynamic>> output=  Map<String, List<dynamic>>.from(json.decode(bodyRisposta));
      print(output);
      return output;
    }catch(err){
      print(err);
    }
    return null;
  }

  Future<List<String>?> getAllNationality2() async {
    try{
      String result = await _restManager.makeGetRequest(Constants.SERVER_ADDRESS, "GetAllNationality");
      //print(json.decode(result));
      return List<String>.from(json.decode(result));
    }catch(err){
      print(err);
    }
    return null;
  }

  Future<Map<String,Map<String, double>>?> getNationalityClass() async {
    try{
      String result = await _restManager.makeGetRequest(Constants.SERVER_ADDRESS, "Function2");

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
