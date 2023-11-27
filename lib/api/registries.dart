
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../config/storage.dart';

Future<List<Map<String,dynamic>?>?> getAllRegistries() async {
  final url = Uri.parse(
      '${dotenv.env['API_BASE_URL']!}/preceptor/registries');
  print((await storage.read(key: "hujb_preceptor_jwt_token")));
  final response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${(json.decode((await storage.read(key: "hujb_preceptor_jwt_token"))!)['token'])!}'
    },
  );
  if (response.statusCode == 200) {
    try {
      var decodedData = List<Map<String, dynamic>>.from(json.decode(response.body));
      return decodedData;
    } catch (e) {
      print('Error decoding JSON: $e');
      return null;
    }
  }
  return null;
}

Future<void> rejectRegistry (String idRegistry,String message,String reason) async {
  final url = Uri.parse(
      '${dotenv.env['API_BASE_URL']!}/preceptor/rejectRegistry');
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${(json.decode((await storage.read(key: "hujb_preceptor_jwt_token"))!)['token'])!}'
    },
    body: json.encode({
      'idRegistry': idRegistry,
      'menssage': message,
      'reason': reason
    }),
  );
  debugPrint(idRegistry);
  debugPrint(message);
  debugPrint(reason);
  if(response.statusCode == 200){
    print("rejected sucess");
  }
}

Future<void> singAllRegistries() async{
  final url = Uri.parse(
      '${dotenv.env['API_BASE_URL']!}/preceptor/sign');
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${(json.decode((await storage.read(key: "hujb_preceptor_jwt_token"))!)['token'])!}'
    },

  );
  debugPrint(response.statusCode.toString());
}