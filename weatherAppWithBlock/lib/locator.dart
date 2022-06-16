import 'package:get_it/get_it.dart';
import 'package:weather_app_with_bloc/data/weather_api_client.dart';
import 'package:weather_app_with_bloc/data/weather_repository.dart';

GetIt locator = GetIt.asNewInstance();
//GetIt locator2 = GetIt.I;
//GetIt locator3 = GetIt.asNewInstance();
void setupLocator() {
  locator.registerLazySingleton(() =>
      WeatherRepository()); // bana geriye WeatherRepository döndür diyorum,
  // eski haliyle event içinde WeatherRepository nesnesini oluşturulsa idi 1000 kez istek atsak 1000 kez yeni nesne oluşacaktı
  // locator ile çağırdığımızda ise getIt e bağladığımız için singleton olarak üretilecek ve 1000 kez istek atsak bile aynı nesne üzerinden çağırırız. bu nesne sadece 1  kez üretilir.
  locator.registerLazySingleton(() => WeatherApiClient());
}
