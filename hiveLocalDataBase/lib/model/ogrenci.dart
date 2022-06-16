import 'package:hive/hive.dart';
part 'ogrenci.g.dart';

@HiveType(typeId: 1) // ogrenci de bir tiptir gozRenk i de bir tiptir.
class Ogrenci {
  @HiveField(0,
      defaultValue:
          555) // defalut value su herhangi bir değer atanmassa 555 yaz hive e yazılırken.
  final int id;

  @HiveField(1)
  final String isim;

  @HiveField(2)
  final GozRenk gozRengi;

  Ogrenci(this.id, this.isim, this.gozRengi);

  @override
  String toString() {
    // TODO: implement toString
    return '$id - $isim - $gozRengi';
  }
}

// bu anotation lar ne işe yarar?
// bir hiv generation paketini kullanacağız ya bi komut çalıştırıcaz, burda verdiğimiz değerlere göre bize yeni bir model dosyası oluşturacak.
@HiveType(typeId: 2)
enum GozRenk {
  @HiveField(0, defaultValue: true)
  SIYAH,

  @HiveField(1)
  MAVI,

  @HiveField(2)
  YESIL,
}
// flutter packages pub run build_runner build komutunu terminalden çalışırdım.
