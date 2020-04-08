import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ViewData extends StatefulWidget {
  final String docId;
  ViewData({this.docId});

  @override
  _ViewDataState createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
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
      appBar: AppBar(
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.view_list,
              color: Colors.black,
            ),
          )
        ],
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "DATA VIEW",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: "ComicNeue-Light"),
        ),
      ),
      body: status != null
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 80,
                    margin: EdgeInsets.only(top: 0, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13)),
                          width: 80,
                          height: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(13),
                            child: Image.network(
                              _picImageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(name,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "ComicNeue-Bold",
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Text("GSTIN : ",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "ComicNeue-Bold",
                                      )),
                                  Text("$gst_no"),
                                ],
                              ),
                                 SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Text("BUSINESS : ",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "ComicNeue-Bold",
                                      )),
                                  Text("$businessType"),
                                ],
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: 10,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                          child: Text(
                            status,
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    width: double.infinity,
                    height: 75,
                    color: Colors.amber,
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
