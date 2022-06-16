import 'package:dynamic_ortalama_hesapla/Constants/app_constants.dart';
import 'package:dynamic_ortalama_hesapla/helper/data_helper.dart';
import 'package:flutter/material.dart';

class krediDrowDownWidget extends StatefulWidget {
  final Function onKrediSecildi;

  krediDrowDownWidget({required this.onKrediSecildi, Key? key})
      : super(key: key);

  @override
  State<krediDrowDownWidget> createState() => _krediDrowDownWidgetState();
}

class _krediDrowDownWidgetState extends State<krediDrowDownWidget> {
  double secilenKrediDegeri = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: Sabitler.dropDownPadding,
      decoration: BoxDecoration(
        color: Sabitler.anaRenk.shade100.withOpacity(0.3),
        borderRadius: Sabitler.borderRadius,
      ),
      child: DropdownButton<double>(
        value: secilenKrediDegeri,
        elevation: 16,
        iconEnabledColor: Sabitler.anaRenk.shade200,
        onChanged: (deger) {
          setState(() {
            secilenKrediDegeri = deger!;
            widget.onKrediSecildi(secilenKrediDegeri);
          });
        },
        underline: Container(),
        items: Datahelper.tumDerslerinKredileri(),
      ),
    );
  }
}
