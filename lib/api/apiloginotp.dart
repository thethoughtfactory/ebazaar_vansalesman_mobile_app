import 'dart:convert';

import 'package:ebazar_delivery/app_config/end_points.dart';
import 'package:ebazar_delivery/main.dart';
import 'package:http/http.dart' as http;

import '../login.dart';

String tokenfromotp;

// dev.ebazaar
Uri sendotp = Uri.parse("https://${appEndPoint}/rest${otp}");
Uri verifyotp = Uri.parse("https://${appEndPoint}/rest${driverToken}");
String cancelOrder = "https://${appEndPoint}/rest${orderCancel}";

Uri updatePayment = Uri.parse("https://${appEndPoint}/rest${updateDelivery}");
Uri latlog = Uri.parse("https://${appEndPoint}/rest${userLatLong}");

Future<bool> SendOtpapi() async {
  Map body = {
    "data": {"contact_no": "$loginnumber", "emirates_id_no": "$emiratesid"}
  };
  print(jsonEncode(body));
  http.Response response = await http.post(
    sendotp,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode(body),
  );
  print(response.body);
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    sendapimessage = data[0]['message'];
    return true;
  } else if (response.statusCode == 400) {
    var data = jsonDecode(response.body);
    sendapimessage = data['message'];
    return false;
  }
}

Future<bool> VerifyOtpapi() async {
  Map body = {"mobile": "$loginnumber", "otp": int.parse(otpenter)};
  print(jsonEncode(body));
  http.Response response = await http.post(
    verifyotp,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode(body),
  );
  print(response.body);
  if (response.body != "[]") {
    DriverId = jsonDecode(response.body);
    return true;
  } else {
    sendapimessage = jsonDecode(response.body);
    return false;
  }
}
