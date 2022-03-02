import 'dart:async';

import 'package:ebazar_delivery/app_config/environment_varriables.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

import 'ProgressHUD.dart';
import 'api/apiloginotp.dart';
import 'api/orderapi.dart';
import 'constants.dart';
import 'dashboard.dart';
import 'main.dart';

var otpenter;
var parsedotp = int.parse(otpenter);
var loginnumber;
String sendapimessage;
bool isotprequested;
var emiratesid;
int _otpCodeLength = 4;
Timer _timer;
int _start = 30;
bool isApiCallProcess = false;

const colorAccent = const Color(0xFFbc1f26);

class Login extends StatefulWidget {
  @override

  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> loginkey = GlobalKey<FormState>();
  GlobalKey<FormState> mobilenumberkey = GlobalKey<FormState>();
  TextEditingController otp = TextEditingController();
  TextEditingController mobilenumber = TextEditingController();
  TextEditingController EmiratesID = TextEditingController();
  bool otpsent = false;
  bool isotplogin = false;
  bool hidePassword = true;

  String _otpCode = "";

  _getSignatureCode() async {
    String signature = await SmsRetrieved.getAppSignature();
    print("signature $signature");
  }

  _onSubmitOtp() {
    setState(() {
      _verifyOtpCode();
    });
  }

  _verifyOtpCode() async {
    otpenter = _otpCode;
    print("otp entered: $otpenter");
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      print("auto fill otp:$otpCode");
      this._otpCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill) {
        print("verify otp function called");
        _verifyOtpCode();
      }
    });
  }

  void startTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    } else {
      _timer = new Timer.periodic(
        const Duration(seconds: 1),
        (Timer timer) => setState(
          () {
            if (_start < 1) {
              timer.cancel();
            } else {
              _start = _start - 1;
            }
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ProgressHUD(
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            backgroundColor: grey,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 64, bottom: 32),
                        alignment: Alignment.center,
                        child: Image.asset(
                          'images/logo.png',
                          width: 90,
                          height: 120,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 10.0,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 24.0,
                                bottom: 8.0,
                                left: 24.0,
                                right: 24.0),
                            child: Theme(
                              data: ThemeData(primaryColor: red),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Login",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  isotprequested == true
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Text(
                                            "OTP sent to $loginnumber",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0, bottom: 10.0),
                                          child: Form(
                                            key: loginkey,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 16),
                                                  child: TextFormField(
                                                    controller: EmiratesID,
                                                    cursorColor: Colors.grey,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    validator: (input) => input
                                                            .isEmpty
                                                        ? "Emirates ID Cannot be empty"
                                                        : null,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      labelText: "Emirates ID",
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              top: 4.0),
                                                      labelStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 18),
                                                      prefixIcon: Container(
                                                        width: 0,
                                                        alignment: Alignment(
                                                            -0.99, 0.0),
                                                        child: Icon(
                                                          CupertinoIcons
                                                              .doc_plaintext,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 16),
                                                  child: TextFormField(
                                                    controller: mobilenumber,
                                                    cursorColor: Colors.grey,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    validator: (input) => input
                                                            .isEmpty
                                                        ? "Mobile number Cannot be empty"
                                                        : null,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      labelText:
                                                          "Mobile Number",
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              top: 4.0),
                                                      labelStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 18),
                                                      prefixIcon: Container(
                                                        width: 0,
                                                        alignment: Alignment(
                                                            -0.99, 0.0),
                                                        child: Icon(
                                                          CupertinoIcons
                                                              .device_phone_portrait,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                  isotprequested == true
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15.0, bottom: 20.0),
                                          child: Column(
                                            children: [
                                              TextFieldPin(
                                                filled: true,
                                                filledColor: Colors.grey[100],
                                                codeLength: _otpCodeLength,
                                                boxSize: 40,
                                                onOtpCallback: (code,
                                                        isAutofill) =>
                                                    _onOtpCallBack(
                                                        code, isAutofill),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20.0),
                                                child: _start != 0
                                                    ? Text(
                                                        'Request OTP in $_start sec')
                                                    : Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          GestureDetector(
                                                              onTap: () {
                                                                //SendOtpapi();
                                                                _start = 60;
                                                                setState(() {
                                                                  startTimer();
                                                                  startTimer();
                                                                });
                                                              },
                                                              child: Text(
                                                                "Request OTP",
                                                                style: TextStyle(
                                                                    color:
                                                                        colorAccent,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ))
                                                        ],
                                                      ),
                                              )
                                            ],
                                          ),
                                        )
                                      : SizedBox(),
                                  isotprequested == true
                                      ? GestureDetector(
                                          onTap: () async {
                                            setState(() {
                                              isApiCallProcess = true;
                                            });
                                            // bool resultofotp = await VerifyOtpapi();
                                            // print("OTP Verified Result:${resultofotp}");
                                            // if(resultofotp==true){
                                            await _onSubmitOtp();
                                            otpenter = _otpCode;
                                            bool result = await VerifyOtpapi();
                                            print(result);
                                            print("otp entered is ${otpenter}");
                                            DriverId = "18";
                                            if (result) {
                                              await getOrders(DriverId);
                                              setState(() {
                                                isApiCallProcess = false;
                                              });
                                              addLogindetails();

                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          DashBoard()));
                                            }

                                            // }
                                            // else if(resultofotp==false){
                                            //     print(" Drier Id is null");
                                            //   }
                                            else {
                                              Flushbar(
                                                backgroundColor: colorAccent,
                                                message: sendapimessage == null
                                                    ? ""
                                                    : sendapimessage,
                                                duration: Duration(seconds: 5),
                                              )..show(context);
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(10.0),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: red,
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            child: Center(
                                                child: Text(
                                              "Login",
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  color: Colors.white),
                                            )),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () async {
                                            if (validateform()) {
                                              setState(() {
                                                isApiCallProcess = true;
                                              });
                                              print(mobilenumber.text);
                                              loginnumber = mobilenumber.text;
                                              emiratesid = EmiratesID.text;
                                              var result = await SendOtpapi();
                                              if (result) {
                                                isotprequested = true;
                                                setState(() {
                                                  startTimer();
                                                  isApiCallProcess = false;
                                                });
                                                Flushbar(
                                                  message:
                                                      sendapimessage == null
                                                          ? " "
                                                          : sendapimessage,
                                                  duration:
                                                      Duration(seconds: 5),
                                                  backgroundColor: colorAccent,
                                                )..show(context);
                                              } else {
                                                setState(() {
                                                  isApiCallProcess = false;
                                                });
                                                Flushbar(
                                                  message:
                                                      sendapimessage == null
                                                          ? " "
                                                          : sendapimessage,
                                                  duration:
                                                      Duration(seconds: 5),
                                                  backgroundColor: colorAccent,
                                                )..show(context);
                                              }
                                            }
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: 20),
                                            padding: EdgeInsets.fromLTRB(
                                                10.0, 10, 15, 15),
                                            //width: 160,
                                            decoration: BoxDecoration(
                                              color: red,
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                            ),
                                            child: Center(
                                                child: Text(
                                              "Request OTP",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            )),
                                          ),
                                        ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    isotprequested == true
                                        ? "* Enter OTP *"
                                        : "* Enter Mobile Number without Country code *",
                                    style: TextStyle(fontSize: 11),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
      ),
    );
  }

  bool validateform() {
    final form = loginkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}

addLogindetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("mobile number : $loginnumber ");
  print("Driver ID : $DriverId ");
  prefs.setString('mobilenumber', "$loginnumber");
  prefs.setString('driverid', "$DriverId");
}

removeLoginValues() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('mobilenumber');
  prefs.remove('driverid');
  print("mobile number : $loginnumber ");
  print("driverid : $DriverId");
}
