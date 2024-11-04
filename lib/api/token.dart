import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/storage.dart';


Future<bool> setToken(String username,String password) async {
  final url = Uri.parse(
    '${dotenv.env['API_BASE_URL']!}/preceptor/auth');
  final response = await http.post(
    url,
    body: json.encode({'username': username,'password': password}),
    headers: {
      'Content-Type': 'application/json',
    },
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    await storage.write(key: "hujb_preceptor_jwt_token", value: response.body);
    return true;
  }
  return false;
}

Future<bool> hasValidToken() async {
  var existsToken = await storage.read(key: "hujb_preceptor_jwt_token");

  if(existsToken != null){
    var token = json.decode((existsToken))['expireAt'];
    if(isValidToken(token)){
      return true;
    }
    return false;
  }
  return false;
}

bool isValidToken(String expireAt) {
  return DateTime.now().isBefore(DateTime.parse(expireAt));
}