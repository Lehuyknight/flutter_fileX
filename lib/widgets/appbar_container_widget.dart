import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../utils/colors_const.dart';
import '../utils/dimension_const.dart';
import '../utils/textstyle_ext.dart';

class AppbarContainerWidget extends StatelessWidget {
  const AppbarContainerWidget({
    super.key,
    required this.child,
    this.title,
    this.implementLeading = false,
    this.implementTraling = false,
    this.bottomText = false,
    this.titleString,
    this.subTitleString,
    this.paddingContent =
        const EdgeInsets.symmetric(horizontal: kMediumPadding),
  });

  final Widget child;
  final Widget? title;
  final bool implementLeading;
  final String? titleString;
  final String? subTitleString;
  final EdgeInsets? paddingContent;
  final bool implementTraling;
  final bool bottomText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 186,
            child: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              elevation: 0,
              toolbarHeight: 180,
              backgroundColor: ColorPalette.backgroundScaffoldColor,
              title: title ??
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (implementLeading)
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(kDefaultPadding),
                                ),
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.all(kItemPadding),
                              child: const Icon(
                                FontAwesomeIcons.arrowLeft,
                                color: Colors.black,
                                size: kDefaultPadding,
                              ),
                            ),
                          ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (bottomText && subTitleString != null)
                                const SizedBox(
                                  height: kMediumPadding,
                                ),
                              Text(
                                titleString ?? '',
                                style: TextStyles.defaultStyle.fontHeader.bold
                                    .whiteTextColor,
                              ),
                              if (subTitleString != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: kMediumPadding),
                                  child: Text(
                                    subTitleString!,
                                    style: TextStyles.defaultStyle.fontCaption
                                        .whiteTextColor,
                                  ),
                                )
                            ],
                          ),
                        ),
                        if (implementTraling)
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(kDefaultPadding),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(kItemPadding),
                            child: const Icon(
                              FontAwesomeIcons.bars,
                              size: kDefaultPadding,
                              color: Colors.black,
                            ),
                          )
                      ]),
              flexibleSpace: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        gradient: Gradients.defaultGradientBackground,
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(35))),
                  ),
                  const Positioned(
                    top: 0,
                    left: 0,
                    // child: ImageHelper.loadFromAsset(
                    //   AssetsHelper.ovalAppbar,
                    // ),
                    child: Text(''),
                  ),
                  const Positioned(
                    bottom: 0,
                    right: 0,
                    // child: ImageHelper.loadFromAsset(
                    //   AssetsHelper.ovalAppbar2,
                    // ),
                    child: Text(''),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 156),
            padding: paddingContent,
            child: child,
          )
        ],
      ),
    );
  }
}
