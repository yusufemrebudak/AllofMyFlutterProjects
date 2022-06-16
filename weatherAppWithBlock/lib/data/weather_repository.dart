import 'package:flutter/material.dart';
import 'package:weather_app_with_bloc/data/weather_api_client.dart';
import 'package:weather_app_with_bloc/locator.dart';
import 'package:weather_app_with_bloc/models/weather_model.dart';

class WeatherRepository {
  WeatherApiClient weatherApiClient = locator<WeatherApiClient>();

  Future<WeatherModel> getWeather(String sehirAdi) async {
    final int sehirID = await weatherApiClient.getLocationID(sehirAdi);
    debugPrint(sehirID.toString());
    return await weatherApiClient.getWeather(sehirID);
  }
}

// repository sınıfı, bize data provider(database lerden) gelen veriler arasında mantık kuran, işlem yapan sınıftır.
