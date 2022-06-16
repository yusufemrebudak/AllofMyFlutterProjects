import 'package:burc_rehberi/burcDetay.dart';
import 'package:flutter/material.dart';

import 'model/burc.dart';

// listemin her bir elemanını ele alacak bir widget olacaktır.
class burcItem extends StatelessWidget {
  final Burc listelenenBurc;
  const burcItem({required this.listelenenBurc, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var myTextStyle = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) =>
              //         burcDetay(secilenBurc: listelenenBurc)));
              Navigator.pushNamed(context, '/burcDetay',
                  arguments: listelenenBurc);
            },
            leading: Image.asset(
              "assets/images/" + listelenenBurc.burcKucukResim,
            ),
            title: Text(
              listelenenBurc.burcAdi,
              style: myTextStyle.headline5,
            ),
            subtitle:
                Text(listelenenBurc.burcTarihi, style: myTextStyle.subtitle1),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.pink,
            ),
          ),
        ),
      ),
    );
  }
}
