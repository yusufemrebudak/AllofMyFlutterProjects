part of 'tema_bloc.dart';

abstract class TemaState extends Equatable {
  const TemaState();

  @override
  List<Object> get props => [];
}

class UygulamaTemasiState extends TemaState {
  final ThemeData tema;
  final MaterialColor renk;

  const UygulamaTemasiState({required this.tema, required this.renk});
    List<Object> get props => [tema, renk];

}
