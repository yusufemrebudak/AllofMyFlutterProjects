import 'package:flutter/material.dart';
import 'package:pokemon_app/widgets/app_title.dart';

import '../widgets/pokemon_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder( // orientation değiştiğinde içindekiler tekrardan çalışacak. 
        builder: (context, orientation) =>Column(
          children: [
            AppTitle(),
            Expanded( // column ve rowlar ile çalışırken aklımızda hep expanded ile çalışmak olsun.
              child: PokemonList()
              ),
          ],
        ),
      ),
    );
  }
}
