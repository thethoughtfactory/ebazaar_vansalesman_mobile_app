import 'dart:async';

import 'package:ebazar_delivery/%20model/locate_me_response.dart';
import 'package:ebazar_delivery/api/get_user_lat_lng.dart';
import 'package:ebazar_delivery/api/orderapi.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'component/map_bottom_pill.dart';
import 'map_request.dart';

class MapsView extends StatefulWidget {
  orders order;

  MapsView(this.order, {Key key}) : super(key: key);

  @override
  _MapsViewState createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> {
  /// new
  bool loading = true;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLines = {};
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();

  Set<Polyline> get polyLines => _polyLines;
  Completer<GoogleMapController> _controller = Completer();
  static LatLng latLng;
  LocationData currentLocation;
  Map<String, dynamic> mapData;

  @override
  void initState() {
    setState(() {
      getUserLocation();
    });
    loading = true;
    super.initState();
  }

  void getUserLocation() {
    Map<String, dynamic> data = {'data': widget.order.firstname};

    getUserLatLog(data).then((LocateMeResponse value) {
      if (value != null) {
        getLocation(double.parse(value.value.split(',').elementAt(0)), double.parse(value.value.split(',').elementAt(1)));
      }
    });
  }
  var location = new Location();


  getLocation(double lat, double long) async {
    location.onLocationChanged.listen((currentLocation) {
      print('current-lat');
      print(currentLocation.latitude);
      print(currentLocation.longitude);
      setState(() {
        latLng = LatLng(currentLocation.latitude, currentLocation.longitude);
      });
      _onAddMarkerButtonPressed();
      if (loading) {
        sendRequest(lat,long);
      }

      loading = false;
    });
  }


  Future<bool> _checkIfWithinBounds() async {
    /*var mapBounds = await _controller();
    return mapBounds.contains(
      LatLng(currentLocation.latitude, currentLocation.longitude),
    );*/
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId("111"),
        position: latLng,
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void onCameraMove(CameraPosition position) {
    latLng = position.target;
  }

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  void sendRequest(double lat, long) async {
    LatLng destination = LatLng(lat, long);
    mapData =
        await _googleMapsServices.getRouteCoordinates(latLng, destination);
    if (mapData.containsKey('routes')) {
      createRoute(mapData["routes"][0]["overview_polyline"]["points"]);
    }
    _addMarker(destination, "Destination");
  }

  void createRoute(String encondedPoly) {
    _polyLines.add(Polyline(
        polylineId: PolylineId(latLng.toString()),
        width: 4,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: Colors.red));
  }

  void _addMarker(LatLng location, String address) {
    _markers.add(Marker(
        markerId: MarkerId("112"),
        position: location,
        infoWindow: InfoWindow(title: address, snippet: "go here"),
        icon: BitmapDescriptor.defaultMarker));
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
    do {
      var shift = 0;
      int result = 0;

      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }

  @override
  Widget build(BuildContext context) {
//    print("getLocation111:$latLng");
    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: Container(), // here the desired height
      )
      /*AppBar(
        backgroundColor: red,
        title: Row(
          children: [
            Text("Location"),
            SizedBox(width: MediaQuery.of(context).size.width / 2.5),
          ],
        ),
      )*/
      ,
      body: loading
          ? Stack(
              children: [
                Center(
                  child: Text('Loading ...'),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: FloatingActionButton(
                    child: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            )
          : Stack(
              children: [
                Positioned.fill(
                  child: GoogleMap(
                    polylines: polyLines,
                    markers: _markers,
                    myLocationButtonEnabled: true,
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,
                    initialCameraPosition: CameraPosition(
                      target: latLng,
                      zoom: 19,
                    ),
                    onCameraMove: onCameraMove,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
                /*Positioned(
                  top: 100,
                  left: 0,
                  right: 1,
                  child: MapUserBadge(
                    isSelected: true,
                    order: widget.order,
                  ),
                ),*/
                mapData != null
                    ? AnimatedPositioned(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        left: 0,
                        right: 0,
                        bottom: 20,
                        child: MapBottomPill(
                          order: widget.order,
                          mapData: mapData,
                        ))
                    : Container(),
              ],
            ),
    );
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
