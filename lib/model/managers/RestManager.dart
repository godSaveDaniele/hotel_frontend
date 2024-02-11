import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';


class RestManager {

  // Metodo che esegue chiamate http
  Future<String> _makeRequest(String serverAddress, String servicePath, String method, {Map<String, String>? value, dynamic body}) async {

    Uri uri = Uri.http(serverAddress, servicePath, value);

    while ( true ) {
      try {
        var response;
        // setting content type
        dynamic formattedBody;
        String contentType = "application/json;charset=utf-8";
        formattedBody = json.encode(body);  //Prendo il body e lo formatto come un json.

        // setting headers
        Map<String, String> headers = Map();
        headers[HttpHeaders.contentTypeHeader] = contentType;

        // making request
        switch (method) {
          case "post":
            response = await post(
              uri,
              headers: headers,
              body: formattedBody,
            );
            break;
          case "get":
            response = await get(
              uri,
              headers: headers,
            );
            break;
          case "put":
            response = await put(
              uri,
              headers: headers,
            );
            break;
          case "delete":
            response = await delete(
              uri,
              headers: headers,
            );
            break;
        }
        return response.body;
      } catch(err) {
        print (err);
        await Future.delayed(const Duration(seconds: 5), () => null);
      }
    }
  }


  Future<String> makePostRequest(String serverAddress, String servicePath, dynamic value) async {
    return _makeRequest(serverAddress, servicePath, "post", body: value);
  }

  Future<String> makeGetRequest(String serverAddress, String servicePath, [Map<String, String>? value]) async {
    return _makeRequest(serverAddress, servicePath, "get", value: value);
  }

  Future<String> makePutRequest(String serverAddress, String servicePath, [Map<String, String>? value]) async {
    return _makeRequest(serverAddress, servicePath, "put", value: value);
  }

  Future<String> makeDeleteRequest(String serverAddress, String servicePath, [Map<String, String>? value]) async {
    return _makeRequest(serverAddress, servicePath, "delete", value: value);
  }
}