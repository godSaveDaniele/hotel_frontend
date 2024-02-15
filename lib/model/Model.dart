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

}
