import 'dart:html';
import 'package:flutter/material.dart';
import 'package:the_best_furniture/models/counts.dart';
import 'package:the_best_furniture/providers/screen_size.dart';
import 'package:the_best_furniture/widgets/custom_textstyle.dart';

class MyAdminAppBar extends StatefulWidget {
  @override
  State<MyAdminAppBar> createState() => _MyAdminAppBarState();
}

class _MyAdminAppBarState extends State<MyAdminAppBar> {
  int productCount=0;
  int orderCount=0;
  int liveOrderCount=0;
  int userCount=0;

  @override
    void initState() {
    super.initState();
     getCount();
  }

  Future<void> getCount() async{
    var productCountResult = await GetCounts.getTotalProductCount();
    var LiveOrderCountResult = await GetCounts.getLiveOrdersCount();
    var orderOrderCountResult = await GetCounts.getLiveOrdersCount();
    var userCountResult = await GetCounts.getTotalUserCount();
    setState(() {
       productCount = productCountResult;
       orderCount = orderOrderCountResult;
       liveOrderCount = LiveOrderCountResult;
       userCount = userCountResult;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SliverAppBar(
        expandedHeight: ScreenSize.screenHeight /1.5,
        elevation: 0,
        floating: true,
        pinned: false,
        snap: true,
        
        title: const Text(
          'Dashboard',style: MyTextStyle.subtitleStyle,
        ),
        
        flexibleSpace:  FlexibleSpaceBar(
          
          background: Container(
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/banner2.jfif'),fit: BoxFit.cover)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text('PRODUCTS\n$productCount',style: MyTextStyle.titleStyle),
                Text('USERS\n$userCount',style: MyTextStyle.titleStyle,),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ORDERS\n $orderCount',style: MyTextStyle.titleStyle),
                Text('LIVE ORDERS\n $liveOrderCount',style: MyTextStyle.titleStyle),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
