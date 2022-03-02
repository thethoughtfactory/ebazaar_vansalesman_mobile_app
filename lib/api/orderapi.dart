import 'dart:convert';

import 'package:http/http.dart' as http;

getOrders(driverid) async {
  Map body = {"driverId": driverid};
  print(jsonEncode(body));
  http.Response response = await http.post(
    Uri.parse("https://ebazaar.ae/rest/V1/jointable"),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode(body),
  );
  print(response.body);
  if (response.statusCode == 200) {
    var data = response.body;
    print("length : ${jsonDecode(data).length}");
    ordersyettodeliver = [];
    ordersDelivered = [];
    rejecteList = [];
    for (int i = 0; i < jsonDecode(data).length; i++) {
      String oid = jsonDecode(data)[i]["increment_id"];
      String ocustomerid = jsonDecode(data)[i]["customer_id"];
      String ograndtotal = jsonDecode(data)[i]["grand_total"];
      String oEntityId = jsonDecode(data)[i]["entity_id"];
      String oorderstatus = jsonDecode(data)[i]["status"];
      String osellerd = jsonDecode(data)[i]["seller_id"];
      String ovehicled = jsonDecode(data)[i]["vehicle_id"];
      String odriverid = jsonDecode(data)[i]["driver_id"];
      String ofirstname = jsonDecode(data)[i]["firstname"];
      String olastname = jsonDecode(data)[i]["lastname"];
      String otelephone = jsonDecode(data)[i]["telephone"];
      String oname = jsonDecode(data)[i]["name"];
      String oqtyordered = jsonDecode(data)[i]["qty_ordered"];
      String ostreet = jsonDecode(data)[i]["street"];
      String ocity = jsonDecode(data)[i]["city"];
      String opostcode = jsonDecode(data)[i]["postcode"];
      String oregion = jsonDecode(data)[i]["region"];
      String oaddresstype = jsonDecode(data)[i]["address_type"];
      String ocompanyname = jsonDecode(data)[i]["company_name"];
      String ocontact = jsonDecode(data)[i]["contact"];
      String oaddress = jsonDecode(data)[i]["address"];
      String oemail = jsonDecode(data)[i]["email"];
      String omethod = jsonDecode(data)[i]["method"];
      if (oorderstatus == "complete") {
        ordersDelivered.add(orders(
            orderID: oid,
            name: oname,
            address: oaddress,
            email: oemail,
            lastname: olastname,
            firstname: ofirstname,
            addresstype: oaddresstype,
            city: ocity,
            companyname: ocompanyname,
            contact: ocontact,
            customerid: ocustomerid,
            telephone: otelephone,
            driverid: odriverid,
            grandtotal: ograndtotal,
            orderstatus: oorderstatus,
            postcode: opostcode,
            qtyordered: oqtyordered,
            region: oregion,
            sellerd: osellerd,
            street: ostreet,
            vehicled: ovehicled,
            entityId: oEntityId,
            method: omethod ));
      } else if (oorderstatus == "canceled") {
        rejecteList.add(orders(
            orderID: oid,
            name: oname,
            address: oaddress,
            email: oemail,
            lastname: olastname,
            firstname: ofirstname,
            addresstype: oaddresstype,
            city: ocity,
            companyname: ocompanyname,
            contact: ocontact,
            customerid: ocustomerid,
            telephone: otelephone,
            driverid: odriverid,
            grandtotal: ograndtotal,
            orderstatus: oorderstatus,
            postcode: opostcode,
            qtyordered: oqtyordered,
            region: oregion,
            sellerd: osellerd,
            street: ostreet,
            vehicled: ovehicled,
            entityId: oEntityId,
            method: omethod));
      } else if (oorderstatus == "pending" || oorderstatus == "processing" ) {
        ordersyettodeliver.add(orders(
            orderID: oid,
            name: oname,
            address: oaddress,
            email: oemail,
            lastname: olastname,
            firstname: ofirstname,
            addresstype: oaddresstype,
            city: ocity,
            companyname: ocompanyname,
            contact: ocontact,
            customerid: ocustomerid,
            telephone: otelephone,
            driverid: odriverid,
            grandtotal: ograndtotal,
            orderstatus: oorderstatus,
            postcode: opostcode,
            qtyordered: oqtyordered,
            region: oregion,
            sellerd: osellerd,
            street: ostreet,
            vehicled: ovehicled,
            entityId: oEntityId,
            method: omethod));
      }
    }
  } else {
    print("orders Api error - Status code:${response.statusCode}");
  }
}

List<orders> ordersyettodeliver = [];
List<orders> ordersDelivered = [];
List<orders> rejecteList = [];

class orders {
  final String orderID;
  final String name;
  final String address;
  final String email;
  final String lastname;
  final String firstname;
  final String addresstype;
  final String city;
  final String companyname;
  final String contact;
  final String customerid;
  final String telephone;
  final String driverid;
  final String grandtotal;
   String orderstatus;
  final String postcode;
  final String qtyordered;
  final String region;
  final String sellerd;
  final String street;
  final String vehicled;
  final String entityId;
  final String method;

  orders(
      {this.orderID,
      this.name,
      this.address,
      this.email,
      this.lastname,
      this.firstname,
      this.addresstype,
      this.city,
      this.companyname,
      this.contact,
      this.customerid,
      this.telephone,
      this.driverid,
      this.grandtotal,
      this.orderstatus,
      this.postcode,
      this.qtyordered,
      this.region,
      this.sellerd,
      this.street,
      this.vehicled,
      this.entityId,
      this.method,});
}

// class ProductDetailResponse {
//   String increment_id;
//   String customer_id;
//   String grand_total;
//   String order_status;
//   String seller_id;
//   String driver_id;
//   String firstname;
//   String lastname;
//   String telephone;
//   String name;
//   String qty_ordered;
//   String driverid;
//
//   ProductDetailResponse(
//       {this.increment_id,
//         this.customer_id,
//         this.grand_total,
//         this.order_status,
//         this.seller_id,
//         this.driver_id,
//         this.firstname,
//         this.lastname,
//         this.telephone,
//         this.name,
//         this.qty_ordered,
//       this.driverid});
//
//   ProductDetailResponse.fromJson(Map<String, dynamic> json) {
//     increment_id = json['increment_id'];
//     customer_id = json['customer_id'];
//     grand_total = json['grand_total'];
//     order_status = json['order_status'];
//     seller_id = json['seller_id'];
//     driver_id = json['driver_id'];
//     firstname = json['firstname'];
//     lastname = json['lastname'];
//     telephone = json['telephone'];
//     name = json['name'];
//     qty_ordered = json['qty_ordered'];
//     driver_id = json['driver_id'];
//
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['increment_id'] = this.increment_id;
//     data['customer_id'] = this.customer_id;
//     data['grand_total'] = this.grand_total;
//     data['order_status'] = this.order_status;
//     data['seller_id'] = this.seller_id;
//     data['driver_id'] = this.driver_id;
//     data['firstname'] = this.firstname;
//     data['lastname'] = this.lastname;
//     data['telephone'] = this.telephone;
//     data['qty_ordered'] = this.qty_ordered;
//     data['driver_id'] = this.driver_id;
//     return data;
//   }
// }
//
// // List<orders> ordersyettodeliver = [];
// // List<orders> ordersDelivered = [];
//
// class orders {
//   final String orderID;
//   final String name;
//   final String address;
//   final String email;
//   final String lastname;
//   final String firstname;
//   final String addresstype;
//   final String city;
//   final String companyname;
//   final String contact;
//   final String customerid;
//   final String telephone;
//   final String driverid;
//   final String grandtotal;
//   final String orderstatus;
//   final String postcode;
//   final String qtyordered;
//   final String region;
//   final String sellerd;
//   final String street;
//   final String vehicled;
//   orders(
//       { this.orderID,
//       this.name,
//       this.address,
//       this.email,
//       this.lastname,
//       this.firstname,
//       this.addresstype,
//       this.city,
//       this.companyname,
//       this.contact,
//       this.customerid,
//       this.telephone,
//       this.driverid,
//       this.grandtotal,
//       this.orderstatus,
//       this.postcode,
//       this.qtyordered,
//       this.region,
//       this.sellerd,
//       this.street,
//       this.vehicled});
// }
//
//
// Future<ProductDetailResponse> getOrders(driverid) async {
//   Map body = {"driverId": driverid};
//   print(jsonEncode(body));
//   http.Response response = await http.post(
//     Uri.parse("https://dev.ebazaar.ae/dev/rest/V1/jointable"),
//     headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//     },
//     body: jsonEncode(body),
//   );
//   return ProductDetailResponse.fromJson(json.decode(response.body));
//
// }
