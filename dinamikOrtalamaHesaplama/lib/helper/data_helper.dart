import 'package:dynamic_ortalama_hesapla/model/ders.dart';
import 'package:flutter/material.dart';

class Datahelper {
  static List<Ders> tumEklenendersler = [];

  static dersEkle(Ders ders) {
    tumEklenendersler.add(ders);
  }

  static List<String> _tumDerslerinHarfleri() {
    return ['AA', 'BA', 'BB', 'CB', 'CC', 'DC', 'DD', 'FD', 'FF'];
  }

  static double ortalamaHesapla() {
    double toplamNot = 0;
    double toplamKredi = 0;
    tumEklenendersler.forEach((element) {
      toplamNot += (element.krediDegeri) * (element.harfDegeri);
      toplamKredi += element.krediDegeri;
    });
    return toplamNot / toplamKredi;
  }

  static double _harfiNotaDonustur(String gelenHarf) {
    switch (gelenHarf) {
      case 'AA':
        return 4;
        break;
      case 'BA':
        return 3.5;
        break;
      case 'BB':
        return 3.0;
        break;
      case 'CB':
        return 2.5;
        break;
      case 'CC':
        return 2;
        break;
      case 'DC':
        return 1.5;
        break;
      case 'DD':
        return 1;
        break;
      case 'FD':
        return 0.5;
        break;
      case 'FF':
        return 0.0;
        break;
      default:
        return 1;
    }
  }

  static List<DropdownMenuItem<double>> tumDerslerinHarfleri() {
    return _tumDerslerinHarfleri()
        .map((e) => DropdownMenuItem(
              child: Text(e),
              value: _harfiNotaDonustur(e),
            ))
        .toList();
  }

  static List<int> _tumKrediler() {
    return List.generate(10, (index) => index + 1);
  }

  static List<DropdownMenuItem<double>> tumDerslerinKredileri() {
    return _tumKrediler()
        .map((e) => DropdownMenuItem(
              child: Text(e.toString()),
              value: e.toDouble(),
            ))
        .toList();
  }
}
