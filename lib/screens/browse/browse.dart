import 'dart:io';

import 'package:flutter_filex/providers/providers.dart';
import 'package:flutter_filex/screens/apps_screen.dart';
import 'package:flutter_filex/screens/audio.dart';
import 'package:flutter_filex/screens/bluetooth.dart';
import 'package:flutter_filex/screens/compressed.dart';
import 'package:flutter_filex/screens/downloads.dart';
import 'package:flutter_filex/screens/file.dart';
import 'package:flutter_filex/screens/images.dart';
import 'package:flutter_filex/screens/search.dart';
import 'package:flutter_filex/utils/utils.dart';
import 'package:flutter_filex/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import '../videos.dart';

class Browse extends StatefulWidget {
  const Browse({super.key});

  @override
  State<Browse> createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  refresh(BuildContext context) async {
    await Provider.of<CoreProvider>(context, listen: false).checkSpace();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<CategoryProvider>(context, listen: false).getDownloads();
    // });
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<CoreProvider>(context, listen: false).getRecentFiles();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
        title: Text(
          AppStrings.appName,
          style: const TextStyle(fontSize: 25.0, color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Tìm kiếm',
            onPressed: () {
              showSearch(
                context: context,
                delegate: Search(themeData: Theme.of(context)),
              );
            },
            icon: const Icon(
              Feather.search,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => refresh(context),
        child: ListView(
          padding: const EdgeInsets.only(left: 00.0),
          children: <Widget>[
            const SizedBox(height: 44.0),
            _StorageSection(),
            CustomDivider(),
            const SizedBox(height: 44.0),
            _CategoriesSection(),
            CustomDivider(),
            // const SizedBox(height: kDefaultPadding),
            // const _SectionTitle('File đã tải xuống'),
            // _RecentFiles(),
            // _SectionTitle('Video gần đây'),
            // _RecentFiles(),
            // _SectionTitle('Audio gần đây'),
            // _RecentFiles(),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
      ),
    );
  }
}

class _StorageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CoreProvider>(
      builder: (BuildContext context, coreProvider, Widget? child) {
        if (coreProvider.storageLoading) {
          return SizedBox(height: 100, child: CustomLoader());
        }
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: coreProvider.availableStorage.length,
          itemBuilder: (BuildContext context, int index) {
            FileSystemEntity item = coreProvider.availableStorage[index];

            String path = item.path.split('Android')[0];
            double percent = 0;

            if (index == 0) {
              percent = calculatePercent(
                  coreProvider.usedSpace, coreProvider.totalSpace);
            } else {
              // percent = calculatePercent(
              //     coreProvider.usedSDSpace, coreProvider.totalSDSpace);
            }
            return StorageItem(
              percent: percent,
              path: path,
              title: index == 0 ? 'Thiết bị' : 'Thẻ nhớ',
              icon: index == 0 ? Feather.smartphone : Icons.sd_storage,
              color: index == 0 ? Colors.lightBlue : Colors.orange,
              // usedSpace: index == 0
              //     ? coreProvider.usedSpace
              //     : coreProvider.usedSDSpace,
              usedSpace: coreProvider.usedSpace,
              // totalSpace: index == 0
              //     ? coreProvider.totalSpace
              //     : coreProvider.totalSDSpace,
              totalSpace: coreProvider.totalSpace,
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return CustomDivider();
          },
        );
      },
    );
  }

  calculatePercent(double usedSpace, double totalSpace) {
    return double.parse((usedSpace / totalSpace * 100).toStringAsFixed(0)) /
        100;
  }
}

class _CategoriesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      padding: const EdgeInsets.all(8.0),
      shrinkWrap: true,
      mainAxisSpacing: 0,
      childAspectRatio: 4 / 4,
      crossAxisSpacing: 0,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(Constants.categories.length, (index) {
        Map category = Constants.categories[index];
        final item = InkWell(
          onTap: () {
            //
            if (index == Constants.categories.length - 1) {
              Navigate.pushPage(
                  context, Bluetooth(title: '${category['title']}'));
            } else if (index == 0) {
              Navigate.pushPage(context, Images(title: '${category['title']}'));
            } else if (index == 6) {
              Navigate.pushPage(context, const AppScreen());
            } else {
              switch (index) {
                case 1:
                  Navigate.pushPage(
                    context,
                    Videos(title: '${category['title']}'),
                  );
                  break;
                case 2:
                  Navigate.pushPage(
                    context,
                    Audio(title: '${category['title']}'),
                  );
                  break;
                case 3:
                  Navigate.pushPage(
                    context,
                    Downloads(title: '${category['title']}'),
                  );
                  break;
                case 4:
                  Navigate.pushPage(
                    context,
                    Compressed(title: '${category['title']}'),
                  );
                  break;
                case 5:
                  Navigate.pushPage(
                    context,
                    FileScreen(title: '${category['title']}'),
                  );
                  break;
              }
            }
          },
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 5 / 3,
                child: Container(
                  child: Image.asset('assets/icons/' + category['asset'],
                      fit: BoxFit.fitHeight),
                ),
              ),
              const SizedBox(height: 10),
              Text('${category['title']}'),
            ],
          ),
        );
        return item;
      }),
    );

    // return ListView.separated(
    //   shrinkWrap: true,
    //   physics: const NeverScrollableScrollPhysics(),
    //   itemCount: Constants.categories.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     Map category = Constants.categories[index];

    //     return ListTile(
    //       onTap: () {
    //         if (index == Constants.categories.length - 1) {
    //           // Check if the user has whatsapp installed
    //           if (Directory(FileUtils.waPath).existsSync()) {
    //             Navigate.pushPage(
    //               context,
    //               WhatsappStatus(title: '${category['title']}'),
    //             );
    //           } else {
    //             Dialogs.showToast(
    //                 'Please Install WhatsApp to use this feature');
    //           }
    //         } else if (index == 0) {
    //           Navigate.pushPage(
    //               context, Downloads(title: '${category['title']}'));
    //         } else if (index == 5) {
    //           Navigate.pushPage(context, const AppScreen());
    //         } else {
    //           Navigate.pushPage(
    //             context,
    //             index == 1 || index == 2
    //                 ? Images(title: '${category['title']}')
    //                 : Category(title: '${category['title']}'),
    //           );
    //         }
    //       },
    //       contentPadding: const EdgeInsets.all(0),
    //       leading: Container(
    //         height: 40,
    //         width: 40,
    //         decoration: BoxDecoration(
    //           shape: BoxShape.circle,
    //           border: Border.all(
    //             color: Theme.of(context).dividerColor,
    //             width: 2,
    //           ),
    //         ),
    //         child: Icon(category['icon'], size: 18, color: category['color']),
    //       ),
    //       title: Text('${category['title']}'),
    //     );
    //   },
    //   separatorBuilder: (BuildContext context, int index) {
    //     return CustomDivider();
    //   },
    // );
  }
}

class _RecentFiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (BuildContext context, provider, Widget? child) {
        return DefaultTabController(
          length: provider.downloadTabs.length,
          child: Visibility(
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
        );
      },
    );
  }
}
