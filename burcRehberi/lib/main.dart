import 'package:burc_rehberi/routeGenerator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data/burcListesi.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.pink),
      //home: burcListesi(),
      onGenerateRoute: RouteGenerator.routeGenerator,
      // ne zamanki yeni bir rota isteği gelir üst satır tetiklenir ve bende derim git bunu bu RouteGenerator dosyasının 
      // içindeki routeGenerator methodunu tetikle diyorum 
    );
  }
}
