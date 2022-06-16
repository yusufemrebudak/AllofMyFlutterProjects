import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'tema_event.dart';
part 'tema_state.dart';

class TemaBloc extends Bloc<TemaEvent, TemaState> {
  TemaBloc()
      : super(UygulamaTemasiState(tema: ThemeData.light(), renk: Colors.blue)) {
    on<TemaEvent>((event, emit) {
      late UygulamaTemasiState uygulamaTemasiState;
      if (event is TemaDegistirEvent) {
        debugPrint(event.havaDurumuKisaltmasi);
        switch (event.havaDurumuKisaltmasi) {
          case "sn": //karlı
          case "sl": //sulu kar
          case "h": //dolu
          case "t": //fırtına
          case "hc": // çok bulutlu , gelen değerler bunlardan biriyse  bir aşağıdaki satır çalışır diğer case ler dede aynı mantık vardır.
            uygulamaTemasiState = UygulamaTemasiState(
                tema: ThemeData(primarySwatch: Colors.blueGrey), renk: Colors.grey);
            break;
          case "hr":
          case "lr":
          case "s":
            uygulamaTemasiState = UygulamaTemasiState(
                tema: ThemeData(primarySwatch: Colors.brown),
                renk: Colors.indigo);
            break;
          case "lc":
          case "c":
            uygulamaTemasiState = UygulamaTemasiState(
                tema: ThemeData(primarySwatch: Colors.orange),
                renk: Colors.yellow);
            break;
          default:
          
        }
        emit(uygulamaTemasiState);
      }
    });
  }
}
