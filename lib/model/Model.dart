import 'dart:async';
import 'dart:convert';
import 'managers/RestManager.dart';
import 'support/Constants.dart';

class Model {
  static Model sharedIstance= Model();

  RestManager _restManager = RestManager();

  Future<Map<String, double>?> getNationalityScore() async{
    try{
      String bodyRisposta= await _restManager.makeGetRequest(
          Constants.SERVER_ADDRESS, Constants.REQUEST_NATIONALITY_SCORE);
      Map<String, double> output= json.decode(bodyRisposta);
      return output;
    }catch(err){
      print(err);
    }
  }
}
