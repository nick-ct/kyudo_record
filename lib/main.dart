import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyudo_record/controller/database_controller.dart';
import 'package:kyudo_record/controller/shoot_controller.dart';
import 'package:kyudo_record/views/calendar/calendar_page.dart';
import 'package:kyudo_record/views/shoot_record/shoot_record_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final DatabaseController databaseController = Get.put(DatabaseController(), permanent: true);
  await databaseController.init();
  final ShootController shootController = Get.put(ShootController(), permanent: true);
  await shootController.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kyudo Record',
      theme: ThemeData(
          fontFamily: 'NotoSansHK',
          primaryColor: Colors.blue,
          appBarTheme: AppBarTheme(
            centerTitle: true,
            color: Colors.blue[350],
          )),
      debugShowCheckedModeBanner: true,
      initialRoute: '/shootRecordPage',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/shootRecordPage':
            return GetPageRoute(
              page: () => const ShootRecordPage(),
              settings: settings,
              transition: Transition.fadeIn,
            );
          case '/calendarPage':
            return GetPageRoute(
              page: () => const CalendarPage(),
              settings: settings,
              transition: Transition.fadeIn,
            );
        }
        return null;
      },
    );
  }
}
