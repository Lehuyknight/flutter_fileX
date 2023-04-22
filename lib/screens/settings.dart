import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_filex/providers/providers.dart';
import 'package:flutter_filex/screens/about.dart';
import 'package:flutter_filex/utils/utils.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
    check();
  }

  int sdkVersion = 0;

  check() async {
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      sdkVersion = androidInfo.version.sdkInt;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          SwitchListTile.adaptive(
            contentPadding: const EdgeInsets.all(0),
            secondary: const Icon(
              Feather.eye_off,
            ),
            title: const Text(
              'Hiện file ẩn',
            ),
            value: Provider.of<CategoryProvider>(context).showHidden,
            onChanged: (value) {
              Provider.of<CategoryProvider>(context, listen: false)
                  .setHidden(value);
            },
            activeColor: Theme.of(context).colorScheme.secondary,
          ),
          Container(
            height: 1,
            color: Theme.of(context).dividerColor,
          ),
          MediaQuery.of(context).platformBrightness !=
                  ThemeConfig.darkTheme.brightness
              ? SwitchListTile.adaptive(
                  contentPadding: const EdgeInsets.all(0),
                  secondary: const Icon(
                    Feather.moon,
                  ),
                  title: const Text('Chế độ nền tối'),
                  value: Provider.of<AppProvider>(context).theme ==
                          ThemeConfig.lightTheme
                      ? false
                      : true,
                  onChanged: (v) {
                    if (v) {
                      Provider.of<AppProvider>(context, listen: false)
                          .setTheme(ThemeConfig.darkTheme, 'dark');
                    } else {
                      Provider.of<AppProvider>(context, listen: false)
                          .setTheme(ThemeConfig.lightTheme, 'light');
                    }
                  },
                  activeColor: Theme.of(context).colorScheme.secondary,
                )
              : const SizedBox(),
          MediaQuery.of(context).platformBrightness !=
                  ThemeConfig.darkTheme.brightness
              ? Container(
                  height: 1,
                  color: Theme.of(context).dividerColor,
                )
              : const SizedBox(),
          // ListTile(
          //   contentPadding: EdgeInsets.all(0),
          //   onTap: () => showLicensePage(context: context),
          //   leading: Icon(Feather.file_text),
          //   title: Text('Open source licences'),
          // ),
          Container(
            height: 1,
            color: Theme.of(context).dividerColor,
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            onTap: () => Navigate.pushPage(context, About()),
            leading: const Icon(Feather.info),
            title: const Text('Về chúng tôi'),
          ),
          Container(
            height: 1,
            color: Theme.of(context).dividerColor,
          ),
        ],
      ),
    );
  }
}
