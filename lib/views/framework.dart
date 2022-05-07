import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Framework extends StatefulWidget {
  final AppBar appbar;
  final Widget body;
  const Framework({Key? key, required this.appbar, required this.body}) : super(key: key);
  @override
  _FrameworkState createState() => _FrameworkState();
}

class _FrameworkState extends State<Framework> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isDrawerOpen = true;

  List<Map> page = [
    {
      'title': 'Record',
      'icon': const FaIcon(FontAwesomeIcons.bullseye),
      'pagename': '/shootRecordPage',
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget drawer = Drawer(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: page
                .map((e) => Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        leading: e['icon'],
                        title: Text(e['title']),
                        onTap: () => Get.offAndToNamed(e['pagename']),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );

    return Scaffold(
        key: _scaffoldKey,
        appBar: widget.appbar,
        // appBar: AppBar(
        //   leading: IconButton(
        //     icon: const Icon(Icons.menu, color: Colors.white),
        //     onPressed: () {
        //       if (context.isLandscape && context.isLargeTablet) {
        //         setState(() => isDrawerOpen = !isDrawerOpen);
        //       } else {
        //         _scaffoldKey.currentState!.isDrawerOpen ? Get.back() : _scaffoldKey.currentState?.openDrawer();
        //       }
        //     },
        //   ),
        // ),
        drawer: context.isLandscape && context.isLargeTablet ? null : drawer,
        body: Row(
          children: [
            if (context.isLandscape && context.isLargeTablet && isDrawerOpen) ...[
              drawer,
              const VerticalDivider(thickness: 1, width: 1),
            ],
            Expanded(child: widget.body),
          ],
        ));
  }
}