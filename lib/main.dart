import 'package:ebazar_delivery/app_config/end_points.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/orderapi.dart';
import 'app_config/environment_varriables.dart';
import 'dashboard.dart';
import 'login.dart';

var DriverId = '18';
bool autologin = false;

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  appEndPoint = EnvVarriables.env == 'qa' ? devEndPoint : liveEndPoint;
  var mobile = prefs.getString('mobilenumber');
  var driverid = prefs.getString('driverid');
  if (driverid == null) {
    runApp(MyApp());
  } else {
    autologin = true;
    print("driver id : $driverid");
    DriverId = driverid;
    await getOrders(DriverId);
    runApp(MyApp());
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EBazaar Delivery',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: autologin ? DashBoard() : Login(),
    );
  }
}
