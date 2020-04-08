import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CompleteLead extends StatefulWidget {
  final DocumentSnapshot snap;

  CompleteLead({this.snap});

  static const routeName = '/complete-lead';

  @override
  _CompleteLeadState createState() => _CompleteLeadState();
}

class _CompleteLeadState extends State<CompleteLead> {

  String name ;
  String contact ;
  String note ;
  String price ;
  String category ;
  String subCategory ;
  String businessType ;
  String area ;
  String visitingCardLink;
  String shopImageLink ;

  getData() async {
    name = widget.snap["name"];
    contact = widget.snap["mobile"];
    note =  widget.snap["note"];
    price = widget.snap["price"];
    category = widget.snap["category"];
    shopImageLink = widget.snap["_shopImageUrl"];
    visitingCardLink = widget.snap["_visitingImageUrl"];
    area = widget.snap["area"];
  }
  @override
  void initState() { 
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Card(
          margin: EdgeInsets.all(0),
          child: Column(
            children: <Widget>[
              Text(name),
              Text(contact),
              Text(note),
              Text(price),
              Text(category),
              Text(area),
              Container(
                width: 200,
                height: 200,
                child: Image.network(
                  shopImageLink,
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                width: 200,
                height: 200,
                child: Image.network(
                  visitingCardLink,
                  fit: BoxFit.contain,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
