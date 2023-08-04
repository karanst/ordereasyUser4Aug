
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../Helper/AppBtn.dart';
import '../Helper/Color.dart';
import '../Helper/Constant.dart';
import '../Helper/Session.dart';
import '../Helper/String.dart';
import '../Provider/UserProvider.dart';
import 'Cart.dart';
import 'Login.dart';
import 'OrderNotificationList.dart';
import 'PostNotificationList.dart';
import 'Search.dart';

class NotificationList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StateNoti();
}

class StateNoti extends State<NotificationList> with TickerProviderStateMixin {

  late TabController tabController;
  late PageController _pageController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {

    tabController = TabController(length: 2, vsync: this);
    _pageController = PageController(initialPage: tabController.index);
    tabController.addListener(() {
      _pageController.animateToPage(
        tabController.index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          backgroundColor: Theme.of(context).colorScheme.white,
          leading: Builder(
            builder: (BuildContext context) {
              return Container(
                margin: EdgeInsets.all(10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(4),
                  onTap: () => Navigator.of(context).pop(),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: colors.primary,
                    ),
                  ),
                ),
              );
            },
          ),
          title: Text(
            getTranslated(context,'NOTIFICATION')!,
            style: TextStyle(color: colors.primary, fontWeight: FontWeight.normal),
          ),
          actions: <Widget>[
            IconButton(
                icon: SvgPicture.asset(
                  imagePath + "search.svg",
                  height: 20,
                  color: colors.primary,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Search(),
                      ));
                }),

            Selector<UserProvider, String>(
              builder: (context, data, child) {
                return IconButton(
                  icon: Stack(
                    children: [
                      Center(
                          child: SvgPicture.asset(
                            imagePath + "appbarCart.svg",
                            color: colors.primary,
                          )),
                      (data != null && data.isNotEmpty && data != "0")
                          ? new Positioned(
                        bottom: 20,
                        right: 0,
                        child: Container(
                          //  height: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: colors.primary),
                          child: new Center(
                            child: Padding(
                              padding: EdgeInsets.all(3),
                              child: new Text(
                                data,
                                style: TextStyle(
                                    fontSize: 7,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.white),
                              ),
                            ),
                          ),
                        ),
                      )
                          : Container()
                    ],
                  ),
                  onPressed: () {
                    CUR_USERID != null
                        ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Cart(
                          fromBottom: false,
                        ),
                      ),
                    )
                        : Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    );
                  },
                );
              },
              selector: (_, homeProvider) => homeProvider.curCartCount,
            )
          ],
          bottom: TabBar(
            controller: tabController,
            labelColor: colors.primary,
            unselectedLabelColor: Theme.of(context)
                .colorScheme.lightBlack2,
            indicator: ShapeDecoration(
              shape: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: colors.primary,
                      width: 3,
                      style: BorderStyle.solid)),
            ),
            tabs: <Widget>[
              Text(
                'Post Notification',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              Text(
                'Order Notification',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ],
            onTap: (index) {
              tabController.index = index;
              setState(() {});
            },
          ),
        ),
        // appBar: getAppBar(getTranslated(context,'NOTIFICATION')!, context),
          key: _scaffoldKey,
          body:
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              tabController.index = index;
              setState(() {});
            },
            children: <Widget>[
              ///1st Index
              PostNotificationList(),

              ///2nd index
              OrderNotificationList()
            ],
          )
      )
    );
  }

}
