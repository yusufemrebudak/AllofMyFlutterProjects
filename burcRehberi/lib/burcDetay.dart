import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

import 'model/burc.dart';

class burcDetay extends StatefulWidget {
  final Burc secilenBurc;
  const burcDetay({required this.secilenBurc, Key? key}) : super(key: key);

  @override
  State<burcDetay> createState() => _burcDetayState();
}

class _burcDetayState extends State<burcDetay> {
  // setState diyip güncelliyeceğimiz alan burasıdır ,
//setState buradaki build metodunu tekrardan çağırıyordu.
  Color AppBarRengi = Colors.transparent;
  late PaletteGenerator _generator;
  void initState() {
    // yalnızca 1 kez çalışır.
    super.initState();
    appBarRenginiBul();
    WidgetsBinding.instance!.addPostFrameCallback((_)=>appBarRenginiBul()); // önce build metodum bir kez çalışsın 
    // appBarRenginiBul fonksyionu beklesin, bir kez ekrana built metodu gösterdikten sonra appBarRenginiBul fonksiyonu
    // çalışsın , bu şekilde kasmasın. Diğer türlü widget widget üstüne binerek built ler çakışabiliyor. 
    // _generator = PaletteGenerator.fromImageProvider(AssetImage(assetname));
  }

  @override
  Widget build(BuildContext context) {
    // bu build tekrar tekrar çalışabiliyor.fakat stateful widget da initstate diye
    // bir alan vardır, bu alan sadece 1 kez çalışıyor
    return Scaffold(
        primary: true,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 250,
              pinned: true,
              backgroundColor: AppBarRengi,
              flexibleSpace: FlexibleSpaceBar(
                title:
                    Text(widget.secilenBurc.burcAdi + ' Burcu ve Özellikleri'),
                centerTitle: true,
                background: Image.asset(
                  'assets/images/' + widget.secilenBurc.burcBuyukResim,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.all(8),
                child: SingleChildScrollView(
                    child: Text(
                  widget.secilenBurc.burDetayi,
                  //style: Theme.of(context).textTheme.bodyLarge)
                  style: TextStyle(fontSize: 24),
                )),
              ),
            )
          ],
        ));
  }

  void appBarRenginiBul() async {
    //_generator = await PaletteGenerator.fromImage(Image.asset('assets/images/'widget.secilenBurc.burcBuyukResim));
    _generator = await PaletteGenerator.fromImageProvider(
        AssetImage('assets/images/' + widget.secilenBurc.burcBuyukResim));
    AppBarRengi = _generator.dominantColor!.color;
    setState(
        () {}); // bu her dendiğinde ilgili widgetın built metodu tekrarr çalışıyor
  }
}
