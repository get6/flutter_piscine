import 'package:flutter/material.dart';
import 'package:subject/custom_widget/pokemon.dart';

class PokemonDetails extends StatelessWidget {
  const PokemonDetails({Key? key, required this.pokemon}) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    const double px = 8;
    const textStyle = TextStyle(color: Colors.white);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: px * 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(px * 4),
            child: Center(
              child: CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(pokemon.imageURL),
              ),
            ),
          ),
          const Divider(thickness: 2),
          const SizedBox(height: px * 2),
          Text(
            'Name',
            style: textStyle.copyWith(fontSize: px * 4),
          ),
          Text(
            pokemon.name,
            style: textStyle.copyWith(fontSize: px * 7),
          ),
          Text(
            'Level',
            style: textStyle.copyWith(fontSize: px * 4),
          ),
          Text(
            'Lv.${pokemon.level}',
            style: textStyle.copyWith(fontSize: px * 7),
          ),
          const SizedBox(height: px * 2),
          ...pokemon.skills.map(
            (skill) => Row(
              children: [
                const Icon(Icons.check_circle_outline),
                const SizedBox(width: px),
                Text(skill),
                const SizedBox(height: px),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
