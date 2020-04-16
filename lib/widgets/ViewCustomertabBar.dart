
import 'package:USERAPPRO/widgets/ViewCustomerData.dart';
import 'package:USERAPPRO/widgets/ViewCustomerInput.dart';
import 'package:flutter/material.dart';

class CustomerTabBar extends StatefulWidget {
  final String docId;
  CustomerTabBar({this.docId});
  @override
  _CustomerTabBarState createState() => _CustomerTabBarState();
}

class _CustomerTabBarState extends State<CustomerTabBar>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            indicator: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              color: Colors.green,
            ),
            unselectedLabelColor: Colors.white,
            labelColor: Colors.amber,
            isScrollable: true,
            tabs: [
              Tab(
                child: Text(
                  'INPUT',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  'DETAILS',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
            controller: _tabController,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          bottomOpacity: 1,
        ),
      ),
      body: Container(
        width: double.infinity,
        child: TabBarView(
          children: [
            ViewCustomerInpu(
              docId: widget.docId,
            ),
            ViewCustomerData(
              docId: widget.docId,
            ),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}
