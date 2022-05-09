import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartkit/Constant/SmartKitColor.dart';
import 'package:smartkit/FullApp/Vpn/Screens/VpnIntro.dart';
import 'package:smartkit/SmartkitScreen/Screen/SmartKitHome.dart';

class VpnSplash extends StatefulWidget {
  VpnSplash({Key? key}) : super(key: key);

  @override
  _VpnSplashState createState() => _VpnSplashState();
}

class _VpnSplashState extends State<VpnSplash> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
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
        body: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: back(),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/lightvpn.svg',
                      color: Colors.white,
                      fit: BoxFit.cover,
                      width: 150,
                      height: 150,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "LIGHT VPN",
                      style: TextStyle(color: Colors.white, fontFamily: 'open sans', fontWeight: FontWeight.w700, fontSize: 28),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  back() {
    return BoxDecoration(
      gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [vpn22, vpn33], stops: [0, 1]),
    );
  }

  startTime() async {
    var _duration = Duration(milliseconds: 1000);
    return Timer(_duration, navigationPage);
  }

  Future<void> navigationPage() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => VpnIntro(),
      ),
    );
  }
}
