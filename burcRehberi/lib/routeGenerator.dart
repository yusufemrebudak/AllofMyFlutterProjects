import 'package:burc_rehberi/burcDetay.dart';
import 'package:burc_rehberi/data/burcListesi.dart';
import 'package:flutter/material.dart';

import 'model/burc.dart';

class RouteGenerator {
  static Route<dynamic>? routeGenerator(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => burcListesi());
        break;
      case '/burcDetay':
        final Burc secilen = settings.arguments as Burc;
        return MaterialPageRoute(builder: (context) => burcDetay(secilenBurc:secilen));

        break;
      default:
    }
  }
}
