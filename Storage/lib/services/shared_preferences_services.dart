import 'package:flutter/material.dart';
import 'package:flutter_storage/model/models.dart';
import 'package:flutter_storage/services/local_storage.servicesABS.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesServices implements LocalStorageService {
  late final SharedPreferences preferences;
  SharedPreferencesServices() {
    debugPrint("shared kurucus çalıştı");
    initIsimOnemsiz();
  }

  Future<void> initIsimOnemsiz() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Future<void> verileriKaydet(UserInformation userInformation) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString('isim', userInformation.isim);
    preferences.setBool('ogrenci', userInformation.ogrenciMi);
    preferences.setInt('cinsiyet', userInformation.cinsiyet.index);
    preferences.setStringList('renkler', userInformation.renkler);
  }

  @override
  Future<UserInformation> verileriOku() async {
    var _isim = preferences.getString('isim') ?? ''; // boşsa nul koy
    var _ogrenci = preferences.getBool('ogrenci') ?? false;
    var _cinsiyet = Cinsiyet.values[preferences.getInt('cinsiyet') ?? 0];
    var _renkler = preferences.getStringList('renkler') ?? <String>[];
    return UserInformation(_isim, _cinsiyet, _renkler, _ogrenci);
  }
}
