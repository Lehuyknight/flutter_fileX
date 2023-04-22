import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Constants {
  static List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  static List categories = [
    {
      'title': 'Hình ảnh',
      'icon': Feather.image,
      'path': '',
      'color': Colors.blue,
      'asset': 'ic_image.png'
    },
    {
      'title': 'Videos',
      'icon': Feather.video,
      'path': '',
      'color': Colors.red,
      'asset': 'ic_video.png'
    },
    {
      'title': 'Nhạc',
      'icon': Feather.headphones,
      'path': '',
      'color': Colors.teal,
      'asset': 'ic_audio.png'
    },
    {
      'title': 'Tải xuống',
      'icon': Feather.download,
      'path': '',
      'color': Colors.purple,
      'asset': 'ic_download.png'
    },
    {
      'title': 'Tệp nén',
      'icon': Feather.download,
      'path': '',
      'color': Colors.purple,
      'asset': 'ic_zip.png'
    },
    {
      'title': 'Tài liệu',
      'icon': Feather.file,
      'path': '',
      'color': Colors.pink,
      'asset': 'ic_file.png'
    },
    {
      'title': 'Ứng dụng',
      'icon': Icons.android,
      'path': '',
      'color': Colors.green,
      'asset': 'ic_apk.png'
    },
    {
      'title': 'Bluetooth',
      'icon': Icons.android,
      'path': '',
      'color': Colors.green,
      'asset': 'ic_bluetooth.png'
    },
    // {
    //   'title': 'Whatsapp Statuses',
    //   'icon': FontAwesome.whatsapp,
    //   'path': '',
    //   'color': Colors.green,
    //   'asset': 'ic_zip.png'
    // },
  ];

  static List sortList = [
    'File name (A to Z)',
    'File name (Z to A)',
    'Date (oldest first)',
    'Date (newest first)',
    'Size (largest first)',
    'Size (Smallest first)',
  ];
}
