import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_storage/services/local_storage.servicesABS.dart';
import 'package:path_provider/path_provider.dart';

import '../model/models.dart';

class FileStorageServices implements LocalStorageService{
  _getFilePath() async {
    var filePath = await getApplicationDocumentsDirectory();
    debugPrint(filePath.path);
    return filePath.path;
  }

  FileStorageServices() {
    _createFile();
  }

  Future<File> _createFile() async {
    var file = File(await _getFilePath() + '/info.txt');
    return file;
  }

  @override
  Future<void> verileriKaydet(UserInformation userInformation) async {
    var file = await _createFile();
    await file.writeAsString(jsonEncode(userInformation));
  }

  @override
  Future<UserInformation> verileriOku() async {
    try {
      var file = await _createFile();
      var dosyaStringIcerik = await file.readAsString();
      var json = jsonDecode(dosyaStringIcerik);
      return UserInformation.fromJson(json);
    } catch (e) {
      debugPrint(e.toString());
    }
    return UserInformation('', Cinsiyet.KADIN, [], false);
  }
}
