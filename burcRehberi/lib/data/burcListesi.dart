import 'package:burc_rehberi/data/string.dart';
import 'package:burc_rehberi/model/burc.dart';
import 'package:flutter/material.dart';

import '../burcItem.dart';

class burcListesi extends StatelessWidget {
  late List<Burc>
      tumBurclar; // late şu anlama gelir, bu şuan initilize edilmedi ama yapıcam ama merak etme
  // kullanmadan önce initilize edicem.
  burcListesi() {
    tumBurclar = veriKaynaginiHazirla();
    print(tumBurclar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Burçlar Listesi"),
      ),
      body: Center(
        child: ListView.builder(
          // daha performanslıdır
          itemCount: tumBurclar.length,
          itemBuilder: (BuildContext context, int index) {
            return burcItem(listelenenBurc: tumBurclar[index]);
          },
        ),
      ),
    );
  }

  List<Burc> veriKaynaginiHazirla() {
    List<Burc> temp = [];
    for (int i = 0; i < 12; i++) {
      var kucukBurcResim =
          Strings.BURC_ADLARI[i].toLowerCase() + '${i + 1}.png';
      var buyukBurcResim =
          Strings.BURC_ADLARI[i].toLowerCase() + '_buyuk${i + 1}.png';
      Burc eklencekBurc = Burc(
          Strings.BURC_ADLARI[i],
          Strings.BURC_TARIHLERI[i],
          Strings.BURC_GENEL_OZELLIKLERI[i],
          kucukBurcResim,
          buyukBurcResim);
      temp.add(eklencekBurc);
    }
    return temp;
  }
}
