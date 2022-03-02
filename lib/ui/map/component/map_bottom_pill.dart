import 'package:ebazar_delivery/api/orderapi.dart';
import 'package:flutter/material.dart';

class MapBottomPill extends StatelessWidget {
  final orders order;
  final Map<String, dynamic> mapData;

  MapBottomPill({this.order, this.mapData});

  @override
  Widget build(BuildContext context) {
    // debugPrint('distance --- ${mapData["routes"][0]['legs'][0]['duration']} ');
    return Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset.zero)
            ]),
        child: Column(
          children: [
            Container(
                color: Colors.white,
                child: Row(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipOval(
                          child: Image.asset('images/logo.png',
                              width: 60, height: 60, fit: BoxFit.cover),
                        ),
                        /*Positioned(
                          bottom: -10,
                          right: -10,
                          child: CategoryIcon(
                              color: this.subCategory!.color,
                              iconName: this.subCategory!.icon,
                              size: 20,
                              padding: 5
                          ),
                        )*/
                      ],
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('destination',
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                          Text('${order.firstname}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          Text('${order.address}',
                              style: TextStyle(color: Colors.black)),
                          Text(
                              'Distance - ${(mapData["routes"] as List).length > 0 ? mapData["routes"][0]['legs'][0]['distance']['text'] : ''}',
                              style: TextStyle(color: Colors.black)),
                          Text(
                              'Duration - ${(mapData["routes"] as List).length > 0 ? mapData["routes"][0]['legs'][0]['duration']['text'] : ''}',
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                    Icon(Icons.location_pin, color: Colors.black, size: 50)
                  ],
                )),
            /*Container(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(
                                  image: AssetImage('assets/imgs/farmer.jpeg'),
                                  fit: BoxFit.cover
                              ),
                              border: Border.all(color: Colors.black, width: 4)
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Jose Gonzalez',
                                style: TextStyle(fontWeight: FontWeight.bold)
                            ),
                            Text('Autopista Duarte\nCarretera Duarte Vieja #225')
                          ],
                        )
                      ],
                    )
                  ],
                )
            )*/
          ],
        ));
  }
}
