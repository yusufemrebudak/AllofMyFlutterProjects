import 'package:flutter/material.dart';
import 'package:flutter_not_sepeti/models/kategori.dart';
import 'package:flutter_not_sepeti/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class Kategoriler extends StatefulWidget {
  Kategoriler({Key? key}) : super(key: key);

  @override
  State<Kategoriler> createState() => _KategorilerState();
}

class _KategorilerState extends State<Kategoriler> {
  List<Kategori>? tumKategoriler;
  late DatabaseHelper databaseHelper;
  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
    print("Kategoriler init çalıştı");
    tumKategoriler = [];
    kategoriListesiniGuncelle();
  }

  @override
  Widget build(BuildContext context) {
    // if (tumKategoriler == null) {
    //   tumKategoriler = [];
    //   kategoriListesiniGuncelle();
    // }

    return Scaffold(
        appBar: AppBar(
          title: Text("Kategoriler"),
        ),
        body: ListView.builder(
            itemCount: tumKategoriler!.length,
            itemBuilder: (context, index) {
              // bunlar eleman oluşturulurken tetiklenir
              return ListTile(
                onTap: () => kategoriGuncelle(tumKategoriler![index], context),
                title: Text(tumKategoriler![index].kategoriBaslik),
                trailing: InkWell(
                  child: Icon(Icons.delete),
                  onTap: () => _kategoriSil(tumKategoriler![index].kategoriID),
                ),
                leading: Icon(Icons.category),
              );
            }));
  }

  void kategoriListesiniGuncelle() {
    databaseHelper.kategoriListesiniGetir().then((kategorileriIcerenList) {
      setState(() {
        tumKategoriler = kategorileriIcerenList;
      });
    });
  }

  _kategoriSil(int? kategoriID) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Kategoriyi Sil?"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    "Bu kategoriyi sildiğinizde onunla ilgili tüm notlarda silinecektir. Emin misiniz ?"),
                ButtonBar(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Vazgeç")),
                    TextButton(
                        onPressed: () {
                          databaseHelper
                              .kategoriSil(kategoriID!)
                              .then((silinenKategori) {
                            if (silinenKategori != 0) {
                              setState(() {
                                kategoriListesiniGuncelle();
                              });
                              Navigator.pop(context);
                            }
                          });
                        },
                        child: Text("Sil"))
                  ],
                )
              ],
            ),
          );
        });
  }

  kategoriGuncelle(Kategori guncellenecekKategori, BuildContext context) {
    kategoriGuncelleDialog(context, guncellenecekKategori);
  }

  void kategoriGuncelleDialog(
      BuildContext myContext, Kategori guncellenecekKategori) {
    var formkey = GlobalKey<FormState>();
    late String guncellenecekKategoriAdi;
    showDialog(
        barrierDismissible: false, // boşluğa basınca çıkamasın diye
        context: myContext,
        builder: (context) {
          return SimpleDialog(
            title: Text(
              "Kategori Güncelle",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            children: [
              Form(
                  key: formkey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: guncellenecekKategori.kategoriBaslik,
                      onSaved: (newValue) {
                        guncellenecekKategoriAdi = newValue!;
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
                              .kategoriGuncelle(Kategori.withID(
                                  guncellenecekKategori.kategoriID,
                                  guncellenecekKategoriAdi))
                              .then((guncellenenKategoriId) {
                            if (guncellenenKategoriId != 0) {
                              ScaffoldMessenger.of(myContext)
                                  .showSnackBar(const SnackBar(
                                content: Text("Kategori Guncellendi"),
                                duration: Duration(seconds: 1),
                              ));
                              kategoriListesiniGuncelle();
                              Navigator.of(context).pop();
                            }
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
}
