import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_with_bloc/blocs/weather_bloc/weather_bloc.dart';

class HavaDurumuResimWidget extends StatelessWidget {
  const HavaDurumuResimWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return BlocBuilder<WeatherBloc, WeatherState>(
      bloc: _weatherBloc,
      builder: (context, state) {
        return Column(
          children: [
            Text(
              (state as WeatherLoadedState)
                      .weather
                      .consolidatedWeather![0]
                      .theTemp!
                      .floor()
                      .toString() +
                  "°C",
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            Image.network(
              "https://www.metaweather.com/static/img/weather/png/" +
                  (state as WeatherLoadedState)
                      .weather
                      .consolidatedWeather![0]
                      .weatherStateAbbr! +
                  ".png",
              width: 200,
              height: 200,
            ),
          ],
        );
      },
    );
  }
}
