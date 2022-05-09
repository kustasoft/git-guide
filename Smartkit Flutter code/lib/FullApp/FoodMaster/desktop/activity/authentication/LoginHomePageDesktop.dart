import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smartkit/FullApp/FoodMaster/desktop/activity/authentication/SignupActivityDesktop.dart';
import 'package:smartkit/FullApp/FoodMaster/desktop/helper/ColorsRes.dart';
import 'package:smartkit/FullApp/FoodMaster/desktop/helper/Constant.dart';
import 'package:smartkit/FullApp/FoodMaster/desktop/helper/DesignConfig.dart';
import 'package:smartkit/FullApp/FoodMaster/desktop/helper/StringsRes.dart';
import 'package:smartkit/SmartkitScreen/Screen/SmartKitHome.dart';
import '../MainHomePageDesktop.dart';
import 'LoginActivityDesktop.dart';
import 'dart:io';

class LoginHomePageDesktop extends StatefulWidget {
  final String? from;
  const LoginHomePageDesktop({
    Key? key,
    this.from,
  }) : super(key: key);

  @override
  _LoginHomePageStateDesktop createState() => _LoginHomePageStateDesktop();
}

class _LoginHomePageStateDesktop extends State<LoginHomePageDesktop> {
  GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  void initState() {
    super.initState();
    scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(),
          ),
        ).then((value) => value as bool);
      } as Future<bool> Function()?,
      child: Scaffold(
        key: scaffoldKey,
        body: Center(
          child: SizedBox(
            width: 600,
            height: 600,
            child: Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                image: DecorationImage(image: CachedNetworkImageProvider('https://smartkit.wrteam.in/smartkit/foodmaster/background_image.png'), fit: BoxFit.cover),
              ),
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: MediaQuery.of(context).padding.bottom, left: 15, right: 15),
              child: Column(children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      if (widget.from == 'splash' || widget.from == 'intro') {
                        Constant.goToMainPage(widget.from, context);
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                    child: DesignConfig.shadowButton(Colors.white, StringsRes.lblskip, ColorsRes.IconColor, 20, Colors.white),
                  ),
                ),
                SingleChildScrollView(
                    padding: EdgeInsets.only(left: 15, top: 2 * kToolbarHeight),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(
                        StringsRes.welcometitle,
                        style: Theme.of(context).textTheme.headline4!.merge(TextStyle(color: ColorsRes.black, fontWeight: FontWeight.bold)),
                      ),
                      Text(
                        StringsRes.appname,
                        style: Theme.of(context).textTheme.headline4!.merge(TextStyle(color: ColorsRes.IconColor, fontWeight: FontWeight.bold)),
                      ),
                      Text(
                        StringsRes.welcomeinfo,
                        style: Theme.of(context).textTheme.subtitle1!.merge(TextStyle(color: ColorsRes.black.withOpacity(0.6))),
                      ),
                    ])),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(children: [
                      Expanded(
                          child: Divider(
                        color: ColorsRes.white,
                        indent: 15,
                        endIndent: 15,
                      )),
                      Text(
                        StringsRes.signinwith,
                        style: TextStyle(color: ColorsRes.white),
                      ),
                      Expanded(
                          child: Divider(
                        color: ColorsRes.white,
                        indent: 15,
                        endIndent: 15,
                      )),
                    ]),
                    SizedBox(
                      height: 20,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                      Expanded(
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  CupertinoPageRoute(
                                      builder: (context) => MainHomePageDesktop(
                                            from: "pagefrom",
                                          )),
                                  (Route<dynamic> route) => false);
                            },
                            child: CachedNetworkImage(
                              width: width / 2.5,
                              imageUrl: "https://smartkit.wrteam.in/smartkit/foodmaster/button__facebook.png",
                            )),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  CupertinoPageRoute(
                                      builder: (context) => MainHomePageDesktop(
                                            from: "pagefrom",
                                          )),
                                  (Route<dynamic> route) => false);
                            },
                            child: CachedNetworkImage(
                              imageUrl: "https://smartkit.wrteam.in/smartkit/foodmaster/button_google.png",
                              width: width / 2.5,
                            )),
                      ),
                      SizedBox(width: 10),
                      //if (Platform.isIOS)
                      Expanded(
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  CupertinoPageRoute(
                                      builder: (context) => MainHomePageDesktop(
                                            from: "pagefrom",
                                          )),
                                  (Route<dynamic> route) => false);
                            },
                            child: CachedNetworkImage(
                              imageUrl: "https://smartkit.wrteam.in/smartkit/foodmaster/button_apple.png",
                              width: width / 2.5,
                            )),
                      ),
                    ]),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(builder: (context) => SignupActivityDesktop(from: "loginhome")));
                        },
                        child: DesignConfig.shadowButtonFullwidgth(Colors.white.withOpacity(0.1), StringsRes.manuallogin, ColorsRes.white, 28, Colors.white, context),
                      ),
                    ),
                    RichText(
                        text: TextSpan(style: new TextStyle(color: ColorsRes.white), text: StringsRes.alreadyhvac, children: <TextSpan>[
                      TextSpan(
                          text: StringsRes.lblsignin,
                          style: TextStyle(decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(CupertinoPageRoute(builder: (context) => LoginActivityDesktop()));
                            }),
                    ])),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
