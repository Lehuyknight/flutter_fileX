import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_filex/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:isolate_handler/isolate_handler.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryProvider extends ChangeNotifier {
  CategoryProvider() {
    getHidden();
    getSort();
  }

  static List docExtensions = [
    '.pdf',
    '.epub',
    '.mobi',
    '.doc',
  ];

  List<FileSystemEntity> audio = <FileSystemEntity>[];
  List<String> audioTabs = <String>[];
  List<FileSystemEntity> currentFiles = [];
  List<String> downloadTabs = <String>[];
  List<FileSystemEntity> downloads = <FileSystemEntity>[];
  List<String> imageTabs = <String>[];
  List<FileSystemEntity> images = <FileSystemEntity>[];
  final isolates = IsolateHandler();
  bool loading = false;
  bool showHidden = false;
  int sort = 0;
  List<FileSystemEntity> video = <FileSystemEntity>[];
  List<String> videoTabs = <String>[];

  getDownloads() async {
    setLoading(true);
    downloadTabs.clear();
    downloads.clear();
    downloadTabs.add('All');
    List<Directory> storages = await FileUtils.getStorageList();
    storages.forEach((dir) {
      if (Directory(dir.path + 'Download').existsSync()) {
        List<FileSystemEntity> files =
            Directory(dir.path + 'Download').listSync();
        //  print(files);
        files.forEach((file) {
          if (FileSystemEntity.isFileSync(file.path)) {
            downloads.add(file);
            downloadTabs
                .add(file.path.split('/')[file.path.split('/').length - 2]);
            downloadTabs = downloadTabs.toSet().toList();
            notifyListeners();
          }
        });
      }
    });
    setLoading(false);
  }

  getBlueTooth() async {
    setLoading(true);
    downloadTabs.clear();
    downloads.clear();
    downloadTabs.add('All');
    List<Directory> storages = await FileUtils.getStorageList();
    storages.forEach((dir) {
      if (Directory(dir.path + 'bluetooth').existsSync()) {
        List<FileSystemEntity> files =
            Directory(dir.path + 'bluetooth').listSync();
        //  print(files);
        files.forEach((file) {
          if (FileSystemEntity.isFileSync(file.path)) {
            downloads.add(file);
            downloadTabs
                .add(file.path.split('/')[file.path.split('/').length - 2]);
            downloadTabs = downloadTabs.toSet().toList();
            notifyListeners();
          }
        });
      }
    });
    setLoading(false);
  }

  getAudioCustomFromGetDownloads(String type) async {
    setLoading(true);
    imageTabs.clear();
    images.clear();
    List<Directory> storages = await FileUtils.getStorageList();
    storages.forEach((dir) {
      if (Directory(dir.path + 'Download').existsSync()) {
        List<FileSystemEntity> files =
            Directory(dir.path + 'Download').listSync();
        //  print(files);
        files.forEach((file) {
          String mimeType = mime(file.path) ?? '';
          if (FileSystemEntity.isFileSync(file.path) &&
              mimeType.split('/')[0] == type) {
            images.add(file);
            imageTabs
                .add(file.path.split('/')[file.path.split('/').length - 2]);
            imageTabs = imageTabs.toSet().toList();
            notifyListeners();
          }
        });
      }
    });
    setLoading(false);
  }

  getCompressedCustomFromGetDownloads(String type) async {
    setLoading(true);
    imageTabs.clear();
    images.clear();
    List<Directory> storages = await FileUtils.getStorageList();
    storages.forEach((dir) {
      if (Directory(dir.path + 'Download').existsSync()) {
        List<FileSystemEntity> files =
            Directory(dir.path + 'Download').listSync();
        //  print(files);
        files.forEach((file) {
          String mimeType = mimeCompressed(file.path) ?? '';
          if (FileSystemEntity.isFileSync(file.path) &&
              mimeType.split('/')[0] == type) {
            images.add(file);
            imageTabs
                .add(file.path.split('/')[file.path.split('/').length - 2]);
            imageTabs = imageTabs.toSet().toList();
            notifyListeners();
          }
        });
      }
    });
    setLoading(false);
  }

  getDocumentCustomFromGetDownloads() async {
    setLoading(true);
    imageTabs.clear();
    images.clear();
    List<Directory> storages = await FileUtils.getStorageList();
    storages.forEach((dir) {
      if (Directory(dir.path + 'Download').existsSync()) {
        List<FileSystemEntity> files =
            Directory(dir.path + 'Download').listSync();
        //  print(files);
        files.forEach((file) {
          String mimeType = mimeDocumented(file.path) ?? '';
          if (mimeType.split('/')[0] == 'application') {
            print('why');
            images.add(file);
            imageTabs
                .add(file.path.split('/')[file.path.split('/').length - 2]);
            imageTabs = imageTabs.toSet().toList();
            notifyListeners();
          }
        });
      }
    });
    setLoading(false);
  }

  getImagesCustomFromGetDownloads(String type) async {
    setLoading(true);
    imageTabs.clear();
    images.clear();
    List<Directory> storages = await FileUtils.getStorageList();
    storages.forEach((dir) {
      if (Directory(dir.path + 'DCIM/Camera').existsSync()) {
        List<FileSystemEntity> files =
            Directory(dir.path + 'DCIM/Camera').listSync();
        //  print(files);
        files.forEach((file) {
          String mimeType = mime(file.path) ?? '';
          if (FileSystemEntity.isFileSync(file.path) &&
              mimeType.split('/')[0] == type) {
            images.add(file);
            imageTabs
                .add(file.path.split('/')[file.path.split('/').length - 2]);
            imageTabs = imageTabs.toSet().toList();
            notifyListeners();
          }
        });
      }
    });
    setLoading(false);
    print('this function was called');
  }

  getImages(String type) async {
    setLoading(true);
    imageTabs.clear();
    images.clear();
    imageTabs.add('All');
    String isolateName = type;
    isolates.spawn<String>(
      getAllFilesWithIsolate,
      name: isolateName,
      onReceive: (val) {
        isolates.kill(isolateName);
      },
      onInitialized: () => isolates.send('hey', to: isolateName),
    );
    ReceivePort _port = ReceivePort();

    IsolateNameServer.registerPortWithName(_port.sendPort, '${isolateName}_2');
    _port.listen((files) {
      print('RECEIVED SERVER PORT');

      files.forEach((file) {
        String mimeType = mime(file.path) ?? '';
        if (mimeType.split('/')[0] == type) {
          images.add(file);
          imageTabs
              .add('${file.path.split('/')[file.path.split('/').length - 2]}');
          imageTabs = imageTabs.toSet().toList();
        }
        notifyListeners();
      });
      currentFiles = images;
      setLoading(false);
      _port.close();
      IsolateNameServer.removePortNameMapping('${isolateName}_2');
    });
  }

  static getAllFilesWithIsolate(Map<String, dynamic> context) async {
    print(context);
    String isolateName = context['name'];
    print('Get files');
    List<FileSystemEntity> files =
        await FileUtils.getAllFiles(showHidden: false);
    print('Files $files');
    final messenger = HandledIsolate.initialize(context);
    try {
      final SendPort? send =
          IsolateNameServer.lookupPortByName('${isolateName}_2');
      send!.send(files);
    } catch (e) {
      print(e);
    }
    messenger.send('done');
  }

  getAudios(String type) async {
    setLoading(true);
    audioTabs.clear();
    audio.clear();
    audioTabs.add('All');
    String isolateName = type;
    isolates.spawn<String>(
      getAllFilesWithIsolate,
      name: isolateName,
      onReceive: (val) {
        print(val);
        isolates.kill(isolateName);
      },
      onInitialized: () => isolates.send('hey', to: isolateName),
    );
    ReceivePort _port = ReceivePort();
    IsolateNameServer.registerPortWithName(_port.sendPort, '${isolateName}_2');
    _port.listen((files) async {
      print('RECEIVED SERVER PORT');
      print(files);
      List tabs = await compute(separateAudios, {'files': files, 'type': type});
      audio = tabs[0];
      audioTabs = tabs[1];
      setLoading(false);
      _port.close();
      IsolateNameServer.removePortNameMapping('${isolateName}_2');
    });
  }

  switchCurrentFiles(List list, String label) async {
    List<FileSystemEntity> l = await compute(getTabImages, [list, label]);
    currentFiles = l;
    notifyListeners();
  }

  static Future<List<FileSystemEntity>> getTabImages(List item) async {
    List items = item[0];
    String label = item[1];
    List<FileSystemEntity> files = [];
    items.forEach((file) {
      if ('${file.path.split('/')[file.path.split('/').length - 2]}' == label) {
        files.add(file);
      }
    });
    return files;
  }

  static Future<List> separateAudios(Map body) async {
    List files = body['files'];
    String type = body['type'];
    List<FileSystemEntity> audio = [];
    List<String> audioTabs = [];
    for (File file in files) {
      String mimeType = mime(file.path) ?? '';
      print(extension(file.path));
      if (type == 'text' && docExtensions.contains(extension(file.path))) {
        audio.add(file);
      }
      if (mimeType.isNotEmpty) {
        if (mimeType.split('/')[0] == type) {
          audio.add(file);
          audioTabs
              .add('${file.path.split('/')[file.path.split('/').length - 2]}');
          audioTabs = audioTabs.toSet().toList();
        }
      }
    }
    return [audio, audioTabs];
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  setHidden(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hidden', value);
    showHidden = value;
    notifyListeners();
  }

  getHidden() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool h = prefs.getBool('hidden') ?? false;
    setHidden(h);
  }

  Future setSort(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('sort', value);
    sort = value;
    notifyListeners();
  }

  getSort() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int h = prefs.getInt('sort') ?? 0;
    setSort(h);
  }
}
