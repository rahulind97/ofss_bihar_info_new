import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ofss_bihar_info/constants/Colors.dart';

import '../services/services.dart';

/*class ListViewModel {
  final String title;
  final String sub;
  final String sub1;

  ListViewModel({
    required this.title,
    required this.sub,
    required this.sub1,
  });
}

List listViewData = [
  ListViewModel(title: "+2 B.L.D H/S RANIGANJ,ARARIA", sub: "36", sub1: '123'),
];*/

class SeatStrength extends StatefulWidget {
  final String name;
  final String id;

  SeatStrength({required this.name, required this.id});

  @override
  _SeatStrengthState createState() => _SeatStrengthState();
}

class _SeatStrengthState extends State<SeatStrength> {
  List mySeatStrengthData = [];
  bool isLoading = true;

//This method is used for getting the seat strength data
  getseatstrengthdata() {
    print("id is>>>" + widget.id);
    seatStrengthData("2", widget.id, "0").then((value) {
      mySeatStrengthData.clear();
      Map result = json.decode(value.body);
      print(result);

      for (var i = 0;
          i < result["get_College_SubjectDetailsResult"].length;
          i++) {
        setState(() {
          if (result["get_College_SubjectDetailsResult"][i]['strSubjectList'] !='0') {
            mySeatStrengthData.add(result["get_College_SubjectDetailsResult"][i]);
          }
//          mySeatStrengthData.add(result["get_College_SubjectDetailsResult"][i]);
          print(mySeatStrengthData.length);
        });
      }
    });
  }

  @override
  initState() {
    super.initState();
    checkconnectivity();
  }

  _displaySnackBarError(msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: Duration(milliseconds: 300),
        backgroundColor: Color(0xffE11A29),
      ),
    );
  }

  checkconnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print(connectivityResult);
    if (connectivityResult == ConnectivityResult.none) {
      _displaySnackBarError(
          "You are not connected to internet.Please connect to internet and try again");
      Future.delayed(const Duration(milliseconds: 800), () {
        setState(() {
          isLoading = false;
        });
      });
    } else {
      getseatstrengthdata();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: mySeatStrengthData.isNotEmpty
          ? Wrap(
              children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, bottom: 5),
                    child: Center(
                        child: Text(
                      'Seat Strength',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.red.shade900,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                  Center(
                    child: SizedBox(
                      height: 3,
                      width: 60,
                      child: Container(
                        width: 60,
                        color: Colors.red.shade900,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 35,
                        left: MediaQuery.of(context).size.height / 40,
                        right: MediaQuery.of(context).size.height / 40),
                    child: Center(
                        child: Text(
                      widget.name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16
                          /*  color: Color(0xff89000a)*/
                          ),
                      textAlign: TextAlign.center,
                    )),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(top: 20.0, left: 15, right: 15),
                    child: Table(
                      border: TableBorder.all(color: appBarColor),
                      columnWidths: {
                        0: FlexColumnWidth(10),
                        1: FlexColumnWidth(10)
                      },
                      children: [
                        TableRow(
                            decoration: BoxDecoration(color: btnColor),
                            children: [
                              Padding(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.height / 50),
                                child: Text(
                                  'Stream ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.height / 50),
                                child: Text(
                                  'Strength',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ]),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 5.0),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: mySeatStrengthData.length,
                        itemBuilder: (context, int i) => Column(
                              children: <Widget>[
                                new ListTile(
                                  title: Table(
                                    border: TableBorder.all(
                                        color: appBarColor),
                                    columnWidths: {
                                      0: FlexColumnWidth(10),
                                      1: FlexColumnWidth(10)
                                    },
                                    children: [
                                      TableRow(
                                          decoration: BoxDecoration(
                                              color: Colors.white),
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      70),
                                              child: Text(
                                                  mySeatStrengthData[i]
                                                      ['strStreamName']),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      70),
                                              child: Text(
                                                mySeatStrengthData[i]
                                                    ['strSubjectList'],
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                          ]),
                                    ],
                                  ),
                                )
                              ],
                            )),
                  ),
                ]
      )
          : isLoading
              ? new Center(
                  child: Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height / 8,
                      width: MediaQuery.of(context).size.width / 1.6,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SpinKitCircle(
                              color: Colors.red,
                              size: 50.0,
                            ),
                            new Text(
                              'Loading...',
                              style: new TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            )
                          ]))

      )
              : new Center(
                  child: Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/no-wifi.png',
                                    ),
                                  ),
                                  shape: BoxShape.rectangle,
                                )),
                            new Text(
                              'No Internet Connection',
                              style: new TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w500),
                            )
                          ]))),
    );
  }
}
