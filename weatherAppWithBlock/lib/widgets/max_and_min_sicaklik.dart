import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/weather_bloc/weather_bloc.dart';

class MaxAndMinSicaklikWidget extends StatelessWidget {
  const MaxAndMinSicaklikWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return BlocBuilder<WeatherBloc, WeatherState>(
      bloc: _weatherBloc,
      builder: (context, state) {
        
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Maximum : " + (state as WeatherLoadedState).weather.consolidatedWeather![0].maxTemp!.floor().toString()+ "°C",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Text(
              "Minimum : " + (state as WeatherLoadedState).weather.consolidatedWeather![0].minTemp!.floor().toString()+ "°C",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ],
        );
      },
    );
  }
}
