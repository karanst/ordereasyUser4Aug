import 'package:eshop_multivendor/Helper/Color.dart';
import 'package:eshop_multivendor/Screen/Intro_Slider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../Helper/Session.dart';
import '../main.dart';

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({Key? key}) : super(key: key);

  @override
  State<SelectLanguage> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  
  String? languageSelected;
  List<String> langCode = ['en','he','ar'];
  List<String?> themeList = [];
  List<String?> languageList = [];
  int? selectLan;
  List<Widget> getLngList(BuildContext ctx) {
    return languageList
        .asMap()
        .map(
          (index, element) => MapEntry(
          index,
          InkWell(
            onTap: () {
              print("selected index here ${index}");
              if (mounted)
                setState(() {
                  selectLan = index;
                  _changeLan(langCode[index], ctx);
                });
              setState(() {

              });
             // setModalState(() {});
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 25.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selectLan == index
                                ? colors.grad2Color
                                : Theme.of(context).colorScheme.white,
                            border: Border.all(color: colors.grad2Color)),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: selectLan == index
                              ? Icon(
                            Icons.check,
                            size: 17.0,
                            color: Theme.of(context)
                                .colorScheme
                                .fontColor,
                          )
                              : Icon(
                            Icons.check_box_outline_blank,
                            size: 15.0,
                            color:
                            Theme.of(context).colorScheme.white,
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: 15.0,
                          ),
                          child: Text(
                            languageList[index]!,
                            style: Theme.of(this.context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .lightBlack),
                          ))
                    ],
                  ),
                  // index == languageList.length - 1
                  //     ? Container(
                  //         margin: EdgeInsetsDirectional.only(
                  //           bottom: 10,
                  //         ),
                  //       )
                  //     : Divider(
                  //         color: Theme.of(context).colorScheme.lightBlack,
                  //       ),
                ],
              ),
            ),
          )),
    )
        .values
        .toList();
  }

  void _changeLan(String language, BuildContext ctx) async {
    Locale _locale = await setLocale(language);

    MyApp.setLocale(ctx, _locale);
  }
  
  @override
  Widget build(BuildContext context) {
    languageList = [
      getTranslated(context, 'ENGLISH_LAN'),
      // getTranslated(context, 'HINDI_LAN'),
      // getTranslated(context, 'CHINESE_LAN'),
      // getTranslated(context, 'SPANISH_LAN'),
      getTranslated(context, 'HEBREW_LBL'),
      getTranslated(context, 'ARABIC_LAN'),
      // getTranslated(context, 'RUSSIAN_LAN'),
      // getTranslated(context, 'JAPANISE_LAN'),
      // getTranslated(context, 'GERMAN_LAN')
    ];
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => IntroSlider()));
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 45,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colors.primary
            ),
            child: Text("${getTranslated(context, 'submit')}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
            child: Column(
              children: [
                Text("${getTranslated(context, 'CHOOSE_LANGUAGE_LBL')}",style: TextStyle(color: Theme.of(context).colorScheme.black,fontSize: 18,fontWeight: FontWeight.w600),),
                SizedBox(height: 10,),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: getLngList(context),
                  ),
                )

                // ListTile(
                //   title: Text('English'),
                //   leading: Radio(
                //     value: 'English',
                //     groupValue: languageSelected,
                //     onChanged: (String? value) {
                //       setState(() {
                //         languageSelected = value;
                //       });
                //     },
                //   ),
                // ),
                // ListTile(
                //   title: const Text('Arabic'),
                //   leading: Radio(
                //     value: 'Arabic',
                //     groupValue: languageSelected,
                //     onChanged: (String? value) {
                //       setState(() {
                //         languageSelected = value;
                //       });
                //     },
                //   ),
                // ),
                //
                // ListTile(
                //   title: const Text('Hebrew'),
                //   leading: Radio(
                //     value: 'Hebrew',
                //     groupValue: languageSelected,
                //     onChanged: (String? value) {
                //       setState(() {
                //         languageSelected = value;
                //       });
                //     },
                //   ),
                // ),
              
              ],
            ),
        ),
      ),
    );
  }
}
