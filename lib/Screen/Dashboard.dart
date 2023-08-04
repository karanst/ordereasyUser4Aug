import 'dart:async';
import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eshop_multivendor/Helper/Color.dart';
import 'package:eshop_multivendor/Helper/Constant.dart';
import 'package:eshop_multivendor/Helper/PushNotificationService.dart';
import 'package:eshop_multivendor/Helper/Session.dart';
import 'package:eshop_multivendor/Helper/String.dart';
import 'package:eshop_multivendor/Helper/app_assets.dart';
import 'package:eshop_multivendor/Model/Section_Model.dart';
import 'package:eshop_multivendor/Provider/UserProvider.dart';
import 'package:eshop_multivendor/Screen/Favorite.dart';
import 'package:eshop_multivendor/Screen/Login.dart';
import 'package:eshop_multivendor/Screen/MyProfile.dart';
import 'package:eshop_multivendor/Screen/Product_Detail.dart';
import 'package:eshop_multivendor/Screen/about_us.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'All_Category.dart';
import 'Cart.dart';
import 'HomePage.dart';
import 'NotificationLIst.dart';
import 'Sale.dart';
import 'Search.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Dashboard extends StatefulWidget {
   Dashboard({required Key key,}) : super(key: key);

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  int selBottom = 0;
  late TabController tabController;
  bool _isNetworkAvail = true;
  String? User_email;
  String? User_name;

  getSharedData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User_email = prefs.getString('user_email');
    User_name = prefs.getString('user_name');
    print("user email is ${User_email}");
    print("user name is ${User_name}");

    await callChat();
  }


  @override
  void initState() {
    getSettings();
    getSharedData();

    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    super.initState();
    initDynamicLinks();
    tabController = TabController(
      length: 4,
      vsync: this,
    );

    final pushNotificationService = PushNotificationService(
        context: context, tabController: tabController);
    pushNotificationService.initialise();

    tabController.addListener(
      () {
        Future.delayed(Duration(seconds: 0)).then(
          (value) {
            if (tabController.index == 1) {
              if (CUR_USERID == null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
                tabController.animateTo(0);
              }
            }
          },
        );

        setState(
          () {
            selBottom = tabController.index;
          },
        );
      },
    );
  }

  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      final Uri? deepLink = dynamicLink?.link;

      if (deepLink != null) {
        if (deepLink.queryParameters.length > 0) {
          int index = int.parse(deepLink.queryParameters['index']!);

          int secPos = int.parse(deepLink.queryParameters['secPos']!);

          String? id = deepLink.queryParameters['id'];

          String? list = deepLink.queryParameters['list'];

          getProduct(id!, index, secPos, list == "true" ? true : false);
        }
      }
    }, onError: (OnLinkErrorException e) async {
      print(e.message);
    });

    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;
    if (deepLink != null) {
      if (deepLink.queryParameters.length > 0) {
        int index = int.parse(deepLink.queryParameters['index']!);

        int secPos = int.parse(deepLink.queryParameters['secPos']!);

        String? id = deepLink.queryParameters['id'];

        // String list = deepLink.queryParameters['list'];

        getProduct(id!, index, secPos, true);
      }
    }
  }

  Future<void> getProduct(String id, int index, int secPos, bool list) async {
    _isNetworkAvail = await isNetworkAvailable();
    if (_isNetworkAvail) {
      try {
        var parameter = {
          ID: id,
        };

        // if (CUR_USERID != null) parameter[USER_ID] = CUR_USERID;
        Response response =
            await post(getProductApi, headers: headers, body: parameter)
                .timeout(Duration(seconds: timeOut));

        var getdata = json.decode(response.body);

        print("response=${getdata}");
        bool error = getdata["error"];
        String msg = getdata["message"];
        if (!error) {
          var data = getdata["data"];

          List<Product> items = [];

          items =
              (data as List).map((data) => new Product.fromJson(data)).toList();

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductDetail(
                    index: list ? int.parse(id) : index,
                    model: list
                        ? items[0]
                        : sectionList[secPos].productList![index],
                    secPos: secPos,
                    list: list,
                  )));
        } else {
          if (msg != "Products Not Found !") setSnackbar(msg, context);
        }
      } on TimeoutException catch (_) {
        setSnackbar(getTranslated(context, 'somethingMSg')!, context);
      }
    } else {
      {
        if (mounted)
          setState(() {
            _isNetworkAvail = false;
          });
      }
    }
  }

  ///for firebase chat
  callChat() async {
    String? name = User_name;
    String? email = User_email;
    print('email inside callchat == ${email}');
    try {
      UserCredential data =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.toString().trim(),
        password: "alpha@123",
      );
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: name.toString(),
          id: data.user!.uid,
          imageUrl: 'https://i.pravatar.cc/300?u=${email.toString()}',
          lastName: "",
        ),
      );
      updateFid(data.user!.uid);
    } catch (e) {
      print('${e}');
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.toString().trim(),
        password: "alpha@123",
      );
      // App.localStorage.setString("firebaseUid", credential.user!.uid);
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: name.toString(),
          id: credential.user!.uid,
          imageUrl: 'https://i.pravatar.cc/300?u=${email.toString()}',
          lastName: "",
        ),
      );
      updateFid(credential.user!.uid);
      print(e.toString());
    }
    print("user created");
  }

  ///api for fuid
  updateFid(FUID) async{
    var params = {
      FU_ID : '${FUID}',
      USER_ID : '${CUR_USERID}'
    };

    print("url is $updateFuid");
    print("params is $params");

    var response = await http.post(updateFuid, body: params);
    var jsonResponse = convert.jsonDecode(response.body);
    print(" = ${jsonResponse['message']}");

    /// If the first API call is successful
    if (response.statusCode == 200) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (tabController.index != 0) {
          tabController.animateTo(0);
          return false;
        }
        return true;
      },
      child: Scaffold(

        backgroundColor: Theme.of(context).colorScheme.lightWhite,
        appBar: _getAppBar(),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            HomePage(),
            // AllCategory(),
            Sale(),
            MyProfile(),
            AboutUsScreen(
                title: getTranslated(context, 'ABOUT_LBL'),
              ),

            // Cart(
            //   fromBottom: true,
            // ),

          ],
        ),
        //fragments[_selBottom],
        // bottomNavigationBar: _getBottomBar(),
        bottomNavigationBar: _getBottomNavigator(),
      ),
    );
  }

  String? appLogo;
  bool isLoading= false;

  getSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });
    var parameter = {};
    _isNetworkAvail = await isNetworkAvailable();
    if (_isNetworkAvail) {
      apiBaseHelper.postAPICall(getSettingApi, parameter).then(
            (getdata) async {
          bool error = getdata["error"];
          String msg = getdata["message"];
          if (!error) {
            appLogo = getdata["data"]["logo"][0].toString();
            prefs.setString('appLogo', appLogo!);
            print("get_settings logo data $appLogo");
          } else {
            setSnackbar(msg, context);
          }
          setState(() {
            isLoading = false;
          });
        },
        onError: (error) {
          setSnackbar(error.toString(), context);
        },
      );
    } else {
      setState(
            () {
          isLoading = false;
          _isNetworkAvail = false;
        },
      );
    }
  }

  AppBar _getAppBar() {
    String? title;
    if (selBottom == 1)
      title = getTranslated(context, 'SUBSCRIPTION');
    //  title = getTranslated(context, 'CATEGORY');
    else if (selBottom == 2)
      title = getTranslated(context, 'PROFILE');
    //title = getTranslated(context, 'OFFER');
    else if (selBottom == 3) title = getTranslated(context, 'ABOUT_LBL');
    // title = getTranslated(context, 'MYBAG');
    // else if (_selBottom == 4)
    //   title = getTranslated(context, 'PROFILE');

    return AppBar(
      centerTitle: selBottom == 0 ? true : false,
      title:


      selBottom != 0? Text(
        title.toString(),
        style: TextStyle(
            color: colors.primary, fontWeight: FontWeight.normal),
      ):
      isLoading == true ? Container():
      appLogo != null || appLogo != "" ?
      Image.network(appLogo!, fit: BoxFit.contain,height: 75,):
      Image.asset(
              // 'assets/images/titleicon.png',
              MyAssets.normal_logo,
              //height: 40,

              // width: 150,
              height: 50,

              // color: colors.primary,
              // width: 45,
            ),

      leading: selBottom == 0
          ? InkWell(
              child: Center(
                  child: SvgPicture.asset(
                imagePath + "search.svg",
                height: 20,
                color: colors.primary,
              )),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Search(),
                    ));
              },
            )
          : null,
      // iconTheme: new IconThemeData(color: colors.primary),
      // centerTitle:_curSelected == 0? false:true,
      actions: <Widget>[
        selBottom == 0 || selBottom == 4
            ? Container()
            : IconButton(
                icon: SvgPicture.asset(
                  imagePath + "search.svg",
                  height: 20,
                  color: colors.primary,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Search(isSubscription: selBottom==1? true:false),
                      ));
                }),
        selBottom == 4
            ? Container()
            : IconButton(
                icon: SvgPicture.asset(
                  imagePath + "desel_notification.svg",
                  color: colors.primary,
                ),
                onPressed: () {
                  CUR_USERID != null
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationList(),
                          ))
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ));
                },
              ),
        // _selBottom == 4
        //     ? Container()
        //     : IconButton(
        //         padding: EdgeInsets.all(0),
        //         icon: SvgPicture.asset(
        //           imagePath + "desel_fav.svg",
        //           color: colors.primary,
        //         ),
        //         onPressed: () {
        //           CUR_USERID != null
        //               ? Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                     builder: (context) => Favorite(),
        //                   ))
        //               : Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                     builder: (context) => Login(),
        //                   ));
        //         },
        //       ),
      ],
      backgroundColor: Theme.of(context).colorScheme.white,
    );
  }

  Widget _getBottomBar() {
    return Material(
        color: Theme.of(context).colorScheme.white,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.white,
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).colorScheme.black26, blurRadius: 10)
            ],
          ),
          child: TabBar(
            onTap: (_) {
              if (tabController.index == 3) {
                if (CUR_USERID == null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  );
                  tabController.animateTo(0);
                }
              }
            },
            controller: tabController,
            tabs: [
              Tab(
                icon: selBottom == 0
                    ? SvgPicture.asset(
                        imagePath + "sel_home.svg",
                        color: colors.primary,
                      )
                    : SvgPicture.asset(
                        imagePath + "desel_home.svg",
                        color: colors.primary,
                      ),
                text:
                    selBottom == 0 ? getTranslated(context, 'HOME_LBL') : null,
              ),
              // Tab(
              //   icon: _selBottom == 1
              //       ? SvgPicture.asset(
              //           imagePath + "category01.svg",
              //           color: colors.primary,
              //         )
              //       : SvgPicture.asset(
              //           imagePath + "category.svg",
              //           color: colors.primary,
              //         ),
              //   text:
              //       _selBottom == 1 ? getTranslated(context, 'category') : null,
              // ),
              Tab(
                icon: selBottom == 1
                    ? SvgPicture.asset(
                        imagePath + "sale02.svg",
                        color: colors.primary,
                      )
                    : SvgPicture.asset(
                        imagePath + "sale.svg",
                        color: colors.primary,
                      ),
                text: selBottom == 1 ? getTranslated(context, 'SALE') : null,
              ),
              Tab(
                icon: Selector<UserProvider, String>(
                  builder: (context, data, child) {
                    return Stack(
                      children: [
                        Center(
                          child: selBottom == 2
                              ? SvgPicture.asset(
                                  imagePath + "cart01.svg",
                                  color: colors.primary,
                                )
                              : SvgPicture.asset(
                                  imagePath + "cart.svg",
                                  color: colors.primary,
                                ),
                        ),
                        (data != null && data.isNotEmpty && data != "0")
                            ? new Positioned.directional(
                                bottom: selBottom == 2 ? 6 : 20,
                                textDirection: Directionality.of(context),
                                end: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: colors.primary),
                                  child: new Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(3),
                                      child: new Text(
                                        data,
                                        style: TextStyle(
                                            fontSize: 7,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .white),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    );
                  },
                  selector: (_, homeProvider) => homeProvider.curCartCount,
                ),
                text: selBottom == 3 ? getTranslated(context, 'CART') : null,
              ),
              Tab(
                icon: selBottom == 3
                    ? SvgPicture.asset(
                        imagePath + "profile01.svg",
                        color: colors.primary,
                      )
                    : SvgPicture.asset(
                        imagePath + "profile.svg",
                        color: colors.primary,
                      ),
                text:
                    selBottom == 3 ? getTranslated(context, 'ACCOUNT') : null,
              ),
            ],
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: colors.primary, width: 5.0),
              insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 70.0),
            ),
            labelStyle: TextStyle(fontSize: 9),
            labelColor: colors.primary,
          ),
        ));
  }

  Widget _getBottomNavigator() {
    return Material(
       color: Colors.transparent,
      elevation: 0,
      child: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.transparent,
        items: <Widget>[
          Icon(Icons.home, color: colors.primary,size: 30),
          ImageIcon(AssetImage('assets/images/subscription.png'), size: 60,color: colors.primary,),
          Icon(Icons.person, color: colors.primary, size: 30),
          Icon(Icons.info_outlined, color: colors.primary,size: 30),
          //Icon(Icons.category, size: 30),
          // Container(
          //   padding: EdgeInsets.all(4),
          //   child: Column(
          //     children: [
          //       Icon(Icons.local_offer_outlined, size: 30),
          //       // _selBottom == 1
          //       //     ? Text(
          //       //   getTranslated(context, 'HOME_LBL')!,
          //       //         style: TextStyle(
          //       //             color: colors.primary,
          //       //             fontSize: 10,
          //       //             fontWeight: FontWeight.w600),
          //       //       )
          //       //     : SizedBox.shrink()
          //     ],
          //   ),
          // ),
          //
          // Container(
          //   padding: EdgeInsets.all(4),
          //   child: Column(
          //     children: [
          //       Icon(Icons.person, size: 30),
          //       // _selBottom == 2
          //       //     ? Text(
          //       //   getTranslated(context, 'PROFILE')!,
          //       //   style: TextStyle(
          //       //       color: colors.primary,
          //       //       fontSize: 10,
          //       //       fontWeight: FontWeight.w600),
          //       // )
          //       //     : SizedBox.shrink()
          //     ],
          //   ),
          // ),
          //
          // Container(
          //   padding: EdgeInsets.all(4),
          //   child: Column(
          //     children: [
          //       Icon(Icons.info_outlined, size: 30),
          //       // _selBottom == 3
          //       //     ? Text(
          //       //   getTranslated(context, 'ABOUT_LBL')!,
          //       //         style: TextStyle(
          //       //             color: colors.primary,
          //       //             fontSize: 10,
          //       //             fontWeight: FontWeight.w600),
          //       //       )
          //       //     : SizedBox.shrink()
          //     ],
          //   ),
          // ),

          // Padding(
          //   padding:  EdgeInsets.only(top: _selBottom == 3
          //       ? 0 : 10.0),
          //   child: Container(
          //     padding: EdgeInsets.all(4),
          //     child: Column(
          //       children: [
          //         Icon(Icons.person, size: 30),
          //         _selBottom == 3
          //             ? Text(
          //                 "Profile",
          //                 style: TextStyle(
          //                     color: colors.primary,
          //                     fontSize: 10,
          //                     fontWeight: FontWeight.w600),
          //               )
          //             : SizedBox.shrink()
          //       ],
          //     ),
          //   ),
          // ),
        ],
        onTap: (index) {
          tabController.animateTo(index);
          setState(() {});
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }
}
