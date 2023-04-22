import 'package:flutter_filex/providers/providers.dart';
import 'package:flutter_filex/utils/utils.dart';
import 'package:flutter_filex/widgets/custom_divider.dart';
import 'package:flutter_filex/widgets/file_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class Bluetooth extends StatefulWidget {
  const Bluetooth({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _BluetoothState createState() => _BluetoothState();
}

class _BluetoothState extends State<Bluetooth> {
  @override
  void initState() {
    super.initState();
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<CategoryProvider>(context, listen: false).getDownloads();
    // });
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false).getBlueTooth();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder:
          (BuildContext context, CategoryProvider provider, Widget? child) {
        return DefaultTabController(
          length: provider.downloadTabs.length,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                widget.title,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: const Color(0xFFFD9518),
              leading: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
              ),
              // bottom: TabBar(
              //   indicatorColor: Theme.of(context).colorScheme.secondary,
              //   labelColor: Theme.of(context).colorScheme.secondary,
              //   unselectedLabelColor:
              //       Theme.of(context).textTheme.bodySmall!.color,
              //   isScrollable: false,
              //   tabs: Constants.map<Widget>(
              //     provider.downloadTabs,
              //     (index, label) {
              //       return Tab(text: '$label');
              //     },
              //   ),
              // ),
            ),
            body: Visibility(
              visible: provider.downloads.isNotEmpty,
              replacement: const Center(child: Text('No Files Found')),
              child: TabBarView(
                children: Constants.map<Widget>(
                  provider.downloadTabs,
                  (index, label) {
                    return ListView.separated(
                      padding: const EdgeInsets.only(left: 20),
                      itemCount: provider.downloads.length,
                      itemBuilder: (BuildContext context, int index) {
                        return FileItem(file: provider.downloads[index]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return CustomDivider();
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
