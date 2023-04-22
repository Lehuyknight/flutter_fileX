import 'package:flutter/material.dart';

import '../utils/colors_const.dart';
import '../utils/dimension_const.dart';
import '../utils/textstyle_ext.dart';

class SocialButtonWidget extends StatelessWidget {
  final String title;
  Function()? onTap;
  final Color? color;
  final Widget? logo;
  final Color? textColor;
  SocialButtonWidget(
      {super.key,
      required this.title,
      this.onTap,
      this.color,
      this.logo,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kMediumPadding),
            color: color ?? ColorPalette.primaryColor),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logo ?? const Text(''),
            // const SizedBox(
            //   width: kDefaultPadding,
            // ),
            const SizedBox(
              width: kDefaultPadding,
            ),
            Text(
              title,
              style: TextStyles.defaultStyle.bold
                  .copyWith(color: textColor ?? Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}