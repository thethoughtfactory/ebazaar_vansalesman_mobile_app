//import 'package:ebazar_delivery/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'login.dart';
import 'constants.dart';
import 'dashboard.dart';
import 'api/orderapi.dart';
int currentindex = selectedindex.deliveredordersummary;
class DeliveredOrderSummary extends StatefulWidget {
  @override
  _DeliveredOrderSummaryState createState() => _DeliveredOrderSummaryState();
}

class _DeliveredOrderSummaryState extends State<DeliveredOrderSummary> {
  GlobalKey<FormState> orderkey = GlobalKey<FormState>();
  TextEditingController amount = TextEditingController();
  TextEditingController reason = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: grey,
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          backgroundColor: red,
          title: Text("Order Summary"),
        ),
        body: SingleChildScrollView(
          child: Theme(
              data: ThemeData(primaryColor: Color(0xffBD2026)),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(10.00),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow:[
                        BoxShadow(
                          color: Colors.grey, //color of shadow
                          //spreadRadius: 0.5, //spread radius
                          blurRadius: 3, // blur radius
                          offset: Offset(3,4), // changes position of shadow
                        ),
                      ],
                    ),
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Order Detailes",style: TextStyle(color: red,fontSize: 16),),
                        Padding(
                          padding: const EdgeInsets.only(left:10.0,top: 5.0),
                          child: Table(
                            columnWidths: {
                              0: FractionColumnWidth(.25),
                            },
                            children: [
                              TableRow(
                                  children: [
                                    Text("Order id:",style: TextStyle(fontWeight: FontWeight.bold),),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom:8.0),
                                      child: Text(' ${ordersDelivered[currentindex].orderID}',style: TextStyle(fontSize: 15)),
                                    ),
                                  ]
                              ),
                              TableRow(
                                  children: [
                                    Text("Order Item:",style: TextStyle(fontWeight: FontWeight.bold),),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom:8.0),
                                      child: Flexible(child: Text(' ${ordersDelivered[currentindex].name}',style: TextStyle(fontSize: 15))),
                                    ),
                                  ]
                              ),
                              TableRow(
                                  children: [
                                    Text("Quantity:",style: TextStyle(fontWeight: FontWeight.bold),),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom:8.0),
                                      child: Text(' ${ordersDelivered[currentindex].qtyordered}',style: TextStyle(fontSize: 15)),
                                    ),
                                  ]
                              ),
                              TableRow(
                                  children:[
                                    Text("Name:",style: TextStyle(fontWeight: FontWeight.bold),),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom:8.0),
                                      child: Text(' ${ordersDelivered[currentindex].firstname} ${ordersDelivered[currentindex].lastname}',style: TextStyle(fontSize: 15)),
                                    ),
                                  ]
                              ),
                              TableRow(
                                  children:[
                                    Text("Contact:",style: TextStyle(fontWeight: FontWeight.bold),),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom :8.0),
                                      child: SelectableText(' ${ordersDelivered[currentindex].telephone}',style: TextStyle(fontSize: 15)),
                                    ),
                                  ]
                              ),
                              TableRow(
                                  children:[
                                    Text("Address:",style: TextStyle(fontWeight: FontWeight.bold),),
                                    Text(' ${ordersDelivered[currentindex].street},${ordersDelivered[currentindex].city},${ordersDelivered[currentindex].region},${ordersDelivered[currentindex].postcode}',style: TextStyle(fontSize: 15)),
                                  ]
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text("Seller Detailes",style: TextStyle(color: red,fontSize: 16),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:10.0,top: 5.0),
                          child: Table(
                            columnWidths: {
                              0: FractionColumnWidth(.25),
                            },
                            children: [
                              TableRow(
                                  children:[
                                    Text("Name:",style: TextStyle(fontWeight: FontWeight.bold),),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom:8.0),
                                      child: Text(' ${ordersDelivered[currentindex].companyname}',style: TextStyle(fontSize: 15)),
                                    ),
                                  ]
                              ),
                              TableRow(
                                  children:[
                                    Text("Contact:",style: TextStyle(fontWeight: FontWeight.bold),),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom :8.0),
                                      child: SelectableText(' ${ordersDelivered[currentindex].contact}',style: TextStyle(fontSize: 15)),
                                    ),
                                  ]
                              ),
                              TableRow(
                                  children:[
                                    Text("Address:",style: TextStyle(fontWeight: FontWeight.bold),),
                                    Text(' ${ordersDelivered[currentindex].address}',style: TextStyle(fontSize: 15)),
                                  ]
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text("Payment Info",style: TextStyle(color: red,fontSize: 16),),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left:10.0,top: 5.0),
                            child: Table(
                              columnWidths: {
                                0: FractionColumnWidth(0.25),
                              },
                              children: [
                                TableRow(
                                    children: [
                                      Text("Method:",style: TextStyle(fontWeight: FontWeight.bold),),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom:8.0),
                                        child: Text('Cash on Delivery',style: TextStyle(fontSize: 15)),
                                      ),
                                    ]
                                ),
                                TableRow(
                                    children: [
                                      Text("Amount:",style: TextStyle(fontWeight: FontWeight.bold),),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom:8.0),
                                        child: Text(' ${ordersDelivered[currentindex].grandtotal}',style: TextStyle(fontSize: 15)),
                                      ),
                                    ]
                                ),
                                // TableRow(
                                //     children: [
                                //       Text("Amount Received:",style: TextStyle(fontWeight: FontWeight.bold),),
                                //       Padding(
                                //         padding: const EdgeInsets.only(bottom:8.0),
                                //         child: Text(' ${deliveredorderdetailes.amountreceived[currentindex]}',style: TextStyle(fontSize: 15)),
                                //       ),
                                //     ]
                                // ),
                                // TableRow(
                                //     children: [
                                //       Text("Next Payment date:",style: TextStyle(fontWeight: FontWeight.bold),),
                                //       Padding(
                                //         padding: const EdgeInsets.only(bottom:8.0),
                                //         child: Text(' ${deliveredorderdetailes.nextpaymentdate[currentindex]}',style: TextStyle(fontSize: 15)),
                                //       ),
                                //     ]
                                // ),
                              ],
                            )
                        ),
                      ],
                    ),
                  ),

                ],
              )
          ),
        ),
      ),
    );
  }
}
