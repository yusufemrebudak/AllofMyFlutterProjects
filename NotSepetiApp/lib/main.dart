import 'package:flutter/material.dart';
import 'package:flutter_not_sepeti/kategori_islemleri.dart';
import 'package:flutter_not_sepeti/models/kategori.dart';
import 'package:flutter_not_sepeti/models/notlar.dart';
import 'package:flutter_not_sepeti/not_detay.dart';
import 'package:flutter_not_sepeti/utils/database_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ' Not Sepeti',
      theme: ThemeData(
        fontFamily: "Raleway",
        primarySwatch: Colors.purple,
        //colorScheme:
        // ColorScheme.fromSwatch().copyWith(secondary: Colors.orange),
      ),
      home: NotListesi(),
    );
  }
}

class NotListesi extends StatefulWidget {
  NotListesi({Key? key}) : super(key: key);

  @override
  State<NotListesi> createState() => _NotListesiState();
}

class _NotListesiState extends State<NotListesi> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  var _scaffoldKey = GlobalKey<ScaffoldState>();
  // bu global key scafoldState de diyorum
  @override
  Widget build(BuildContext context) {
    print("NotListesi build metodu çalıştı");
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Not Sepeti",
            style:
                TextStyle(fontFamily: "Raleway", fontWeight: FontWeight.w700),
          ),
        ),
        actions: [
          PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem(
                  child: ListTile(
                onTap: () => _kategorilereGit(),
                leading: Icon(Icons.category),
                title: const Text(
                  "Kategoriler",
                  style: TextStyle(
                      fontFamily: "Raleway", fontWeight: FontWeight.w700),
                ),
              ))
            ];
          })
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              kategoriEkleDialog(context);
            },
            tooltip: "Kategori Ekle",
            heroTag: "KategoriEkle",
            child: const Icon(Icons.add_circle),
            mini: true,
          ),
          FloatingActionButton(
            onPressed: () => _detaySayfasinaGit(context),
            tooltip: "Not Ekle",
            heroTag: "NotEkle",
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: Notlar(),
    );
  }

  void kategoriEkleDialog(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    late String yeniKategoriAdi;
    showDialog(
        barrierDismissible: false, // boşluğa basınca çıkamasın diye
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text(
              "Kategori Ekle",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            children: [
              Form(
                  key: formkey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onSaved: (newValue) {
                        yeniKategoriAdi = newValue!;
                      },
                      decoration: const InputDecoration(
                        labelText: "Kategori Adı",
                        border: OutlineInputBorder(),
                      ),
                      validator: (girilenKategoriAdi) {
                        if (girilenKategoriAdi!.length < 3) {
                          return 'En az 3 karakter giriniz';
                        }
                      },
                    ),
                  )),
              ButtonBar(
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Vazgeç",
                        style: TextStyle(color: Colors.white),
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade600,
                      ),
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          formkey.currentState!.save();
                          databaseHelper
                              .kategoriEkle(Kategori(yeniKategoriAdi))
                              .then((kategoriID) {
                            if (kategoriID > 0) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Kayıt eklendi"),
                                duration: Duration(seconds: 2),
                              ));
                              debugPrint("kategori eklendi: $kategoriID");
                            }
                            Navigator.of(context).pop();
                          });
                        }
                      },
                      child: const Text(
                        "Kaydet",
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              )
            ],
          );
        });
  }

  _detaySayfasinaGit(BuildContext context) {
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => NotDetay(
    //               baslik: "Yeni Not ",
    //             )));
    Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NotDetay(baslik: "Not Detay")))
        .then((value) => setState(() {}));
  }

  void _kategorilereGit() {
    Navigator.push(
            context, MaterialPageRoute(builder: (context) => Kategoriler()))
        .then((value) => setState(() {}));
  }
}

/////////////// STATEFUL BAŞLANGIÇ /////////////////////////
class Notlar extends StatefulWidget {
  Notlar({Key? key}) : super(key: key);

  @override
  State<Notlar> createState() => _NotlarState();
}

class _NotlarState extends State<Notlar> {
  late List<Not> tumNotlar;
  late DatabaseHelper databaseHelper;
  @override
  void initState() {
    super.initState();
    tumNotlar = [];
    databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    print("Notlar build metodu çalıştı");

    return FutureBuilder(
        // her geriye dönüldüğünfr futureBuilder
        // future: databaseHelper.notListesiGetir(),yapısını çalıştırarak listeyi günceller.
        future: databaseHelper.notListesiGetir(),
        builder: (context, AsyncSnapshot<List<Not>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            tumNotlar = snapshot.data!;
            return ListView.builder(
                itemCount: tumNotlar.length,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    leading: _oncelikIconAta(tumNotlar[index].notOncelik),
                    title: Text(
                      tumNotlar[index].notBaslik,
                      style: const TextStyle(color: Colors.black, fontSize: 22),
                    ),
                    children: [
                      Container(
                        padding: EdgeInsets.all(4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Kategori",
                                    style: TextStyle(
                                        color: Colors.redAccent, fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    tumNotlar[index].kategoriBaslik.toString(),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Oluşturulma Tarihi",
                                    style: TextStyle(
                                        color: Colors.redAccent, fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    databaseHelper.dateFormat(DateTime.parse(
                                        tumNotlar[index].notTarih!)),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "İçerik: \n" +
                                    tumNotlar[index].notIcerik.toString(),
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            ButtonBar(
                              alignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      _notSil(tumNotlar[index].notID);
                                    },
                                    child: const Text(
                                      "SİL",
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.bold),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      _detaySayfasinaGit(
                                          context, tumNotlar[index]);
                                    },
                                    child: const Text(
                                      "GÜNCELLE",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }); // future propery deki yapı bittikten sonra builder a yazılır ne yapılacağı
  }

  _oncelikIconAta(int notOncelik) {
    switch (notOncelik) {
      case 0:
        return CircleAvatar(
          child: Text(
            "AZ",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.greenAccent.shade700,
        );
        break;
      case 1:
        return CircleAvatar(
          child: Text(
            "ORTA",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.orange.shade700,
        );
        break;
      case 2:
        return CircleAvatar(
          child: Text(
            "ACİL",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent.shade700,
        );
        break;
      default:
    }
  }

  void _notSil(int? notID) {
    databaseHelper.notSil(notID!).then((silinenID) {
      if (silinenID != 0) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Not Silindi"),
          duration: Duration(seconds: 2),
        ));
        setState(() {});
      }
    });
  }

  _detaySayfasinaGit(BuildContext context, Not not) {
    Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    NotDetay(baslik: "Notu Düzenle", duzenlenecekNot: not)))
        .then((value) => setState(() {}));
  }
}
