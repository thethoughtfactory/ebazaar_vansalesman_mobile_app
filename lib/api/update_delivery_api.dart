import 'dart:convert';
import 'dart:io';

import 'package:ebazar_delivery/api/apiloginotp.dart';
import 'package:http/http.dart' as http;

Future<bool> updateDeliveryApiCall(Map<String,dynamic> body) async {
  https: //ebazaar.ae/rest/V1/updatedelivery.
  final response = await http.post(
    updatePayment,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode(body),
  );
  if (response.statusCode == HttpStatus.ok) {
    if (jsonDecode(response.body) == "success")
      return true;
    else
      return false;
  } else if (response.statusCode == HttpStatus.unauthorized) {
    return false;
  } else {
    //need to handel network connection error
    return false;
  }
}
