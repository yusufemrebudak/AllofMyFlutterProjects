import 'package:dynamic_ortalama_hesapla/Constants/app_constants.dart';
import 'package:dynamic_ortalama_hesapla/helper/data_helper.dart';
import 'package:dynamic_ortalama_hesapla/model/ders.dart';
import 'package:flutter/material.dart';

class DersListesi extends StatelessWidget {
  final Function onDismiss;
  const DersListesi({required this.onDismiss, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Ders> tumDersler = Datahelper.tumEklenendersler;
    return tumDersler.length > 0
        ? ListView.builder(
            itemCount: tumDersler.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.startToEnd,
                onDismissed: (a) {
                  onDismiss(index);
                },
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Card(
                    child: ListTile(
                      title: Text(tumDersler[index].ad),
                      leading: CircleAvatar(
                        backgroundColor: Sabitler.anaRenk,
                        child: Text(((tumDersler[index].harfDegeri) *
                                (tumDersler[index].krediDegeri))
                            .toStringAsFixed(1)),
                      ),
                      subtitle: Text(
                          "${tumDersler[index].krediDegeri} Kredi, Not Değeri:${tumDersler[index].harfDegeri} "),
                    ),
                  ),
                ),
              );
            },
          )
        : Container(
            child: Center(
                child: Text(
              "Lütfen Ders Ekleyin",
              style: Sabitler.baslikStyle,
            )),
          );
  }
}
