import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_app/pages/home_page.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  //materialApp i ScreenUtilInit ile ssarmalayarak responsive her cihazla uyumlu app ler tasarlamak için kullanıyorum
  Widget build(BuildContext context) {
    return ScreenUtilInit( 
      designSize: const Size(412,732),//(width,height)
      builder: ()=> MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PokeDex',
        theme: ThemeData.dark().copyWith(
          textTheme: GoogleFonts.latoTextTheme()
        ),
        home: const HomePage(),
      ),
    );
  }
}
