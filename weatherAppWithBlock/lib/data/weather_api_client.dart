import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_with_bloc/models/weather_model.dart';

class WeatherApiClient {
  static const baseUrl = "https://www.metaweather.com/";
  final http.Client httpClient = http.Client();
  Future<int> getLocationID(String sehirAdi) async {
    // bu method uzun sürecek ve bana bu uzun işleminsonunda int değer döndürecek
    final sehirUrl = baseUrl + "api/location/search/?query=" + sehirAdi;
    final gelenCevap = await httpClient.get(Uri.parse(
        sehirUrl)); // bu url üzerinden gidip ban string olarak değerleri getirecek
    if (gelenCevap.statusCode != 200) {
      throw Exception("Veri getirelemedi");
    } else {
      final gelenCevapJson = (jsonDecode(gelenCevap.body))
          as List; // string olarak gelen jsonu JSON objecte çevirir.
      return gelenCevapJson[0]["woeid"];
    }
  }

  Future<WeatherModel> getWeather(int sehirID) async {
    final havaDurumuUrl = baseUrl + "api/location/" + sehirID.toString();
    debugPrint(havaDurumuUrl);
    final havaDurumuGelenCevap = await httpClient.get(Uri.parse(havaDurumuUrl));

    if (havaDurumuGelenCevap.statusCode != 200) {
      throw Exception("Hava Durumu getirelemedi");
    } else {
      final havaDurumuGelenCevapJson = jsonDecode(havaDurumuGelenCevap.body);// string olarak gelen jsonu JSON objecte çevirir.
      return WeatherModel.fromJson(havaDurumuGelenCevapJson);
    }
  }
}
