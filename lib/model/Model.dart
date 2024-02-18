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
      print("getAllNationality");
      List<String> output=  List<String>.from(json.decode(bodyRisposta));
      print("Not printed");
      return output;
    }catch(err){
      print(err);
    }
    return null;
  }


  Future<List<dynamic>?> getNationalityNegWords(String nationality) async {
    try{
      String result = await _restManager.makeGetRequest(Constants.SERVER_ADDRESS, "Function1/"+nationality);
      //print(json.decode(result));
      return List<dynamic>.from(json.decode(result));
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

  Future<List<List<dynamic>>?> getCoppieTag() async{
    try{
      String bodyRisposta= await _restManager.makeGetRequest(
          Constants.SERVER_ADDRESS, Constants.REQUEST_COPPIE_TAG);
      print(bodyRisposta);
      List<List<dynamic>> output=  List<List<dynamic>>.from(json.decode(bodyRisposta));
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

  Future<List<String>?> getAllTags() async {
    try{
      String result = await _restManager.makeGetRequest(Constants.SERVER_ADDRESS, "GetAllTags");
      //print(json.decode(result));
      return List<String>.from(json.decode(result));
    }catch(err){
      print(err);
    }
    return null;
  }

  Future<List<Coppia>?> getHotelTags() async {
    try{
      String result = await _restManager.makeGetRequest(Constants.SERVER_ADDRESS, "Function3");
      List<dynamic> tmp = List<dynamic>.from(json.decode(result));

      List<Coppia> finalResult = [];

      for (var data in tmp) {
        String address = data[0];
        List<String> details = List<String>.from(data[1]);
        finalResult.add(Coppia(address, details));
      }

      return finalResult;
    }catch(err){
      print(err);
    }
    return null;
  }

}


class Coppia {
  final String item1;
  final List<String> item2;

  Coppia(this.item1, this.item2);

  @override
  String toString() {
    return '($item1, $item2)';
  }
}
