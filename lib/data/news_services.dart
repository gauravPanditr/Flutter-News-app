import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:js_util';

import 'package:http/http.dart' as http;

import 'base_services.dart';
import 'exceptiom.dart';

class NetworkServices extends BaseApiServices {
  @override
  Future<dynamic> getGetResponseApi(String url) async {
    dynamic responseJson;
    try{
      final respone=await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));

      responseJson=returnResponse(respone);
       return responseJson;

    } on SocketException{
      throw FetchDataException('');
    }on RequestTimeout{
      throw RequestTimeout('');
    }


  }

  dynamic returnResponse(http.Response response){
    switch(response.statusCode){
      case 200:
        dynamic responseJson=jsonDecode(response.body);
        return responseJson;

      case 400:
        throw ApiException("Error");

      default:
        throw ApiException('An error occurred');


    }
  }




}
