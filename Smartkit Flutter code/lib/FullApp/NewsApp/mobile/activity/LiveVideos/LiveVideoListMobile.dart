import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartkit/FullApp/NewsApp/mobile/helper/ButtonClickAnimation.dart';
import 'package:smartkit/FullApp/NewsApp/mobile/helper/ColorsRes.dart';
import 'package:smartkit/FullApp/NewsApp/mobile/helper/DesignConfig.dart';
import 'package:smartkit/FullApp/NewsApp/mobile/helper/StringsRes.dart';
import 'package:smartkit/FullApp/NewsApp/mobile/helper/VideoView/overlay_service.dart';
import 'package:smartkit/FullApp/NewsApp/mobile/activity/LiveVideos/LiveVideoDetailMobile.dart';
import 'package:smartkit/FullApp/NewsApp/mobile/activity/NotificationListMobile.dart';
import 'package:smartkit/FullApp/NewsApp/mobile/activity/Profile/NewArticleMobile.dart';
import 'package:smartkit/FullApp/NewsApp/model/LiveVideo.dart';

late LiveVideo selectedlivevideo;

class LiveVideoListMobile extends StatefulWidget {
  @override
  _LiveVideoListStateMobile createState() => _LiveVideoListStateMobile();
}

class _LiveVideoListStateMobile extends State<LiveVideoListMobile> {
  late List<LiveVideo> livevideolist;
  @override
  void initState() {
    super.initState();
    // livevideolist = new List<LiveVideo>();
    livevideolist = [];
    setVideoList();
  }

  setVideoList() {
    livevideolist.add(new LiveVideo(
        id: 1,
        description: "Hurricane Hanna battered southern Texas with sustained winds of 75 mph and continued to deliver heavy rain and flash flooding as it moved inland late Saturday.",
        title: "Live Video",
        link: "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4",
        image: "https://a4.espncdn.com/combiner/i?img=%2Fphoto%2F2020%2F0111%2Fr651071_1296x729_16%2D9.jpg"));
    livevideolist.add(new LiveVideo(
        id: 2,
        title: "Live Video",
        description: "Hurricane Hanna battered southern Texas with sustained winds of 75 mph and continued to deliver heavy rain and flash flooding as it moved inland late Saturday.",
        link: "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4",
        image: "https://a4.espncdn.com/combiner/i?img=%2Fphoto%2F2020%2F0111%2Fr651071_1296x729_16%2D9.jpg"));

    livevideolist.add(new LiveVideo(
        id: 3,
        title: "Live Video",
        description: "Hurricane Hanna battered southern Texas with sustained winds of 75 mph and continued to deliver heavy rain and flash flooding as it moved inland late Saturday.",
        link: "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4",
        image: "https://a4.espncdn.com/combiner/i?img=%2Fphoto%2F2020%2F0111%2Fr651071_1296x729_16%2D9.jpg"));
    livevideolist.add(new LiveVideo(
        id: 4,
        title: "Live Video",
        description: "Hurricane Hanna battered southern Texas with sustained winds of 75 mph and continued to deliver heavy rain and flash flooding as it moved inland late Saturday.",
        link: "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4",
        image: "https://a4.espncdn.com/combiner/i?img=%2Fphoto%2F2020%2F0111%2Fr651071_1296x729_16%2D9.jpg"));
    livevideolist.add(new LiveVideo(
        id: 5,
        title: "Live Video",
        description: "Hurricane Hanna battered southern Texas with sustained winds of 75 mph and continued to deliver heavy rain and flash flooding as it moved inland late Saturday.",
        link: "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4",
        image: "https://a4.espncdn.com/combiner/i?img=%2Fphoto%2F2020%2F0111%2Fr651071_1296x729_16%2D9.jpg"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        iconTheme: IconThemeData(
          color: ColorsRes.white,
        ),
        elevation: 3,
        backgroundColor: ColorsRes.appcolor,
        centerTitle: true,
        title: Text(StringsRes.live, style: TextStyle(color: ColorsRes.white, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.add_box_outlined),
          onPressed: () {
            Navigator.of(context).push(CupertinoPageRoute(builder: (context) => NewArticleMobile()));
          },
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.notifications_none_outlined, color: ColorsRes.white),
              onPressed: () {
                Navigator.of(context).push(CupertinoPageRoute(builder: (context) => NotificationListMobile()));
              }),
        ],
      ),
      body: videoListWidget(),
    );
  }

  Widget videoListWidget() {
    return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        itemCount: livevideolist.length,
        separatorBuilder: (context, index) => SizedBox(
              height: 15,
            ),
        itemBuilder: (context, index) {
          LiveVideo video = livevideolist[index];
          return ButtonClickAnimation(
            onTap: () {
              selectedlivevideo = video;

              OverlayService().addVideosOverlay(context, LiveVideoDetailMobile());
            },
            child: Card(
              shape: DesignConfig.setRoundedBorder(ColorsRes.white, 10, false),
              child: Column(children: [
                Card(
                  margin: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  )),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: CachedNetworkImage(
                      imageUrl: video.image!,
                      height: 200,
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => CachedNetworkImage(imageUrl: "https://smartkit.wrteam.in/smartkit/newsapp/placeholder.png"),
                      errorWidget: (context, url, error) => CachedNetworkImage(imageUrl: "https://smartkit.wrteam.in/smartkit/images/placeholder.png")),
                ),
                SizedBox(height: 12),
                Row(children: [
                  SizedBox(width: 10),
                  Icon(
                    Icons.brightness_1,
                    color: ColorsRes.red,
                    size: 15,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(child: Text(video.title!)),
                  Icon(
                    Icons.share,
                    color: ColorsRes.blue,
                  ),
                  SizedBox(width: 5),
                ]),
                SizedBox(height: 8),
              ]),
            ),
          );
        });
  }
}
