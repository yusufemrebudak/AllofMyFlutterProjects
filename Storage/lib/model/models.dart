// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';

enum Cinsiyet {
  KADIN,

  ERKEK,

  DIGER,
} // sınıf kadar büyük olmayacak veriler için kullanılabilecek yapılar

enum Renkler { SARI, KIRMIZI, MAVI, YESIL, PEMBE }

class UserInformation {
  final String isim;
  final Cinsiyet cinsiyet;
  final List<String> renkler;
  final bool ogrenciMi;

  UserInformation(this.isim, this.cinsiyet, this.renkler, this.ogrenciMi);

  Map<String, dynamic> toJson() {
    // dosyaya yazarken
    return {
      'isim': isim,
      'cinsiyet': describeEnum(
          cinsiyet), // cinsiyet = Cinsiyet.ERKEK dir metotdan sonra output =>ERKEK çıkar
      'renkler': renkler,
      'ogrenciMi': ogrenciMi,
    };
  }

  UserInformation.fromJson(
      Map<String, dynamic> json) // jsondan nesneye dönüştürmek
      : isim = json['isim'],
        cinsiyet = Cinsiyet.values.firstWhere((element) =>
            describeEnum(element).toString() == json['cinsiyet']), //
        renkler = List<String>.from(json[
            'renkler']), // list dynamic i al içinde stringler barındıran bir liste oluşturup dön.
        ogrenciMi = json['ogrenciMi'];
}
