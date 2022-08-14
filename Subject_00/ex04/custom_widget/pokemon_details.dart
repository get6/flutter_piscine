import 'package:flutter/material.dart';

class PokemonDetails extends StatelessWidget {
  const PokemonDetails({Key? key, required this.imageURL}) : super(key: key);

  final String imageURL;
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
                backgroundImage: NetworkImage(imageURL),
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
            'Pikachu',
            style: textStyle.copyWith(fontSize: px * 7),
          ),
          Text(
            'Level',
            style: textStyle.copyWith(fontSize: px * 4),
          ),
          Text(
            'Lv.4',
            style: textStyle.copyWith(fontSize: px * 7),
          ),
          const SizedBox(height: px * 2),
          Row(
            children: const [
              Icon(Icons.check_circle_outline),
              SizedBox(width: px),
              Text('Body Blow')
            ],
          ),
          const SizedBox(height: px),
          Row(
            children: const [
              Icon(Icons.check_circle_outline),
              SizedBox(width: px),
              Text('Electric Shocks')
            ],
          ),
          const SizedBox(height: px),
          Row(
            children: const [
              Icon(Icons.check_circle_outline),
              SizedBox(width: px),
              Text('Electro Ball')
            ],
          ),
        ],
      ),
    );
  }
}
