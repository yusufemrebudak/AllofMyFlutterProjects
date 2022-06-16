import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_with_bloc/blocs/tema_bloc/tema_bloc.dart';
import 'package:weather_app_with_bloc/blocs/weather_bloc/weather_bloc.dart';
import 'package:weather_app_with_bloc/widgets/gecisli_arka_plan_rengi.dart';
import 'package:weather_app_with_bloc/widgets/hava_durumu_resim.dart';
import 'package:weather_app_with_bloc/widgets/location.dart';
import 'package:weather_app_with_bloc/widgets/max_and_min_sicaklik.dart';
import 'package:weather_app_with_bloc/widgets/sehir_sec.dart';
import 'package:weather_app_with_bloc/widgets/son_guncelleme.dart';

class WeatherApp extends StatelessWidget {
  WeatherApp({Key? key}) : super(key: key);
  String kullanicininSectigiSehir = "";
  Completer<void> _refreshCompleter = Completer<
      void>(); // async sınıfındaki completer kütüphanesinden nesne aldım

  @override
  Widget build(BuildContext context) {
    final _weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        actions: [
          IconButton(
              onPressed: () async {
                kullanicininSectigiSehir = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SehirSecWidget()));
                //sen bunu await ile bekle geri değer döndürdüğünde bunu secilenSehir değişkenine ata.
                if (kullanicininSectigiSehir != null) {
                  _weatherBloc.add(FetchWeatherEvent(
                      sehirAdi:
                          kullanicininSectigiSehir)); // bloğa ankara şehrinin verisini istiyorum gibisinden bir state istiyorum
                }
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Center(
        child: BlocBuilder<WeatherBloc, WeatherState>(
          bloc: _weatherBloc,
          builder: (context, state) {
            if (state is WeatherInitialState) {
              return const Center(
                child: Text("Şehir seçiniz"),
              );
            }
            if (state is WeatherLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is WeatherLoadedState) {
              final getirilenWeather = state.weather;

              kullanicininSectigiSehir = getirilenWeather.title!;

              BlocProvider.of<TemaBloc>(context).add(TemaDegistirEvent(
                  havaDurumuKisaltmasi: getirilenWeather
                      .consolidatedWeather![0].weatherStateAbbr!));

              _refreshCompleter.complete();
              _refreshCompleter = Completer();
              return BlocBuilder<TemaBloc, TemaState>(
                bloc: BlocProvider.of<TemaBloc>(context),
                builder: (context, state) {
                  return GecisliRenkContainer(
                              renk: (state as UygulamaTemasiState).renk,
                              child: RefreshIndicator(
                                onRefresh: () {
                                  debugPrint(kullanicininSectigiSehir + "2");
                                  _weatherBloc.add(
                                      RefreshWeatherEvent(sehirAdi: kullanicininSectigiSehir));
                            
                                  return _refreshCompleter.future;
                                },
                                child: ListView(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                          child: LocationWidget(
                                              secilenSehir: getirilenWeather.title!)),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Center(child: SonGuncellemeWidget()),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Center(child: HavaDurumuResimWidget()),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Center(child: MaxAndMinSicaklikWidget()),
                                    ),
                                  ],
                                ),
                              ),
                            );
                },
              );
            } else {
              return const Center(
                child: Text("Hata Oluştu"),
              );
            }
          },
        ),
      ),
    );
  }
}
