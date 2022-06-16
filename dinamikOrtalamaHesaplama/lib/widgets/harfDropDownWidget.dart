import 'package:dynamic_ortalama_hesapla/Constants/app_constants.dart';
import 'package:dynamic_ortalama_hesapla/helper/data_helper.dart';
import 'package:flutter/material.dart';

class harfDropDownWidget extends StatefulWidget {
  final Function onHarfSecildi;
  harfDropDownWidget({required this.onHarfSecildi, Key? key}) : super(key: key);

  @override
  State<harfDropDownWidget> createState() => _harfDropDownWidgetState();
}

class _harfDropDownWidgetState extends State<harfDropDownWidget> {
  double secilenHarfDegeri = 4;

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
        value: secilenHarfDegeri,
        elevation: 16,
        iconEnabledColor: Sabitler.anaRenk.shade200,
        onChanged: (deger) {
          setState(() {
            secilenHarfDegeri = deger!;
            widget.onHarfSecildi(secilenHarfDegeri);
          });
        },
        underline: Container(),
        items: Datahelper.tumDerslerinHarfleri(),
      ),
    );
  }
}
