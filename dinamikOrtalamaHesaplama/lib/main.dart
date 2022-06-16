import 'package:dynamic_ortalama_hesapla/Constants/app_constants.dart';
import 'package:dynamic_ortalama_hesapla/widgets/OrtalamaHesaplaPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dinamik Ortalama Hesapla',
      theme: ThemeData(
          primarySwatch: Sabitler.anaRenk,
          visualDensity: VisualDensity
              .adaptivePlatformDensity), // diğer ortamlarda da o ortamlara uygun görünmesini  sağlayabiliriz.
      home: OrtalamaHesaplaPage(),
    );
  }
}
