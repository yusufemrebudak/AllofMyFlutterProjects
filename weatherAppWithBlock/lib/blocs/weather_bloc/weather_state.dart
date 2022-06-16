part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
  @override
  List<Object> get props => [];
}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final WeatherModel weather;

  const WeatherLoadedState({required this.weather}) : super();
  @override
  List<Object> get props => [weather];
}

class WeatherErrorState extends WeatherState {}
