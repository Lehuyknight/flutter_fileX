import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:disk_space/disk_space.dart';
import 'package:flutter_filex/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:isolate_handler/isolate_handler.dart';
import 'package:path_provider/path_provider.dart';

class CoreProvider extends ChangeNotifier {
  List<FileSystemEntity> availableStorage = <FileSystemEntity>[];
  List<FileSystemEntity> recentFiles = <FileSystemEntity>[];
  final isolates = IsolateHandler();
  double totalSpace = 0;
  double freeSpace = 0;
  int totalSDSpace = 0;
  int freeSDSpace = 0;
  double usedSpace = 0;
  int usedSDSpace = 0;
  bool storageLoading = true;
  bool recentLoading = true;

  checkSpace() async {
    setRecentLoading(true);
    setStorageLoading(true);
    recentFiles.clear();
    availableStorage.clear();
    List<Directory> dirList = (await getExternalStorageDirectories())!;
    availableStorage.addAll(dirList);
    notifyListeners();
    var free = await DiskSpace.getFreeDiskSpace;
    var total = await DiskSpace.getTotalDiskSpace;
    setFreeSpace(free);
    setTotalSpace(total);
    setUsedSpace(total! - free!);
    // if (dirList.length > 1) {
    //   var freeSD = await platform.invokeMethod('getExternalStorageFreeSpace');
    //   var totalSD = await platform.invokeMethod('getExternalStorageTotalSpace');
    //   setFreeSDSpace(freeSD);
    //   setTotalSDSpace(totalSD);
    //   setUsedSDSpace(totalSD - freeSD);
    // }
    setStorageLoading(false);
    // getRecentFiles();
  }

  /// I had to use a combination of [isolate_handler] plugin and
  /// [IsolateNameServer] because compute doesnt work as my function uses
  /// an external plugin and also [isolate_handler] plugin doesnt allow me
  /// to pass complex data (in this case List<FileSystemEntity>). so basically
  /// i used the [isolate_handler] to do get the file and use [IsolateNameServer]
  /// to send it back to the main Thread
  getRecentFiles() async {
    print('this is running');
    String isolateName = 'recent';
    isolates.spawn<String>(
      getFilesWithIsolate,
      name: isolateName,
      onReceive: (val) {
        isolates.kill(isolateName);
      },
      onInitialized: () => isolates.send('', to: isolateName),
    );
    ReceivePort port = ReceivePort();
    IsolateNameServer.registerPortWithName(port.sendPort, '${isolateName}_2');
    port.listen((message) {
      recentFiles.addAll(message);
      setRecentLoading(false);
      port.close();
      IsolateNameServer.removePortNameMapping('${isolateName}_2');
    });
  }

  static getFilesWithIsolate(Map<String, dynamic> context) async {
    String isolateName = context['name'];
    List<FileSystemEntity> l =
        await FileUtils.getRecentFiles(showHidden: false);
    final messenger = HandledIsolate.initialize(context);
    final SendPort? send =
        IsolateNameServer.lookupPortByName('${isolateName}_2');
    send!.send(l);
    messenger.send('done');
  }

  void setFreeSpace(value) {
    freeSpace = value * 1000000;
    notifyListeners();
  }

  void setTotalSpace(value) {
    totalSpace = value * 1000000;
    notifyListeners();
  }

  void setUsedSpace(value) {
    usedSpace = value * 1000000;
    notifyListeners();
  }

  void setFreeSDSpace(value) {
    freeSDSpace = value;
    notifyListeners();
  }

  void setTotalSDSpace(value) {
    totalSDSpace = value;
    notifyListeners();
  }

  void setUsedSDSpace(value) {
    usedSDSpace = value;
    notifyListeners();
  }

  void setStorageLoading(value) {
    storageLoading = value;
    notifyListeners();
  }

  void setRecentLoading(value) {
    recentLoading = value;
    notifyListeners();
  }
}
