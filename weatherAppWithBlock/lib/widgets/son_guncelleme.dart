import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_with_bloc/blocs/weather_bloc/weather_bloc.dart';

class SonGuncellemeWidget extends StatelessWidget {
  const SonGuncellemeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return BlocBuilder<WeatherBloc, WeatherState>(
      bloc: _weatherBloc,
      builder: (context, state) {
        var yeniTarih = (state as WeatherLoadedState).weather.time!.toLocal();
        return Text(
          'Son Güncelleme: ' +
              TimeOfDay.fromDateTime(yeniTarih).format(context),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        );
      },
    );
  }
}
