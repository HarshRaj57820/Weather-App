import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class NetworkData{
  
  NetworkData(this.url);

  String url;


  Future getData() async {

    http.Response response = await http.get(Uri.parse(url));
        

    if (response.statusCode == 200) {

      var mapResponse = json.decode(response.body);
      return mapResponse;
    }
    else {
      debugPrint(response.statusCode.toString());

    }
  }
}
  
