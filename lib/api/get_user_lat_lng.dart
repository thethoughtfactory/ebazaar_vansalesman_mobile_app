import 'dart:convert';

import 'package:ebazar_delivery/%20model/locate_me_response.dart';
import 'package:http/http.dart' as http;

import 'apiloginotp.dart';

Future<LocateMeResponse> getUserLatLog(
    Map<String, dynamic> requestParams) async {
  http.Response response = await http.post(
    latlog,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode(requestParams),
  );
  print(response.body);
  if (response.statusCode == 200) {
    var data = response.body;
    if (json.decode(response.body) is Map<String, dynamic>)
      return LocateMeResponse.fromJson(json.decode(response.body));
  } else {
    return null;
  }
}
