import 'package:dynamic_ortalama_hesapla/Constants/app_constants.dart';
import 'package:dynamic_ortalama_hesapla/helper/data_helper.dart';
import 'package:dynamic_ortalama_hesapla/model/ders.dart';
import 'package:dynamic_ortalama_hesapla/widgets/dersListesi.dart';
import 'package:dynamic_ortalama_hesapla/widgets/harfDropDownWidget.dart';
import 'package:dynamic_ortalama_hesapla/widgets/krediDropDownWidget.dart';
import 'package:dynamic_ortalama_hesapla/widgets/ortalamaGoster.dart';
import 'package:flutter/material.dart';

class OrtalamaHesaplaPage extends StatefulWidget {
  OrtalamaHesaplaPage({Key? key}) : super(key: key);

  @override
  State<OrtalamaHesaplaPage> createState() => _OrtalamaHesaplaPageState();
}

class _OrtalamaHesaplaPageState extends State<OrtalamaHesaplaPage> {
  double secilenHarfDegeri = 4;
  double secilenKrediDegeri = 1;
  String girilenDersAdi = '';

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // klavye çıktığında sarı uyarı gelirse bunu
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            Sabitler.baslikText,
            style: Sabitler.baslikStyle,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _builtForm(),
              ),
              Expanded(
                flex: 1,
                child: OrtalamaGoster(
                    dersSayisi: Datahelper.tumEklenendersler.length,
                    ortalama: Datahelper.ortalamaHesapla()),
              )
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: DersListesi(
              onDismiss: (index) {
                Datahelper.tumEklenendersler.removeAt(index);
                setState(() {});
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _builtForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: Sabitler.yatayPadding,
            child: _builtTextFormField(),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: Sabitler.yatayPadding,
                  child: harfDropDownWidget(
                    onHarfSecildi: (harf) {
                      secilenHarfDegeri = harf;
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: Sabitler.yatayPadding,
                  child: krediDrowDownWidget(onKrediSecildi: (kredi) {
                    secilenKrediDegeri = kredi;
                  }),
                ),
              ),
              IconButton(
                onPressed: _dersEkleveOrtalamaHesapla,
                icon: Icon(Icons.arrow_forward_ios_sharp),
                color: Sabitler.anaRenk,
                iconSize: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }

  _builtTextFormField() {
    return TextFormField(
      onSaved: (deger) {
        girilenDersAdi = deger!;
      },
      validator: (s) {
        if (s!.length <= 0) {
          return 'Ders Adi Giriniz';
        }
      },
      decoration: InputDecoration(
          hintText: 'Matematik',
          border: OutlineInputBorder(
              borderRadius: Sabitler.borderRadius, borderSide: BorderSide.none),
          filled: true,
          fillColor: Sabitler.anaRenk.shade100.withOpacity(0.4)),
    );
  }

  void _dersEkleveOrtalamaHesapla() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save(); // onsave çalışacak
      var eklenecekDers = Ders(
          ad: girilenDersAdi,
          harfDegeri: secilenHarfDegeri,
          krediDegeri: secilenKrediDegeri);
      Datahelper.dersEkle(eklenecekDers);
      setState(() {});
    }
  }
}
