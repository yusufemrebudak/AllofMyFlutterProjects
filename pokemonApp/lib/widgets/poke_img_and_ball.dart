import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_app/constant/ui_helper.dart';

import '../model/pokemon_model.dart';

class PokeImageAndBall extends StatelessWidget {
  final PokemonModel pokemon;
  const PokeImageAndBall({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String pokeballImageUrl = 'images/pokeball.png';

    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Image.asset(
            pokeballImageUrl,
            width: UIHelper.calculatePokeandBallSize(),
            height: UIHelper.calculatePokeandBallSize(),
            fit: BoxFit.fitHeight,
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Hero(
            tag: pokemon.id!,
            child: CachedNetworkImage(
                errorWidget: (context, url, error) => Icon(Icons.error),
                imageUrl: pokemon.img!,
                width: UIHelper.calculatePokeandBallSize(),
                height: UIHelper.calculatePokeandBallSize(),
                fit: BoxFit.fitHeight,
                placeholder: (context, url) => const CircularProgressIndicator(
                      color: Colors.black,
                    )),
          ),
        ),
      ],
    );
  }
}
