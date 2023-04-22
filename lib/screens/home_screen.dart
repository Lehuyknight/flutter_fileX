import 'package:flutter_filex/screens/browse/browse.dart';
import 'package:flutter_filex/todo/Home_Page/to_do_home_screen.dart';
import 'package:flutter_filex/utils/navigate.dart';
import 'package:flutter_filex/widgets/app_carousel.dart';
import 'package:flutter/material.dart';

class GalleryModel {
  String? title;
  String? description;
  String? assetPath;
  GalleryModel({this.title, this.description, this.assetPath});
}

class HomeScreen extends StatelessWidget {
  List<GalleryModel>? galleryItemList = [
    GalleryModel(
        title: 'Dễ dàng quản lí tài chính', assetPath: 'assets/images/IA1.jpg'),
    GalleryModel(
        title: 'Đặt lịch hẹn, nhắc nhở công việc',
        assetPath: 'assets/images/IA1.jpg'),
    GalleryModel(
        title: 'Quản lí và bảo vệ tài liệu quan trọng',
        assetPath: 'assets/images/IA1.jpg'),
  ];

  HomeScreen({super.key});
  _buildCarousels(List<GalleryModel>? galleryItemList, BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    List<GestureDetector> tapItemsList = [];
    for (int i = 0; i < galleryItemList!.length; i++) {
      var tapItem = GestureDetector(
        onTap: () {
          // open detail
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                color: Colors.green,
              ),
              Center(
                child: Image.asset(galleryItemList[i].assetPath!,
                    width: double.infinity, fit: BoxFit.cover),
              ),
              Center(
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    galleryItemList[i].title!,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      // insert tap item to tap items list,
      tapItemsList.add(tapItem);
    }

    // build a item carousel
    Widget itemCarousel = SizedBox(
      height: (height / 3.5),
      child: Carousel(
          boxFit: BoxFit.cover,
          images: tapItemsList,
          autoplay: false,
          animationCurve: Curves.easeIn,
          animationDuration: const Duration(milliseconds: 2000),
          dotSize: 2.0,
          moveIndicatorFromBottom: 20.0,
          dotPosition: DotPosition.bottomRight,
          dotColor: Colors.blue,
          dotIncreasedColor: Colors.blue,
          dotIncreaseSize: 1.0,
          dotBgColor: Colors.transparent),
    );
    // RETURN
    return itemCarousel;
  }

  _buildItemManagement(BuildContext context, Widget toPage, String assetPath,
      String title, Color color,
      [Function()? customOnTap]) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        color: color,
        elevation: 12.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: customOnTap ??
              () {
                // go to detail management
                Navigate.pushPage(context, toPage);
              },
          child: Ink(
            child: AspectRatio(
              aspectRatio: 2 / 2,
              child: Container(
                child: Column(children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(assetPath, fit: BoxFit.fitHeight),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        title.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  )
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildMiddleBody(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Expanded(
            flex: 1,
            child: _buildItemManagement(
              context,
              const Browse(),
              'assets/icons/ic_manage_file.png',
              'Dữ liệu',
              const Color(0xFFFD9518),
              // () async {
              //   await LaunchApp.openApp(
              //     androidPackageName: 'com.mi.android.globalFileexplorer',
              //   );
              // },
            ),
          ),
          Expanded(
            flex: 1,
            child: _buildItemManagement(
                context,
                ToDoHomeScreen(),
                'assets/icons/ic_manage_task.png',
                'Công việc',
                const Color(0xFF0BAE07)),
          ),
        ]),
        Row(children: [
          Expanded(
            flex: 1,
            child: _buildItemManagement(
                context,
                const Browse(),
                'assets/icons/ic_manage_file.png',
                'Tài chính',
                const Color(0xFFF21C1C)),
          ),
          Expanded(
            flex: 1,
            child: _buildItemManagement(
                context,
                const Browse(),
                'assets/icons/ic_manage_mission.png',
                'Nhiệm vụ',
                const Color(0xFF0063F8)),
          ),
        ]),
      ],
    );
  }

  _buildUserInfo() {
    return Column(
      children: [
        Row(children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Xin chào bạn,',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24)),
          )
        ]),
      ],
    );
  }

  _buildBody(BuildContext context) {
    return ListView(
      children: [
        _buildUserInfo(),
        _buildCarousels(galleryItemList, context),
        _buildMiddleBody(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }
}
