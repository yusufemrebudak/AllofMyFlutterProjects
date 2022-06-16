import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokemon_app/constant/constants.dart';
import 'package:pokemon_app/constant/ui_helper.dart';
import 'package:pokemon_app/model/pokemon_model.dart';
import 'package:pokemon_app/pages/detail_page.dart';
import 'package:pokemon_app/widgets/poke_img_and_ball.dart';

class PokeListItem extends StatelessWidget {
  final PokemonModel pokemon;
  const PokeListItem({required this.pokemon, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailPage(pokemon: pokemon),
          ));
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.w)),
          elevation: 4,
          shadowColor: Colors.white,
          color: UIHelper.getColorFromType(pokemon.type![0]),
          child: Padding(
            padding: UIHelper.getDefaultPadding(),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pokemon.name.toString(),
                    style: Constants.pokemonNameTextStyle(),
                  ),
                  Chip(
                      label: Text(
                    pokemon.type![0],
                    style: Constants.typeChipTextStyle(),
                  )),
                  Expanded(child: PokeImageAndBall(pokemon: pokemon))
                ]),
          ),
        ),
      ),
    );
  }
}
