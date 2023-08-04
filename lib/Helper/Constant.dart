import 'package:flutter/material.dart';

import '../Screen/Dashboard.dart';

final String appName = 'Order Easy';

final String packageName = 'com.order_easy.user';
final String androidLink = 'https://play.google.com/store/apps/details?id=';

final String iosPackage = 'com.order_easy.user';
final String iosLink = 'your ios link here';
final String appStoreId = '123456789';

final String deepLinkUrlPrefix = 'https://eshopmultivendor.page.link';
final String deepLinkName = 'Order Easy';

final int timeOut = 50;
const int perPage = 10;

//final String baseUrl = 'https://vendor.eshopweb.store/app/v1/api/';
// final String baseUrl = 'https://alphawizztest.tk/Order Easy_Ecom/app/v1/api/';
// final String baseUrl = 'https://foodontheways.com/app/v1/api/';
final String baseUrl = 'https://developmentalphawizz.com/mt/app/v1/api/';

final String imageUrl = 'https://developmentalphawizz.com/';
final String jwtKey = "0352e7a815f965e8e278d47976b8f9cf466e1f42";

class MyGlobalKey{
 static final GlobalKey<DashboardState> myTabPageKey =  GlobalKey<DashboardState>();
}

