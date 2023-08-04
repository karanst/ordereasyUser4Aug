import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop_multivendor/Helper/Constant.dart';
import 'package:eshop_multivendor/Helper/Session.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../Helper/AppBtn.dart';
import '../Helper/Color.dart';
import '../Helper/String.dart';
import '../Model/Notification_Model.dart';


class PostNotificationList extends StatefulWidget {
  const PostNotificationList({Key? key}) : super(key: key);

  @override
  State<PostNotificationList> createState() => _PostNotificationListState();
}

class _PostNotificationListState extends State<PostNotificationList> with TickerProviderStateMixin {
  bool _isNetworkAvail = true;
  bool _isLoading = true;
  List<NotificationModel> notiList = [];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  int offset = 0;
  int total = 0;
  bool isLoadingmore = true;
  List<NotificationModel> tempList = [];
  ScrollController controller = new ScrollController();
  Animation? buttonSqueezeanimation;
  AnimationController? buttonController;
  late TabController tabController;
  late PageController _pageController;

  _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      if (this.mounted) {
        if (mounted)
          setState(() {
            isLoadingmore = true;

            if (offset < total) getNotification();
          });
      }
    }
  }

  Future<Null> _playAnimation() async {
    try {
      await buttonController!.forward();
    } on TickerCanceled {}
  }

  Future<Null> _refresh() {
    if (mounted)
      setState(() {
        _isLoading = true;
      });
    offset = 0;
    total = 0;
    notiList.clear();
    return getNotification();
  }

  Future<Null> getNotification() async {
    _isNetworkAvail = await isNetworkAvailable();
    if (_isNetworkAvail) {
      try {
        var parameter = {
          LIMIT: perPage.toString(),
          OFFSET: offset.toString(),
          USER_ID: '$CUR_USERID',
          ICON: 'Post',
        };

        print('noti request is == ${parameter}');

        Response response =
        await post(getNotificationApi, headers: headers, body: parameter)
            .timeout(Duration(seconds: timeOut));
        if (response.statusCode == 200) {
          var getdata = json.decode(response.body);
          print("noti list == ${getdata}");

          bool error = getdata["error"];
          String? msg = getdata["message"];

          if (!error) {
            total = int.parse(getdata["total"]);

            if ((offset) < total) {
              tempList.clear();
              var data = getdata["data"];
              tempList = (data as List)
                  .map((data) => new NotificationModel.fromJson(data))
                  .toList();

              notiList.addAll(tempList);

              offset = offset + perPage;
            }
          } else {
            if (msg != "Products Not Found !")
              setSnackbar(msg!, context);
            isLoadingmore = false;
          }
        }
        if (mounted)
          setState(() {
            _isLoading = false;
          });
      } on TimeoutException catch (_) {
        setSnackbar("${getTranslated(context, 'somethingMSg')}", context);
        if (mounted)
          setState(() {
            _isLoading = false;
            isLoadingmore = false;
          });
      }
    } else if (mounted)
      setState(() {
        _isNetworkAvail = false;
      });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:       _isNetworkAvail
          ? _isLoading
          ? shimmer(context)
          : notiList.length == 0
          ? Padding(
          padding: const EdgeInsetsDirectional.only(
              top: kToolbarHeight),
          child: Center(
              child: Text(getTranslated(context, 'noNoti')!)))
          : RefreshIndicator(
          color: colors.primary,
          key: _refreshIndicatorKey,
          onRefresh: _refresh,
          child: ListView.builder(
            controller: controller,
            itemCount: (offset < total)
                ? notiList.length + 1
                : notiList.length,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return (index == notiList.length && isLoadingmore)
                  ? singleItemSimmer(context)
                  : listItem(index);
            },
          ))
          : noInternet(context),
    );
  }

  Widget listItem(int index) {
    NotificationModel model = notiList[index];
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${model.date?? ''}",
                    style: TextStyle(color: colors.primary),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "${model.title}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text("${model.desc}")
                ],
              ),
            ),
            model.img != null && model.img != ''
                ? GestureDetector(
              child: Container(
                width: 50,
                height: 50,
                child: Hero(
                  tag: '${model.id}',
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      "${model.img}",
                    ),
                    radius: 25,
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(new PageRouteBuilder(
                    opaque: false,
                    barrierDismissible: true,
                    pageBuilder: (BuildContext context, _, __) {
                      return new AlertDialog(
                        elevation: 0,
                        contentPadding: EdgeInsets.all(0),
                        backgroundColor: Colors.transparent,
                        content: new Hero(
                          tag: "${model.id}",
                          child: FadeInImage(
                            image: CachedNetworkImageProvider(model.img!),
                            fadeInDuration: Duration(milliseconds: 150),
                            placeholder: placeHolder(150),
                            imageErrorBuilder:
                                (context, error, stackTrace) =>
                                erroWidget(150),
                          ),
                        ),
                      );
                    }));

                // return showDialog(
                //     context: context,
                //     builder: (BuildContext context) {
                //       return StatefulBuilder(builder:
                //           (BuildContext context, StateSetter setStater) {
                //         return AlertDialog(
                //             backgroundColor: Colors.transparent,
                //             shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.all(
                //                     Radius.circular(5.0))),
                //             content: Hero(
                //               tag: model.id,
                //               child: FadeInImage(
                //                 image: NetworkImage(model.img),
                //                 fadeInDuration:
                //                     Duration(milliseconds: 150),
                //                 placeholder: placeHolder(150),
                //               ),
                //             ));
                //       });
                //     });
              },
            )
                : Container(
              height: 0,
            ),
          ],
        ),
      ),
    );
  }


  @override
  void initState() {
    getNotification();
    controller.addListener(_scrollListener);
    buttonController = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);

    buttonSqueezeanimation = new Tween(
      begin: deviceWidth! * 0.7,
      end: 50.0,
    ).animate(new CurvedAnimation(
      parent: buttonController!,
      curve: new Interval(
        0.0,
        0.150,
      ),
    ));


    super.initState();
  }

  @override
  void dispose() {
    buttonController!.dispose();
    super.dispose();
  }

  Widget noInternet(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          noIntImage(),
          noIntText(context),
          noIntDec(context),
          AppBtn(
            title: getTranslated(context, 'TRY_AGAIN_INT_LBL'),
            btnAnim: buttonSqueezeanimation,
              btnCntrl: buttonController,
            onBtnSelected: () async {
              _playAnimation();

              Future.delayed(Duration(seconds: 2)).then((_) async {
                _isNetworkAvail = await isNetworkAvailable();
                if (_isNetworkAvail) {
                  getNotification();
                } else {
                  await buttonController!.reverse();
                  if (mounted) setState(() {});
                }
              });
            },
          )
        ]),
      ),
    );
  }
}
