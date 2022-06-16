import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slider_menu_animation/menu_dashboard_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF343442),
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.pink,
        systemNavigationBarIconBrightness: Brightness.dark  ),
  );

  SystemChrome.setPreferredOrientations(
      // uygulamanın telefon sadece dik modda iken çalışmasını istiyor isek.
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Menu Dashboard',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MenuDashboard(),
    );
  }
}
