import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ViewCustomerData extends StatefulWidget {
  final String docId;
  ViewCustomerData({this.docId});

  @override
  _ViewCustomerDataState createState() => _ViewCustomerDataState();
}

class _ViewCustomerDataState extends State<ViewCustomerData> {
  String name;
  String price;
  String mobile;
  String note;
  String category;
  String area;
  String businessType;
  String _shopImageUrl;
  String _visitingImageUrl;
  String _picImageUrl;
  String gst_no;
  String status;

  getData() async {
    await Firestore.instance
        .collection("Clients")
        .document(widget.docId)
        .get()
        .then((DocumentSnapshot docs) {
      setState(() {
        name = docs["name"];
        price = docs["price"];
        mobile = docs["mobile"];
        note = docs["note"];
        category = docs["category"];
        area = docs["area"];
        businessType = docs["businessType"];
        _shopImageUrl = docs["_shopImageUrl"];
        _visitingImageUrl = docs["_visitingImageUrl"];
        status = docs["status"];
        _picImageUrl = docs["_picImageUrl"];
        gst_no = docs["gst_no"];
      });
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: status != null
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    width: double.infinity,
                    height: 75, 
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        'MAP HERE',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("PHONE",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              fontFamily: "ComicNeue-Light",
                            )),
                        Text(mobile,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontFamily: "ComicNeue-Light",
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("PRICE",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              fontFamily: "ComicNeue-Light",
                            )),
                        Text(price,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontFamily: "ComicNeue-Light",
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("CATEGORY",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              fontFamily: "ComicNeue-Light",
                            )),
                        Text(category,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontFamily: "ComicNeue-Light",
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("NOTE",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              fontFamily: "ComicNeue-Light",
                            )),
                        Container(
                          width: 200,
                          child: Text(
                            note,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontFamily: "ComicNeue-Light",
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                top: 10,
                                left: 10,
                                bottom: 0,
                              ),
                              child: Text(
                                "PIC",
                                style: TextStyle(
                                    fontFamily: "ComicNeue-Light",
                                    fontSize: 19,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              width: 110,
                              height: 110,
                              child: Image.network(
                                _picImageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                top: 10,
                                left: 10,
                                bottom: 0,
                              ),
                              child: Text(
                                "VISITING CARD",
                                style: TextStyle(
                                    fontFamily: "ComicNeue-Light",
                                    fontSize: 19,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              width: 110,
                              height: 110,
                              child: Image.network(
                                _visitingImageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  top: 10, left: 4, bottom: 0, right: 0),
                              child: Text(
                                "SHOP",
                                style: TextStyle(
                                    fontFamily: "ComicNeue-Light",
                                    fontSize: 19,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              width: 110,
                              height: 110,
                              child: Image.network(
                                _shopImageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : SpinKitCircle(color: Colors.black),
    );
  }
}
