import 'dart:convert';
import 'package:eshop_multivendor/Helper/Constant.dart';
import 'package:eshop_multivendor/Model/newSellerModel.dart';
import 'package:eshop_multivendor/Screen/dashboard_restaurant.dart';
import 'package:http/http.dart'as http;
import 'package:eshop_multivendor/Helper/String.dart';
import 'package:eshop_multivendor/Screen/SubCategory.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';





class QRViewExample extends StatefulWidget {
  final String? title;
  final sellerId;
  final catId;
  final sellerData;
  QRViewExample({
    this.title,this.sellerId,this.sellerData,this.catId
  });

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}
StateSetter? checkoutState;

class _QRViewExampleState extends State<QRViewExample> {




  NewSellerModel? checkResult;
  String? scanData;
  var QrData;
checkCode()async{

  print("working here");
  var headers = {
    'Cookie': 'ci_session=037e475492e22b22dc37efe636bf60a361575fa8'
  };
  var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}check_qrcode'));
  request.fields.addAll({
    'qrcode': "${QrData}",
    'user_id':'${CUR_USERID}'
  });
  print("parameter here ${request.fields}");
  print("Scan Data--------- ${QrData}");
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  print("status code here ${response.statusCode}");
  if (response.statusCode == 200) {
    var finalResult = await response.stream.bytesToString();
    final jsonResponse = NewSellerModel.fromJson(json.decode(finalResult));
    print("status here now  and ${jsonResponse.error}");
    if(jsonResponse.error == false) {
      //setState(() {
        checkResult = jsonResponse;
     // });

     print("ooooooooooo  ${checkResult!.date![0].username}");
     print("ooooooooooo  ${json.encode(checkResult!.date![0])}");
     print("ooooooooooo  ${widget.title.toString()}");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
            RestaurantDashboard(title: widget.title.toString(),sellerId: checkResult!.date![0].userId.toString(),sellerData: json.encode(checkResult!.date![0]),
              showAll: true,)));
       // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SubCategory(title: widget.title.toString(),sellerId: checkResult!.date![0].userId.toString(),sellerData: checkResult!.date![0],)));
    }
  }
  else {
    var snackBar = SnackBar(
      content: Text('Qr code is Incorrect'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.pop(context);
  }

}

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? controller;
  bool scanning = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
      scanning = true;
    });

    controller.scannedDataStream.listen((scanData) {
      if (scanning) {
        scanning = false;
        controller.pauseCamera();
        QrData = scanData.code;
         processSubscription("${scanData.code}");
        print('kkkkkkkkkkkkkkkk${scanData.code}');
        checkCode();
      }
    });
  }
  void processSubscription(String subscriptionCode) {
    // Perform the necessary logic to handle the subscription code
    // For example, make an API call to verify the code and update the user's subscription

    // Show a success dialog or navigate to the appropriate screen
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Subscription Success'),
          content: Text('Your subscription has been activated.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Resume scanning
                scanning = true;
                controller?.resumeCamera();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
     print("checking seller id here ${widget.sellerId}");
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),

                _buildSquareCornersOverlay(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Scan a subscription QR code',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildSquareCornersOverlay() {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 4),
        ),
      ),
    );
  }
}


