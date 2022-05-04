import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyudo_record/controller/database_controller.dart';
import 'package:kyudo_record/views/homepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseController _databaseController = Get.put(DatabaseController(), permanent: true);
  await _databaseController.init();
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
            color: Colors.grey[350],
          )),
      debugShowCheckedModeBanner: true,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return GetPageRoute(
              page: () => const HomePage(),
              settings: settings,
              transition: Transition.fadeIn,
            );
        }
        return null;
      },
    );
  }
}
