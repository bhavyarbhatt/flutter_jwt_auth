import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkHandle
{
  String baseurl= "http://localhost:5000";
  var  log = Logger();
  Future<dynamic> get(String url) async{
    url= formater(url);
    var response = await http.get(url as Uri);

    log.i(response.body);
    log.i(response.statusCode);
  } 

  Future<dynamic> post(String url, Map<String,String> body ) async
  {
      url = formater(url);
      var  response = await http.post(url as Uri, body: body );
      if(response.statusCode==200 || response.statusCode == 201) {
        log.i(response.body);
        return response;           
      }
      log.d(response.body);
      log.d(response.statusCode);
  }

  String formater(String url) 
  {
      return baseurl+url;
  }
}