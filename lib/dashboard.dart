import 'package:ebazar_delivery/ProgressHUD.dart';
import 'package:ebazar_delivery/main.dart';
import 'package:ebazar_delivery/ui/map/maps_view.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Delivered Order Summary.dart';
import 'api/orderapi.dart';
import 'constants.dart';
import 'login.dart';
import 'ordersummary.dart';

bool isApiCallProcess = false;

class selectedindex {
  static int ordersummary;
  static int deliveredordersummary;
}

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: red,
            title: Row(
              children: [
                Text("DashBoard"),
                SizedBox(width: MediaQuery.of(context).size.width / 2.5),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      isApiCallProcess = true;
                    });
                    await getOrders(DriverId);

                    setState(() {
                      isApiCallProcess = false;
                    });
                    //    isotprequested = false;
                    //   print(isotprequested);
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (BuildContext
                    //         context) =>
                    //             Login()));
                  },
                  child: Icon(
                    Icons.refresh_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                )
              ],
            ),
          ),
          drawer: Drawer(
            child: Menu(),
          ),
          body: Column(
            children: [
              SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Center(child: Text("Welcome User!"))),
              Expanded(
                child: DefaultTabController(
                  length: 3, // length of tabs
                  initialIndex: 0,
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(kToolbarHeight),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                //color of shadow
                                spreadRadius: 3,
                                //spread radius
                                blurRadius: 7,
                                // blur radius
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TabBar(
                            labelColor: red,
                            unselectedLabelColor: Colors.black,
                            indicatorColor: red,
                            tabs: [
                              Tab(text: 'PENDING'),
                              Tab(text: 'COMPLETE'),
                              Tab(text: 'REJECTED'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    body: TabBarView(
                        children: <Widget>[Tab1List(), Tab2List(), Tab3List()]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Tab1List extends StatefulWidget {
  @override
  _Tab1ListState createState() => _Tab1ListState();
}

class _Tab1ListState extends State<Tab1List> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: ordersyettodeliver.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              print(index);
              selectedindex.ordersummary = index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => OrderSummary(
                            isPending: true,
                            order: ordersyettodeliver.elementAt(index),
                          ))).then((value) {
                setState(() {});
              });
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: pink,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey, //color of shadow
                    //spreadRadius: 0.5, //spread radius
                    blurRadius: 3, // blur radius
                    offset: Offset(3, 4), // changes position of shadow
                  ),
                ],
              ),
              child: Table(
                columnWidths: {
                  0: FractionColumnWidth(.3),
                  2: FractionColumnWidth(.20),
                },
                children: [
                  TableRow(children: [
                    Text(
                      "Order id:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(' ${ordersyettodeliver[index].orderID}',
                          style: TextStyle(fontSize: 15)),
                    ),
                    Text(""),
                  ]),
                  // TableRow(
                  //     children: [
                  //       Text("Order Item:",style: TextStyle(fontWeight: FontWeight.bold),),
                  //       Padding(
                  //         padding: const EdgeInsets.only(bottom:8.0),
                  //         child: Text('${ordersyettodeliver[index].name}',style: TextStyle(fontSize: 15)),
                  //       ),
                  //       Text(""),
                  //     ]
                  // ),
                  // TableRow(
                  //     children: [
                  //       Text("Order Quantity:",style: TextStyle(fontWeight: FontWeight.bold),),
                  //       Padding(
                  //         padding: const EdgeInsets.only(bottom:8.0),
                  //         child: Text('${ordersyettodeliver[index].qtyordered}',style: TextStyle(fontSize: 15)),
                  //       ),
                  //       Text(""),
                  //     ]
                  // ),
                  TableRow(children: [
                    Text(
                      "Bill Amount:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text('${ordersyettodeliver[index].grandtotal} AED',
                          style: TextStyle(fontSize: 15)),
                    ),
                    Container(),
                  ]),
                  TableRow(children: [
                    Text(
                      "Name:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                          '${ordersyettodeliver[index].firstname} ${ordersyettodeliver[index].lastname}',
                          style: TextStyle(fontSize: 15)),
                    ),
                    Text(""),
                  ]),
                  TableRow(children: [
                    Text(
                      "Contact:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SelectableText(
                          '${ordersyettodeliver[index].contact}',
                          style: TextStyle(fontSize: 15)),
                    ),
                    Text(""),
                  ]),
                  // TableRow(
                  //     children:[
                  //       Text("",style: TextStyle(fontWeight: FontWeight.bold),),
                  //       Padding(
                  //         padding: const EdgeInsets.only(bottom :8.0),
                  //         child: SelectableText('',style: TextStyle(fontSize: 15)),
                  //       ),
                  //       Text(""),
                  //     ]
                  // ),

                  TableRow(children: [
                    Text(
                      "Address:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        '${ordersyettodeliver[index].street},${ordersyettodeliver[index].city},${ordersyettodeliver[index].postcode}',
                        style: TextStyle(fontSize: 15)),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MapsView(ordersyettodeliver[index])));
                      },
                      child: Icon(
                        CupertinoIcons.location_solid,
                        color: red,
                        size: 25,
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          );
        });
  }
}

class Tab2List extends StatefulWidget {
  @override
  _Tab2ListState createState() => _Tab2ListState();
}

class _Tab2ListState extends State<Tab2List> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: ordersDelivered.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              print("index");
              print(index);
              selectedindex.deliveredordersummary = index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          DeliveredOrderSummary()));
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: pink,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey, //color of shadow
                    //spreadRadius: 0.5, //spread radius
                    blurRadius: 3, // blur radius
                    offset: Offset(3, 4), // changes position of shadow
                  ),
                ],
              ),
              child: Table(
                columnWidths: {
                  0: FractionColumnWidth(.3),
                },
                children: [
                  TableRow(children: [
                    Text(
                      "Order id:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(' ${ordersDelivered[index].orderID}',
                          style: TextStyle(fontSize: 15)),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      "Name:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(' ${ordersDelivered[index].name}',
                          style: TextStyle(fontSize: 15)),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      "Contact:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SelectableText(
                          ' ${ordersDelivered[index].telephone}',
                          style: TextStyle(fontSize: 15)),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      "Address:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        '${ordersDelivered[index].street},${ordersDelivered[index].city},${ordersDelivered[index].postcode}',
                        style: TextStyle(fontSize: 15)),
                  ]),
                ],
              ),
            ),
          );
        });
  }
}

class Tab3List extends StatefulWidget {
  @override
  _Tab3ListState createState() => _Tab3ListState();
}

class _Tab3ListState extends State<Tab3List> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: rejecteList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
           //   print("index_rej");
              print(index);
              selectedindex.deliveredordersummary = index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => OrderSummary(
                            isPending: true,
                            order: rejecteList.elementAt(index),
                          )));
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: pink,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey, //color of shadow
                    //spreadRadius: 0.5, //spread radius
                    blurRadius: 3, // blur radius
                    offset: Offset(3, 4), // changes position of shadow
                  ),
                ],
              ),
              child: Table(
                columnWidths: {
                  0: FractionColumnWidth(.3),
                },
                children: [
                  TableRow(children: [
                    Text(
                      "Order id:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(' ${rejecteList[index].orderID}',
                          style: TextStyle(fontSize: 15)),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      "Name:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(' ${rejecteList[index].name}',
                          style: TextStyle(fontSize: 15)),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      "Contact:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SelectableText(
                          ' ${rejecteList[index].telephone}',
                          style: TextStyle(fontSize: 15)),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      "Address:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        '${rejecteList[index].street},${rejecteList[index].city},${rejecteList[index].postcode}',
                        style: TextStyle(fontSize: 15)),
                  ]),
                ],
              ),
            ),
          );
        });
  }
}

class MenuElements extends StatelessWidget {
  MenuElements({@required this.title, @required this.icon});

  final title;
  final icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.grey[600],
          size: 25,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          title,
          style: TextStyle(color: Colors.grey[600], fontSize: 15),
        )
      ],
    );
  }
}

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: red,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Menu",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              //Image.asset(
              //  'images/logo_menu.png',
             // ),
            ],
          ),
          // Text("Name"),
        ),
        ListTile(
          title: MenuElements(
            title: "DashBoard",
            icon: Icons.dashboard_rounded,
          ),
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => DashBoard()));
          },
        ),
        ListTile(
          title: MenuElements(
            title: "Order Summary",
            icon: CupertinoIcons.doc,
          ),
          onTap: () async {
            if (ordersyettodeliver.length > 0) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => DashBoard()));
            } else {
              Flushbar(
                backgroundColor: colorAccent,
                message: "No Orders to Deliver",
                duration: Duration(seconds: 5),
              )..show(context);
            }
          },
        ),
        ListTile(
          title: MenuElements(
            title: "Log Out",
            icon: Icons.logout,
          ),
          onTap: () async {
            isotprequested = false;
            await removeLoginValues();

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) => Login()));
          },
        ),
      ],
    );
  }
}
