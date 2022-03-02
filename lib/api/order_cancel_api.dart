import 'dart:convert';
import 'dart:io';

import 'package:ebazar_delivery/api/apiloginotp.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<bool> orderCancelApi(
    Map<String, dynamic> body, String incrementId) async {
  final response = await http.post(
    Uri.parse(cancelOrder),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode(body),
  );
  if (response.statusCode == HttpStatus.ok) {
    if (jsonDecode(response.body) == 'successfully posted')
      return true;
    else
      return false;
  } else if (response.statusCode == HttpStatus.unauthorized) {
    return false;
  } else {
    //need to handel network connection error
    return false;
  }
  return false;
}
