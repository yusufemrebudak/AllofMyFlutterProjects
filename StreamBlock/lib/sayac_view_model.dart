import 'dart:async';

class SayacViewModel {
  int _sayac = 50;
  final StreamController<int> _controller =
      StreamController.broadcast(); //isimlendirilmiş consturctoru olan
  // broadcast ile üretmek gerek birden fazla yerde dinlemek için
  Stream<int> get sayacStream => _controller.stream;
  Sink get _sink => _controller.sink;

  int init() {
    return _sayac;
  }

  SayacViewModel() {
    _sink.add(_sayac);
    print('sinke ilk değer atandı');
  }
  void arttir() {
    _sink.add(++_sayac);
  }

  void azalt() {
    _sink.add(--_sayac);
  }
}
