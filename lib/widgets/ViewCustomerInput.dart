import 'package:USERAPPRO/widgets/ViewTopCustomerData.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ViewCustomerInpu extends StatefulWidget {
  String docId;
  ViewCustomerInpu({this.docId});

  @override
  _ViewCustomerInpuState createState() => _ViewCustomerInpuState();
}

class _ViewCustomerInpuState extends State<ViewCustomerInpu> {
  final quantityController = TextEditingController();
  final unitController = TextEditingController();
  final serviceController = TextEditingController();
  final slotController = TextEditingController();

  getData() async {
    await Firestore.instance
        .collection("Clients")
        .document(widget.docId)
        .get()
        .then((DocumentSnapshot docs) {
      setState(() {
        quantityController.text = docs["quantity_per_day"];
        serviceController.text = docs["service_day"];
        unitController.text = docs["unit_price"];
        slotController.text = docs["Slot"];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: slotController.text != null
          ? Container(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Container(
                          width: 150,
                          margin: EdgeInsets.all(20),
                          child: TextField(
                            controller: quantityController,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                )),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelText: "QUANTITY / DAY",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          ),
                        ),
                        Expanded(
                            child: SizedBox(
                          width: 1,
                        )),
                        Container(
                          width: 130,
                          margin: EdgeInsets.all(20),
                          child: TextField(
                            controller: unitController,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                )),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelText: "UNIT PIECE ",
                                labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(20),
                    child: TextField(
                      controller: serviceController,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          )),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: "SERVICE DAY",
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(20),
                    child: TextField(
                      controller: slotController,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          )),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: "SLOT ",
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    ),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Text(
                      'START TRACKING',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.black,
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return SpinKitCircle(color: Colors.white);
                          });
                      await Firestore.instance
                          .collection("Clients")
                          .document(widget.docId)
                          .updateData({
                        "quantity_per_day": quantityController.text,
                        "service_day": serviceController.text,
                        "unit_price": unitController.text,
                        "Slot": slotController.text,
                      }).then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ViewTopCustomerData(
                                      docId: widget.docId,
                                    )));
                      });
                    },
                  )
                ],
              ),
            )
          : SpinKitCircle(color: Colors.black),
    );
  }
}
