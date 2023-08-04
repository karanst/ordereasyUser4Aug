import 'dart:convert';

import 'package:eshop_multivendor/Helper/Color.dart';
import 'package:eshop_multivendor/Helper/String.dart';
import 'package:eshop_multivendor/Model/newSellerModel.dart';
import 'package:eshop_multivendor/Screen/QrScanner.dart';
import 'package:eshop_multivendor/Screen/dashboard_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Helper/Constant.dart';
import '../Helper/Session.dart';
import 'SubCategory.dart';

class ScannerPage extends StatefulWidget {
  final String? title;
  final sellerId;
  final catId;
  final sellerData;

  ScannerPage({this.catId,this.title,this.sellerData,this.sellerId});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {

  TextEditingController codeController = TextEditingController();

  bool isCode = false;

  NewSellerModel? checkResult;

  checkCode()async{
    print("working here");
    var headers = {
      'Cookie': 'ci_session=037e475492e22b22dc37efe636bf60a361575fa8'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}check_qrcode'));
    request.fields.addAll({
      'qrcode': codeController.text,
      'user_id': CUR_USERID.toString(),
    });
    print("parameter here ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print("status code here ${response.statusCode}");
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = NewSellerModel.fromJson(json.decode(finalResult));
      if(jsonResponse.error == false) {
        //setState(() {
        checkResult = jsonResponse;
        // });
        print("ooooooooooo${checkResult!.date![0].userId}");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
            RestaurantDashboard(title: widget.title.toString(),sellerId: checkResult!.date![0].userId.toString(),sellerData: checkResult!.date![0],
            showAll: false,)));
      }
      else{
        var snackBar = SnackBar(
          content: Text('Entered code is Incorrect'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pop(context);
      }
    }
    else {
      print(response.reasonPhrase);
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("${widget.title}", context),
      body: WillPopScope(
        onWillPop: ()async{
          Navigator.pop(context,true);
          return false;
        },
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width/1,
                    child: Image.asset('assets/images/Qr_images.jpg',fit:BoxFit.fill,)),
               SizedBox(height: 10,),
                Text("${getTranslated(context, 'ScanOrEnterCode')}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                  SizedBox(height: 40,),
                Align(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    onPressed: (){
                      print("widget.title in scanner is ${widget.title}");
                    Navigator.push(context, MaterialPageRoute(builder: (context) => QRViewExample(title: widget.title,sellerData: widget.sellerData,catId: widget.catId,sellerId: widget.sellerId,)));
                  },child: Text("${getTranslated(context, 'ScanQrCode')}",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w600),),color: colors.primary,),
                ),
                SizedBox(height: 20,),
                Align(
                  alignment: Alignment.center,
                  child: MaterialButton(onPressed: (){
                    setState(() {
                      isCode = !isCode;
                    });
                  },child: Text("${getTranslated(context, 'EnterCode')}",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w600),),color: colors.primary,),
                ),


               isCode == true ? Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black)
                  ),
                  child: Column(
                    children: [
                      Text("${getTranslated(context, 'EnterPincodeHere')}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                      SizedBox(height: 10,),
                      TextFormField(
                        controller: codeController,
                        style: TextStyle(color: Colors.grey),
                        keyboardType: TextInputType.number,
                        maxLength: 9,
                        decoration: InputDecoration(
                          hintText: "${getTranslated(context, 'EnterPincodeHere')}",
                          counterText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black)
                          )
                        ),
                      ),
                        SizedBox(height: 20,),
                      MaterialButton(onPressed: (){
                       if(codeController.text.isEmpty){
                         var snackBar = SnackBar(
                           content: Text('Enter valid code!'),
                         );
                         ScaffoldMessenger.of(context).showSnackBar(snackBar);
                       }
                       else{
                         checkCode();
                       }
                      },child: Text("${getTranslated(context, 'submit')}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 15),),color: colors.primary,shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),)
                    ],
                  ),
                ) : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
