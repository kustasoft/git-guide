import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smartkit/FullApp/NewsApp/desktop/helper/ButtonClickAnimation.dart';
import 'package:smartkit/FullApp/NewsApp/desktop/helper/ColorsRes.dart';
import 'package:smartkit/FullApp/NewsApp/desktop/helper/DesignConfig.dart';
import 'package:smartkit/FullApp/NewsApp/desktop/helper/StringsRes.dart';

class FeedbackPageDesktop extends StatefulWidget {
  @override
  _FeedbackPageStateDesktop createState() => _FeedbackPageStateDesktop();
}

class _FeedbackPageStateDesktop extends State<FeedbackPageDesktop> {
  TextEditingController edtfeedback = new TextEditingController();
  bool issubmit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesignConfig.setAppbar(StringsRes.feedback) as PreferredSizeWidget?,
      /*bottomNavigationBar: issubmit
          ? null
          : IntrinsicHeight(
              child: ButtonClickAnimation(
              onTap: () {
                setState(() {
                  issubmit = true;
                });
              },
              child: Container(width: 100,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 15),
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: DesignConfig.boxDecorationContainerColor(ColorsRes.blue, 10),
                child: Text(
                  StringsRes.submit,
                  style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color: ColorsRes.white, fontWeight: FontWeight.bold)),
                ),
              ),
            )),*/
      body: Center(
        child: SizedBox(
          height: 700,
          width: 700,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              CachedNetworkImage(
                imageUrl: "https://smartkit.wrteam.in/smartkit/newsapp/feedback.png",
                height: MediaQuery.of(context).size.width / 7,
                width: MediaQuery.of(context).size.width / 7,
              ),
              issubmit
                  ? Container(
                      margin: EdgeInsets.only(top: 40, bottom: 5),
                      child: Text(
                        StringsRes.feedbacksubmitmsg,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    )
                  : Container(
                      decoration: DesignConfig.boxDecorationContainerColor(ColorsRes.appcolor.withOpacity(0.1), 15),
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(top: 20, bottom: 5),
                      child: TextFormField(
                        style: TextStyle(color: ColorsRes.black),
                        cursorColor: ColorsRes.black,
                        decoration: InputDecoration(
                          hintText: StringsRes.enterfeedback,
                          hintStyle: Theme.of(context).textTheme.subtitle2!.merge(TextStyle(color: ColorsRes.grey)),
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        minLines: 13,
                        controller: edtfeedback,
                      ),
                    ),
            ]),
          ),
        ),
      ),
    );
  }
}
