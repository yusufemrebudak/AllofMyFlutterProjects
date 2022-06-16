import 'package:flutter/material.dart';
import 'package:flutter_not_sepeti/models/kategori.dart';
import 'package:flutter_not_sepeti/models/notlar.dart';
import 'package:flutter_not_sepeti/utils/database_helper.dart';

class NotDetay extends StatefulWidget {
  String? baslik;
  Not? duzenlenecekNot;
  NotDetay({this.baslik, this.duzenlenecekNot, Key? key}) : super(key: key);

  @override
  State<NotDetay> createState() => _NotDetayState();
}

class _NotDetayState extends State<NotDetay> {
  var formKey = GlobalKey<FormState>();
  late List<Kategori> tumKategoriler;
  late DatabaseHelper databaseHelper;
  late int kategoriID;
  late int secilenOncelik;
  late String notBaslik;
  String? notIcerik;
  static var _oncelik = ["dusuk", "orta", "yuksek"];
  @override
  void initState()  {
    super.initState();
    tumKategoriler = [];
    databaseHelper = DatabaseHelper();
    databaseHelper.kategorileriGetir().then((kategorileriIcerenMapListesi) {
      for (Map okunanMap in kategorileriIcerenMapListesi) {
        (okunanMap as Map<String, dynamic>);
        tumKategoriler.add(Kategori.fromMap(okunanMap));
      }
      if (widget.duzenlenecekNot != null) {
        kategoriID = widget.duzenlenecekNot!.kategoriID;
        debugPrint(kategoriID.toString());
        secilenOncelik = widget.duzenlenecekNot!.notOncelik;
      } else {
        kategoriID = tumKategoriler[0].kategoriID!;
        debugPrint(kategoriID.toString());
        secilenOncelik = 0;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(widget.baslik.toString()),
        ),
        body: tumKategoriler.length <= 0
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Text(
                                "Kategori : ",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 24),
                                margin: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black54, width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<int>(
                                      items: kategoriItemleriOlustur(),
                                      value: kategoriID,
                                      onChanged: (secilenKategoriID) {
                                        setState(() {
                                          kategoriID = secilenKategoriID!;
                                        });
                                      }),
                                ))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            initialValue: widget.duzenlenecekNot != null
                                ? widget.duzenlenecekNot!.notBaslik.toString()
                                : " ",
                            validator: (text) {
                              if (text!.length < 3) {
                                return "en az 3 karakter giriniz";
                              }
                            },
                            onSaved: (text) {
                              notBaslik = text!;
                            },
                            decoration: const InputDecoration(
                                hintText: "Not Başlığını giriniz",
                                labelText: "Başlık",
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            initialValue: widget.duzenlenecekNot != null
                                ? widget.duzenlenecekNot!.notIcerik.toString()
                                : " ",
                            onSaved: (text) {
                              notIcerik = text;
                            },
                            maxLines: 4,
                            decoration: const InputDecoration(
                                hintText: "Not İçeriğini giriniz",
                                labelText: "İçerik",
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                          ),
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Text(
                                "Öncelik : ",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 24),
                                margin: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black54, width: 2),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<int>(
                                      items: _oncelik.map((oncelik) {
                                        return DropdownMenuItem<int>(
                                            value: _oncelik.indexOf(
                                                oncelik), // "dusuk de 0 , orta da 1 , yuksek de 2 döner"
                                            child: Text(oncelik));
                                      }).toList(),
                                      value: secilenOncelik,
                                      onChanged: (secilenOncelikID) {
                                        setState(() {
                                          print(secilenOncelikID.toString());
                                          secilenOncelik = secilenOncelikID!;
                                        });
                                      }),
                                ))
                          ],
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Vazgeç"),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.redAccent.shade700,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  var suan = DateTime.now();
                                  if (widget.duzenlenecekNot == null) {
                                    databaseHelper
                                        .notEkle(Not(
                                            kategoriID,
                                            notBaslik,
                                            notIcerik!,
                                            suan.toString(),
                                            secilenOncelik))
                                        .then((kaydedilenNotID) {
                                      if (kaydedilenNotID != 0) {
                                        Navigator.pop(context);
                                      }
                                    });
                                  } else {
                                    print("1");
                                    databaseHelper
                                        .notGuncelle(Not.withID(
                                            widget.duzenlenecekNot!.notID,
                                            kategoriID,
                                            notBaslik,
                                            notIcerik,
                                            suan.toString(),
                                            secilenOncelik))
                                        .then((guncellenenID) {
                                      print(guncellenenID);
                                      if (guncellenenID != 0) {
                                        Navigator.pop(context);
                                      }
                                    });
                                  }
                                }
                              },
                              child: Text("Kaydet"),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.greenAccent.shade700,
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
              ));
  }

  List<DropdownMenuItem<int>> kategoriItemleriOlustur() {
    print(tumKategoriler.toString());
    return tumKategoriler
        .map((kategori) => DropdownMenuItem<int>(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  kategori.kategoriBaslik,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              value: kategori.kategoriID,
            ))
        .toList();
  }
}

/*
Form(
          key: formKey,
          child: Column(
            children: [
              Center(
                child: Container(
                  child: DropdownButton<int>(
                      items: kategoriItemleriOlustur(),
                      value: kategoriID,
                      onChanged: (secilenKategoriID) {
                        setState(() {
                          kategoriID = secilenKategoriID!;
                        });
                      }),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              )
            ],
          )),
*/
