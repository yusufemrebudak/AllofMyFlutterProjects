import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app_with_bloc/data/weather_repository.dart';
import 'package:weather_app_with_bloc/locator.dart';
import 'package:weather_app_with_bloc/models/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository = locator<WeatherRepository>();
  // singleton olarak weatherRepository bunu 1 kez üretip tüm uygulamamda kullanmak istiyorum
  WeatherBloc() : super(WeatherInitialState()) {
    on<WeatherEvent>((event, emit) async {
      if (event is FetchWeatherEvent) {
        emit(WeatherLoadingState());
        try {
          final WeatherModel getirilenWeather =
               await weatherRepository.getWeather(event.sehirAdi);
           
          emit(WeatherLoadedState(weather: getirilenWeather));
        } catch (e) {
          emit(WeatherErrorState());
        }
      }
      else if (event is RefreshWeatherEvent) {
        try {
          final WeatherModel getirilenWeather =
               await weatherRepository.getWeather(event.sehirAdi);
           
          emit(WeatherLoadedState(weather: getirilenWeather));
        } catch (e) {
          emit(state);
        }
      }
    });
  }
}
