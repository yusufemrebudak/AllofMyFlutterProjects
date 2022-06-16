import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_storage/services/local_storage.servicesABS.dart';

import '../model/models.dart';

class SecureStorageServices implements LocalStorageService {
  late final FlutterSecureStorage preferences;
  SecureStorageServices() {
    debugPrint("secure storage kurucusu çalıştı");
    preferences = const FlutterSecureStorage();
  }

  @override
  Future<void> verileriKaydet(UserInformation userInformation) async {
    await preferences.write(key: 'isim', value: userInformation.isim);
    await preferences.write(
        key: 'ogrenci', value: userInformation.ogrenciMi.toString());
    await preferences.write(
        key: 'cinsiyet', value: userInformation.cinsiyet.index.toString());
    await preferences.write(
        key: 'renkler',
        value: jsonEncode(
            userInformation.renkler)); // json encode bunu string olarak kodlar
  }

  @override
  Future<UserInformation> verileriOku() async {
    var _isim = await preferences.read(key: 'isim') ?? '';
    var _ogrenciString =
        await preferences.read(key: 'ogrenci') ?? 'false'; // null ise false ata
    var _ogrenci = _ogrenciString.toLowerCase() == 'true' ? true : false;
    var _cinsiyetString = await preferences.read(key: 'cinsiyet') ??
        '0'; // null ise string gönder '1' veya '2'
    // eğer null değilse '0' ı gönder string olarak
    var _cinsiyet = Cinsiyet.values[int.parse(_cinsiyetString)];
    var _renklerString = await preferences.read(key: 'renkler');

    var _renkler = _renklerString == null
        ? <String>[]
        : List<String>.from(jsonDecode(_renklerString));

    return UserInformation(_isim, _cinsiyet, _renkler, _ogrenci);
  }
}
