import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'SmartkitScreen/Screen/Intro.dart';
import 'SmartkitScreen/Screen/SmartKitHome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    FirebaseApp app = await Firebase.initializeApp();
  MobileAds.instance.initialize();
  assert(app != null);
  print("...................");
  Stripe.publishableKey = "pk_test_sREVqI5A1IYzKIKQWFuHRSy600Yyf3wWwf";
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();

  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SmartKit',
      theme: ThemeData(
        primaryColor: Colors.black,
        // accentIconTheme: IconThemeData(color: createMaterialColor(smarKitcolor1)),
        visualDensity: VisualDensity.adaptivePlatformDensity, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
      ),
      home: ScreenTypeLayout(
        mobile: IntroSlider(),
        tablet: MyHomePage(),
        desktop: MyHomePage(),
      ),
    );
  }
}
