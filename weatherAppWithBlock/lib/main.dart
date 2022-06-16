import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_with_bloc/blocs/tema_bloc/tema_bloc.dart';
import 'package:weather_app_with_bloc/blocs/weather_bloc/weather_bloc.dart';
import 'package:weather_app_with_bloc/locator.dart';
import 'package:weather_app_with_bloc/widgets/weather_app.dart';

void main() {
  setupLocator();
  runApp(BlocProvider<TemaBloc>(
    create: (context) => TemaBloc(),
    child:
        const MyApp(), // benim tema bloğum myApp ve altındaki bütün widget lar için geçerli olacaktır.
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemaBloc, TemaState>(
      bloc: BlocProvider.of<TemaBloc>(context),
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title:
              'Weather App', // bazı uygulamayı aşşağı çektiğimde görünen kısım
          theme: (state as UygulamaTemasiState).tema,
          home: BlocProvider<WeatherBloc>(
            // bir blok sunar
            create: (context) => WeatherBloc(),
            child:
                WeatherApp(), // WeatherApp ın içinde bulunan diğer widgetların hepsi bu bloğa erişip kullanabilir.
          ),
        );
      },
    );
  }
}
