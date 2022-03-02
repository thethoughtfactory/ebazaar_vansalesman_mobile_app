import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';


double lat;
double long;
String currentlocation;

class Locationclass {
  double latitude;
  double longitude;

  Future<void> getCurrentLocation() async {
    try{
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
      latitude = position.latitude;
      longitude = position.longitude;
      //print('latut');
    } catch(e){
      print(e);
    }
  }
}

Future<bool> getLocation() async {
  try{
    Locationclass location = Locationclass();
    await location.getCurrentLocation();
    lat = location.latitude;
    long = location.longitude;
    print('eeeee');
    print("latuma: ${lat} long: ${long}");
    return lat==null?false:true;
  }catch(e){
    lat=0.00000;
    long=0.00000;
    print('eeeee');
  }
}

address() async {
  final coordinates = new Coordinates(lat,long);
  print(coordinates);
  var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  var first = addresses.first;
  getaddress.currentaddress = '${first.addressLine}';
}

class getaddress {
  static var currentaddress;
}