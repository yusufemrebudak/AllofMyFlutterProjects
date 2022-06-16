import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Constants {
  Constants._(); // artık bu sınıftan kimse nesne üretemez, çünkü constructorı gizli yaptım.
  static const String title = "PokeDex";
  static TextStyle titleStyle() {
    return TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: _calculateFontSize(40),
    );
  }

  static TextStyle pokemonNameTextStyle() {
    return TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: _calculateFontSize(24),
    );
  }

  static TextStyle typeChipTextStyle() {
    return TextStyle(
      color: Colors.white,
      fontSize: _calculateFontSize(20),
    );
  }

  static _calculateFontSize(int size) {
    if (ScreenUtil().orientation == Orientation.portrait) {
      return size.sp;
    } else {
      return (size * 1.2).sp;
    }
  }

  static TextStyle getPokeInfoLabelStyle() {
    return TextStyle(fontSize: _calculateFontSize(20), fontWeight: FontWeight.bold, color: Colors.black);
  }

  static TextStyle getPokeInfoTextStyle() {
    return TextStyle(fontSize: _calculateFontSize(16), color: Colors.black);
  }
}
