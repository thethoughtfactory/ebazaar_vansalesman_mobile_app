import 'package:ebazar_delivery/ProgressHUD.dart';
import 'package:ebazar_delivery/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'api/order_cancel_api.dart';
import 'api/orderapi.dart';
import 'api/update_delivery_api.dart';
import 'constants.dart';
import 'dashboard.dart';

int currentindex = selectedindex.ordersummary;
double Totalbill = double.parse(ordersyettodeliver[currentindex].grandtotal);
bool ischecked = false;
bool isdelivered = false;
bool isrejected = false;
double amountreceivedinpercent;
var amountreceived;
String Dropdownterms;
double remainingamount;
List<String> Paymentterms = ['term1', 'term2', 'term3'];
List DropDownItems = Paymentterms.map((String val) {
  return new DropdownMenuItem<String>(
    value: val,
    child: new Text(val),
  );
}).toList();

class OrderSummary extends StatefulWidget {
  OrderSummary({this.isPending = false, this.order});

  final bool isPending;
  final orders order;

  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  GlobalKey<FormState> orderkey = GlobalKey<FormState>();
  TextEditingController amount = TextEditingController();
  TextEditingController reason = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool delivered = false;

  @override
  void initState() {
    super.initState();
    ischecked = false;
    isdelivered = false;
    isrejected = false;
  }

  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      child: GestureDetector(
        onTap: () {
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
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey, //color of shadow
                            //spreadRadius: 0.5, //spread radius
                            blurRadius: 3, // blur radius
                            offset: Offset(3, 4), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order Detailes",
                            style: TextStyle(color: red, fontSize: 16),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, top: 5.0),
                            child: Table(
                              columnWidths: {
                                0: FractionColumnWidth(.25),
                              },
                              children: [
                                TableRow(children: [
                                  Text(
                                    "Order id:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(' ${widget.order.orderID}',
                                        style: TextStyle(fontSize: 15)),
                                  ),
                                ]),
                                TableRow(children: [
                                  Text(
                                    "Order Item:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(' ${widget.order.name}',
                                        style: TextStyle(fontSize: 15)),
                                  ),
                                ]),
                                TableRow(children: [
                                  Text(
                                    "Quantity:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(' ${widget.order.qtyordered}',
                                        style: TextStyle(fontSize: 15)),
                                  ),
                                ]),
                                TableRow(children: [
                                  Text(
                                    "Name:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                        ' ${widget.order.firstname} ${widget.order.lastname}',
                                        style: TextStyle(fontSize: 15)),
                                  ),
                                ]),
                                TableRow(children: [
                                  Text(
                                    "Contact:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: SelectableText(
                                        ' ${widget.order.contact}',
                                        style: TextStyle(fontSize: 15)),
                                  ),
                                ]),
                                TableRow(children: [
                                  Text(
                                    "Address:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      ' ${widget.order.street},${widget.order.city},${widget.order.postcode}',
                                      style: TextStyle(fontSize: 15)),
                                ]),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              "Seller Detailes",
                              style: TextStyle(color: red, fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, top: 5.0),
                            child: Table(
                              columnWidths: {
                                0: FractionColumnWidth(.25),
                              },
                              children: [
                                TableRow(children: [
                                  Text(
                                    "Name:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(' ${widget.order.companyname}',
                                        style: TextStyle(fontSize: 15)),
                                  ),
                                ]),
                                TableRow(children: [
                                  Text(
                                    "Contact:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: SelectableText(
                                        ' ${widget.order.telephone}',
                                        style: TextStyle(fontSize: 15)),
                                  ),
                                ]),
                                TableRow(children: [
                                  Text(
                                    "Address:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(' ${widget.order.address}',
                                      style: TextStyle(fontSize: 15)),
                                ]),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              "Payment Info",
                              style: TextStyle(color: red, fontSize: 16),
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 5.0),
                              child: Table(
                                columnWidths: {
                                  0: FractionColumnWidth(.25),
                                },
                                children: [
                                  TableRow(children: [
                                    Text(
                                      "Method:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                          //'Cash on Delivery',
                                        ( widget.order.method == 'etisalatpay')?
                                        'Etisalat Pay':'Cash on Delivery',
                                          //'${widget.order.method}',
                                          style: TextStyle(fontSize: 15)),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Text(
                                      "Amount:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                          '${widget.order.grandtotal} AED',
                                          style: TextStyle(fontSize: 15)),
                                    ),
                                  ]),
                                ],
                              )),
                        ],
                      ),
                    ),
                    widget.order.orderstatus != 'canceled'
                        ? !delivered
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                    if( widget.order.method != 'etisalatpay')
                                // {
                                      GestureDetector(
                                        onTap: () {
                                          showCancelReason();
                                          // setState(() {
                                          //   isdelivered = false;
                                          //   isrejected = true;
                                          // });
                                        },
                                        child: Container(
                                          width: 80,
                                          margin: EdgeInsets.only(bottom: 10.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10.0),
                                            color: red,
                                          ),
                                          padding: EdgeInsets.all(10.0),
                                          child: Center(
                                              child: Text(

                                                'Cancel',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                      ),
      //},

                                  GestureDetector(
                                    onTap: () async {
                                      isApiCallProcess = true;
                                      Map<String, dynamic> body = {};
                                      body['IncrementId'] =
                                          widget.order.orderID;
                                      updateDeliveryApiCall(body)
                                          .then((bool value) {
                                        if (value != null && value) {
                                          isApiCallProcess = false;
                                          debugPrint(
                                              'value response --- ${value}');
                                          delivered = true;
                                          widget.order.orderstatus = "complete";
                                          ordersDelivered.add(ordersyettodeliver
                                              .elementAt(currentindex));
                                          ordersyettodeliver
                                              .removeAt(currentindex);
                                          setState(() {});
                                        }
                                      });
                                      // setState(() {
                                      //   isrejected = false;
                                      //   isdelivered = true;
                                      //   isApiCallProcess = true;
                                      // });
                                      // // await smtpExample(
                                      // //     Requestemailupdate(
                                      // //       receiver:"saran07@gmail.com",// ordersyettodeliver[currentindex].email,
                                      // //       subject: "eBazaar order has been Delivered",
                                      // //       message: "The Delivery for the eBazaar order No : ${ordersyettodeliver[currentindex].orderID} has been successfully delivered on ${DateFormat("yyyy-MM-dd").format(DateTime.now())} ${DateFormat("HH:mm:ss").format(DateTime.now())}.\nPlease update the Order Status.\nThank you for shopping with us.\n-eBazaar Team.",
                                      // //     )
                                      // // );
                                      //
                                      // // await getOrders(14);
                                      // setState(() {
                                      //   isApiCallProcess = false;
                                      // });

                                      // Flushbar(
                                      //   message: "An Email has been sent to the Distributor requesting to change the status of the order.",
                                      //   duration:  Duration(seconds: 5),
                                      //   backgroundColor:colorAccent,
                                      // )..show(context);
                                    },
                                    child: Container(
                                      width: 80,
                                      margin: EdgeInsets.only(bottom: 10.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: red,
                                      ),
                                      padding: EdgeInsets.all(10.0),
                                      child: Center(
                                          child: Text(
                                        'Deliver',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    ),
                                  ),
                                ],
                              )
                            : Container()
                        : widget.order.orderstatus == 'canceled'
                            ? Container(
                                width: 80,
                                margin: EdgeInsets.only(bottom: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: red,
                                ),
                                padding: EdgeInsets.all(10.0),
                                child: Center(
                                    child: Text(
                                  'Canceled',
                                  style: TextStyle(color: Colors.white),
                                )),
                              )
                            : Container(),
                    isdelivered == true
                        ? Column(
                            children: [
                              Container(
                                width: double.infinity,
                                margin:
                                    EdgeInsets.only(right: 10.0, left: 10.0),
                                padding: EdgeInsets.only(left: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey, //color of shadow
                                      //spreadRadius: 0.5, //spread radius
                                      blurRadius: 3, // blur radius
                                      offset: Offset(
                                          3, 4), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  controller: amount,
                                  cursorColor: red,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    amountreceived = value;
                                    if (amount.text == Totalbill.toString()) {
                                      amountreceivedinpercent = 100.00;
                                    } else {
                                      print((double.tryParse(amount.text) /
                                              Totalbill) *
                                          100);
                                      remainingamount = Totalbill -
                                          double.tryParse(amount.text);
                                      amountreceivedinpercent =
                                          ((int.tryParse(amount.text) /
                                                  Totalbill) *
                                              100);
                                    }
                                    //amount.clear();
                                    setState(() {
                                      ischecked = true;
                                    });
                                  },
                                  validator: (input) => input == null
                                      ? "This is a Required Field"
                                      : null,
                                  decoration: new InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.money,
                                      color: red,
                                    ),
                                    focusColor: red,
                                    hintText: "Enter amount received",
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      color: red,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                              ischecked == true
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Received payment Info",
                                            style: TextStyle(
                                                color: red, fontSize: 16),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, top: 10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Amount Received :",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
                                                        '${amountreceivedinpercent.toStringAsFixed(2)} %',
                                                        style: TextStyle(
                                                            fontSize: 15)),
                                                  ],
                                                ),
                                                amountreceivedinpercent < 100.00
                                                    ? Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Amount remaining :",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              SizedBox(
                                                                  width: 5),
                                                              Text(
                                                                  "${remainingamount.toStringAsFixed(2)} AED",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15)),
                                                            ],
                                                          ),
                                                          // Container(
                                                          // margin: EdgeInsets.fromLTRB(0,10.0,10.0,0),
                                                          //   padding: EdgeInsets.only(left: 10.0),
                                                          //   width: double.infinity,
                                                          //   decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10.0)),
                                                          //   child: DropdownButton(
                                                          //     elevation: 0,
                                                          //     dropdownColor: Colors.white,
                                                          //     isExpanded: true,
                                                          //     underline: SizedBox(),
                                                          //     iconEnabledColor: red,
                                                          //     iconSize: 35.0,
                                                          //     value: Dropdownterms,
                                                          //     onChanged: (newVal){
                                                          //       setState(() {
                                                          //         Dropdownterms = newVal;
                                                          //       });
                                                          //     },
                                                          //     items: DropDownItems,
                                                          //     hint: Text("Select Payments terms",style: TextStyle(color: red),),
                                                          //
                                                          //   ),
                                                          // ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Schedule Next Payment :",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              SizedBox(
                                                                child:
                                                                    EndDate(),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                    : SizedBox()
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: Center(
                                              child: GestureDetector(
                                                onTap: () async {
                                                  /// order update api call

                                                  // setState(() {
                                                  //   isApiCallProcess = true;
                                                  // });
                                                  //
                                                  // await getLocation();
                                                  // await address();
                                                  // print(getaddress
                                                  //     .currentaddress);
                                                  // await smtpExample(
                                                  //     Requestemailupdate(
                                                  //   receiver:
                                                  //       "saran07@gmail.com",
                                                  //   // ordersyettodeliver[currentindex].email,
                                                  //   subject:
                                                  //       "eBazaar order has been Delivered",
                                                  //   message:
                                                  //       "The Delivery for the eBazaar order No : ${ordersyettodeliver[currentindex].orderID} has been successfully delivered on ${DateFormat("yyyy-MM-dd").format(DateTime.now())} ${DateFormat("HH:mm:ss").format(DateTime.now())}.\nPlease update the Order Status.\nThank you for shopping with us.\n-eBazaar Team.",
                                                  // ));
                                                  //
                                                  // // updatedatabase.orderid = data.orderid[currentindex];
                                                  // // updatedatabase.customeracceptanceshdledate = 1;
                                                  // // updatedatabase.customeracceptance = 1;
                                                  // // updatedatabase.sendnotification = sellerdetails.contact[currentindex];
                                                  // // updatedatabase.sendemail = sellerdetails.email[currentindex];
                                                  // // updatedatabase.paymentterms = Dropdownterms;
                                                  // // updatedatabase.nextpaymentdate = DateFormat('yMd').format(ENDdate);
                                                  // // updatedatabase.remainingamount = remainingamount;
                                                  // // updatedatabase.receivedamount = amountreceived;
                                                  // // updatedatabase.receivedamountinpercent = '$amountreceivedinpercent';
                                                  // // updatedatabase.totalamount = '${orderdetailes.billamount[currentindex]}';
                                                  // // updatedatabase.seller_id = sellerdetails.id[currentindex];
                                                  // // updatedatabase.customer_id = buyerdetails.id[currentindex];
                                                  // // await updatedeliverdetailes();
                                                  // // //await updateorders();
                                                  // // deliveredorderdetailes.billamount.add('${orderdetailes.billamount[currentindex]} AED');
                                                  // // deliveredorderdetailes.buyercontact.add(buyerdetails.contact[currentindex]);
                                                  // // deliveredorderdetailes.buyername.add(buyerdetails.name[currentindex]);
                                                  // // deliveredorderdetailes.buyeraddress.add(buyerdetails.address[currentindex]);
                                                  // // deliveredorderdetailes.orderno.add(data.orderid[currentindex]);
                                                  // // deliveredorderdetailes.amountreceived.add('$amountreceived AED');
                                                  // // deliveredorderdetailes.nextpaymentdate.add(DateFormat('yMd').format(ENDdate));
                                                  // // deliveredorderdetailes.selleraddress.add(sellerdetails.address[currentindex]);
                                                  // // deliveredorderdetailes.sellercontact.add(sellerdetails.contact[currentindex]);
                                                  // // deliveredorderdetailes.sellername.add(sellerdetails.name[currentindex]);
                                                  // // deliveredorderdetailes.productname.add(orderdetailes.productname[currentindex]);
                                                  // // deliveredorderdetailes.productqnty.add(orderdetailes.productqnty[currentindex]);
                                                  // // orderdetailes.billamount.removeAt(currentindex);
                                                  // // buyerdetails.contact.removeAt(currentindex);
                                                  // // buyerdetails.name.removeAt(currentindex);
                                                  // // buyerdetails.address.removeAt(currentindex);
                                                  // // data.orderid.removeAt(currentindex);
                                                  // // sellerdetails.address.removeAt(currentindex);
                                                  // // sellerdetails.contact.removeAt(currentindex);
                                                  // // sellerdetails.name.removeAt(currentindex);
                                                  // // orderdetailes.productname.removeAt(currentindex);
                                                  // // orderdetailes.productqnty.removeAt(currentindex);
                                                  // setState(() {
                                                  //   isApiCallProcess = false;
                                                  // });
                                                  //
                                                  // Flushbar(
                                                  //   message:
                                                  //       "An Email has been sent to the Distributor requesting to change the status of the order.",
                                                  //   duration:
                                                  //       Duration(seconds: 5),
                                                  //   backgroundColor:
                                                  //       colorAccent,
                                                  // )..show(context);
                                                  //
                                                  // Future.delayed(
                                                  //     const Duration(
                                                  //         seconds: 2), () {
                                                  //   Navigator.of(context)
                                                  //       .pushAndRemoveUntil(
                                                  //           MaterialPageRoute(
                                                  //               builder:
                                                  //                   (context) =>
                                                  //                       DashBoard()),
                                                  //           (Route<dynamic>
                                                  //                   route) =>
                                                  //               false);
                                                  // });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    color: red,
                                                  ),
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Text(
                                                    'Submit',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          )
                        : SizedBox(),
                    isrejected == true
                        ? Column(
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.only(right: 10.0, left: 10.0),
                                padding: EdgeInsets.only(left: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey, //color of shadow
                                      //spreadRadius: 0.5, //spread radius
                                      blurRadius: 3, // blur radius
                                      offset: Offset(
                                          3, 4), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  controller: reason,
                                  cursorColor: red,
                                  keyboardType: TextInputType.number,
                                  validator: (input) => input == null
                                      ? "This is a Required Field"
                                      : null,
                                  decoration: new InputDecoration(
                                    focusColor: red,
                                    hintText: "Enter Reason",
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      color: red,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                  //     DashBoard()), (Route<dynamic> route) => false);
                                },
                                child: Container(
                                  width: 80,
                                  margin:
                                      EdgeInsets.only(bottom: 10.0, top: 10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: red,
                                  ),
                                  padding: EdgeInsets.all(10.0),
                                  child: Center(
                                      child: Text(
                                    'Submit',
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                            ],
                          )
                        : SizedBox(),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  bool validateform() {
    final form = orderkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void showCancelReason() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Order Cancel Reason',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Reason',
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: red))),
                      maxLines: 3,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter the reason';
                        } else
                          return null;
                      },
                      controller: reason,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              Navigator.pop(context, reason.text.trim());
                            }
                          },
                          child:
                              Text("Ok", style: TextStyle(color: Colors.white)),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0))),
                          color: red,
                          padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          );
        }).then((value) {
      if (value != null && (value as String).isNotEmpty) {
        Map<String, dynamic> body2 = {};
        body2['increment_id'] = int.parse(widget.order.orderID);
        body2['comment'] = value as String;
        Map<String, dynamic> body = {};
        body['data'] = body2;
        orderCancelApi(body, widget.order.orderID).then((bool value) {
          if (value) {
            widget.order.orderstatus = "canceled";
            rejecteList.add(ordersyettodeliver.elementAt(currentindex));
            ordersyettodeliver.removeAt(currentindex);
            setState(() {});
          }
          // orderNotifier.cancelReason.clear();
        });
      }
    });
  }
}

DateTime ENDdate = DateTime.now();

class EndDate extends StatefulWidget {
  @override
  _EndDateState createState() => _EndDateState();
}

class _EndDateState extends State<EndDate> {
  DateTime tomoroww = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: tomoroww,
      firstDate: tomoroww,
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.light(
              primary: red,
              onPrimary: Colors.white,
              surface: red,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.grey[100],
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != EndDate)
      setState(() {
        ENDdate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(
            "${ENDdate.toLocal()}".split(' ')[0],
            style: TextStyle(fontSize: 16),
          ),
          IconButton(
            icon: Icon(CupertinoIcons.calendar),
            onPressed: () => _selectDate(context),
          ),
        ],
      ),
    );
  }
}
