import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hive_local_database/model/ogrenci.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// flutter packages pub run build_runner build komutunu terminalden çalışırdım.
Future<void> main() async {
  //encrypted

  WidgetsFlutterBinding
      .ensureInitialized(); // burdaki işlemler bittikten sonra git widget tree yi oluştur gibi bir anlamı var.

  await Hive.initFlutter('uygulama');
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final containsEncryprionKey = await secureStorage.containsKey(key: 'key');
  // git secureStorage a key degeri 'key' olan bir deger var mı kontrol et.
  if (!containsEncryprionKey) {
    final key = Hive.generateSecureKey();
    await secureStorage.write(
      key: 'key',
      value: base64UrlEncode(key),
    );
  }
  var encryptionKey =
      base64Url.decode(await secureStorage.read(key: 'key') ?? 'yusuf');
  print('Encyrption Key:  $encryptionKey');
  final sifreliKutu = await Hive.openBox('Ozel',
      encryptionCipher: HiveAesCipher(encryptionKey));
  await sifreliKutu.put('secret', 'Hive is cool');
  await sifreliKutu.put('sifre', '123456');
  // bunlar artık şifrelenmiş olarak yazacak.
  print(sifreliKutu.get('secret'));
  print(sifreliKutu.get('sifre'));

  //encrypted

  Hive.registerAdapter(OgrenciAdapter());
  Hive.registerAdapter(GozRenkAdapter());
  await Hive.openBox<Ogrenci>('ogrenciler');

  await Hive.openLazyBox<int>(
      'sayilar'); // bu bütün değerleri değil sadece key değerlerini hafızaya yükler
  // ve ihtiyac halinde o key değerine ait veriyi diskten getirir.

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async {
    var box = Hive.box('test');
    await box.clear();
    box.add('yusuf'); // index 0 key 0 value 'yusuf'
    box.add('budak'); // index 1 key 1 value 'budak'
    box.add(true);
    box.add(123); // index 3  key 3 keyler autoicrement artar.

    await box.put('tc', '12345668923');
    await box.put('tema', 'dark');

    // putlarda keyleri de kendim veriyorum,add de vermiyorum.
    // await box.addAll(['liste1','liste2',false,9532]); // her birini tek tek eleman olarak ekler
    // await box.putAll({'araba': 'mercedes', 'yil': 2012});
    debugPrint(box.get('tema')); // dark yazar.key ile erişim
    debugPrint(box.getAt(0)); // yusuf yazar index ile erişim
    debugPrint(box.get(
        0)); // yusuf yazar key ile erişim, fark put ile eklenen verilerde ortaya çıkıyor.

    debugPrint(box.get('tc')); //12345668923 yazar key ile erişim
    debugPrint(box.getAt(4)); // 12345668923 yazar index ile erişim
    debugPrint(box.length.toString()); // 6 yazar
    await box.delete('tc');
    await box.deleteAt(0);
    await box.putAt(0, 'yeni deger');
    debugPrint(box.toMap().toString());
  }

  void _customData() async {
    var yusuf = Ogrenci(5, 'yusuf', GozRenk.MAVI);
    var emre = Ogrenci(15, 'emre', GozRenk.YESIL);
    var box = Hive.box<Ogrenci>('ogrenciler');

    await box.clear();

    box.add(emre);
    box.add(yusuf);

    box.put('emre', emre);
    box.put('yusuf', yusuf);

    debugPrint(box.toMap().toString());
  }

  void _lazyAndEncrytedBox() async {
    var sayilar = Hive.lazyBox<int>(// hafıza korunması için
        'sayilar'); // lazyBox kutuyu bu şekilde açmamız lazım, ve bunu direkt okuyamam
    // veriler hafızada değil dosyada sadece keyler hafızada
    for (int i = 0; i < 50; i++) {
      await sayilar.add(i * 50);
    }
    for (int i = 0; i < 50; i++) {
      debugPrint((await sayilar.getAt(i)).toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _lazyAndEncrytedBox,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
