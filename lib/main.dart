import './screens/home_login_page.dart';
import './screens/profile_page1.dart';
import 'package:flutter/material.dart';
import './screens/editDetails.dart';
import './screens/leads.dart';
import './screens/add_leads.dart';
import './screens/ViewLead.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        MyHomeLogin.routeName:(ctx) => MyHomeLogin(),
        ProfilePage1.routeName:(ctx) => ProfilePage1(),
        EditDetails.routeName:(ctx) => EditDetails(),
        Leads.routeName:(ctx) => Leads(),
        AddLeads.routeName:(ctx) => AddLeads(),
        CompleteLead.routeName:(ctx) => CompleteLead(),
      },
      home: Leads(id: '9871511555',),
      debugShowCheckedModeBanner: false,
    );
  }
}