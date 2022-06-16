import 'package:flutter/material.dart';
import 'package:flutter_storage/services/file_storage_services.dart';
import 'package:flutter_storage/services/local_storage.servicesABS.dart';
import 'package:flutter_storage/services/secure_storage_services.dart';
import 'package:flutter_storage/services/shared_preferences_services.dart';
import 'package:flutter_storage/shared_preferences_kullanimi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setup() {
  //locator.registerSingleton<LocalStorageService>(SharedPreferencesServices());
  // bunu isterseniz 100 kez çağırın sadece 1 nesne üretilecek
  // ve herkes o tek nesneyi kullancak
  // tek nesneye heryerden erişmek için
  // bir kez oluştur ve heryerden kullan.
  // tek bir çatı altında topladık LocalStroageService diyerrek artık başka yerlerden bu locatora ulaşıp
  // bunu kullanmak isteseler bile localstorageservice olarak tanımlandığından hata vermeyecek.
  locator.registerLazySingleton<LocalStorageService>(
      () => SecureStorageServices()); // uygulamada ne zaman kullanılırsa o zaman çağırılacaktır yani
    // sharedpreferenceskullanimi sınıfından erişildiğinde tetiklenecek 
  
}

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); // runapp den önce uzun süren işlemler olabilir ama uygulamada açılmaya çalışıyor, hata almamak için bunu yazmamız gerekir.
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sharef Preference "),
        ),
        body: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(onSurface: Colors.red),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SharefPreferencesKullanimi()));
            },
            child: Text('Shared Preferences'),
          ),
        ));
  }
}
