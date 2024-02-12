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

  Future<Map<String, List<MapEntry<String, double>>>?> getNationalityNegWords(String nationality) async {
    try{
      String result = await _restManager.makeGetRequest("localhost:8080", "Function1/"+nationality);
      print(result);
      print(json.decode(result));
      return Map<String, List<MapEntry<String, double>>>.from(json.decode(result));
    }catch(err){
      print(err);
    }
    return null;
  }


}
