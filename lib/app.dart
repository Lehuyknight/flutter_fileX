import 'dart:io';

import 'package:flutter_filex/providers/providers.dart';
import 'package:flutter_filex/screens/ios_error.dart';
import 'package:flutter_filex/screens/splash.dart';
import 'package:flutter_filex/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (BuildContext context, appProvider, Widget? child) {
        return GetMaterialApp(
          key: appProvider.key,
          debugShowCheckedModeBanner: false,
          navigatorKey: appProvider.navigatorKey,
          title: AppStrings.appName,
          theme: appProvider.theme,
          darkTheme: ThemeConfig.darkTheme,
          home: Platform.isIOS ? IosError() : Splash(),
        );
      },
    );
  }
}
