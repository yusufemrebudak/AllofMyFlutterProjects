part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchWeatherEvent extends WeatherEvent {
  final String sehirAdi;

  const FetchWeatherEvent({required this.sehirAdi}) : super();

  @override
  List<Object> get props => [sehirAdi];
}

class RefreshWeatherEvent extends WeatherEvent {
  final String sehirAdi;

  const RefreshWeatherEvent({required this.sehirAdi}) : super();

  @override
  List<Object> get props => [sehirAdi];
}