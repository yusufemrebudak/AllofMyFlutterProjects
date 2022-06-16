import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_storage/main.dart';
import 'package:flutter_storage/model/models.dart';
import 'package:flutter_storage/services/file_storage_services.dart';
import 'package:flutter_storage/services/local_storage.servicesABS.dart';
import 'package:flutter_storage/services/secure_storage_services.dart';
import 'package:flutter_storage/services/shared_preferences_services.dart';

class SharefPreferencesKullanimi extends StatefulWidget {
  const SharefPreferencesKullanimi({Key? key}) : super(key: key);

  @override
  State<SharefPreferencesKullanimi> createState() =>
      _SharefPreferencesKullanimiState();
}

class _SharefPreferencesKullanimiState
    extends State<SharefPreferencesKullanimi> {
  var _secilenCinsiyet = Cinsiyet.KADIN;
  List<String> _secilenRenkler = [];
  var _ogrenciMi = false;
  // bu alttak, tanımlamalar doğrudur tüm sınıfları üst sınıf olan LocalStorageService sınıfı olarak tanımlanabilir.
  final TextEditingController _nameController = TextEditingController();
  final LocalStorageService _preferencesService =
      locator<LocalStorageService>(); 
  //final LocalStorageService _preferencesService = SharedPreferencesServices();
  //final LocalStorageService _preferencesService2 = SecureStorageServices();
  //final LocalStorageService _preferencesService3 = FileStorageServices();

  @override
  void initState() {
    super.initState();
    _verileriOku();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shared Preferences Kullanimi"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Adınızı giriniz",
              ),
            ),
          ),
          for (var item in Renkler.values) _buildCheckboxListTileS(item),
          for (var item in Cinsiyet.values)
            _buildRadioListTiles(describeEnum(item), item),
          SwitchListTile(
              title: Text("Ogrenci miyiz cano?"),
              value: _ogrenciMi,
              onChanged: (bool deger) {
                setState(() {
                  //debugPrint(deger.toString());
                  _ogrenciMi = deger;
                });
              }),
          TextButton(
              onPressed: () {
                var _userInformation = UserInformation(_nameController.text,
                    _secilenCinsiyet, _secilenRenkler, _ogrenciMi);
                _preferencesService.verileriKaydet(_userInformation);
              },
              child: const Text("Kaydet"))
        ],
      ),
    );
  }

  Widget _buildCheckboxListTileS(Renkler renk) {
    return CheckboxListTile(
        title: Text(describeEnum(renk)),
        value: _secilenRenkler.contains(describeEnum(renk)),
        onChanged: (bool? deger) {
          if (deger == false) {
            _secilenRenkler.remove(describeEnum(renk));
          } else {
            _secilenRenkler.add(describeEnum(renk));
          }
          setState(() {
            debugPrint(_secilenRenkler.toString());
          });
        });
  }

  Widget _buildRadioListTiles(String title, Cinsiyet cinsiyet) {
    return RadioListTile(
        title: Text(title),
        value: cinsiyet,
        groupValue: _secilenCinsiyet,
        onChanged: (Cinsiyet? secilmisCinsiyet) {
          setState(() {
            _secilenCinsiyet = secilmisCinsiyet!;
          });
        });
  }

  void _verileriOku() async {
    var info = await _preferencesService.verileriOku();
    _nameController.text = info.isim;
    _secilenCinsiyet = info.cinsiyet;
    _secilenRenkler = info.renkler;
    _ogrenciMi = info.ogrenciMi;
    setState(() {});
  }
}
