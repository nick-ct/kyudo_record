import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyudo_record/views/homepage.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
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
