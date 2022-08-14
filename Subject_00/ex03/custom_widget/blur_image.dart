import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

// 이미지 로딩 시간을 위해 transparent_image를 사용했습니다.
class BlurImage extends StatelessWidget {
  const BlurImage({
    Key? key,
    required this.titleImage,
    required this.coverImage,
  }) : super(key: key);

  final String titleImage;
  final String coverImage;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(color: Colors.white);

    return Column(
      children: [
        Image.network(titleImage),
        Center(
          child: Container(
            foregroundDecoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 0.4, 0.6, 1],
              ),
            ),
            child: AspectRatio(
              aspectRatio: 1.0 / 1.0,
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: coverImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Title : Squid Game 2021', style: textStyle),
            SizedBox(height: 10),
            Text('Episodes : 1', style: textStyle),
            SizedBox(height: 10),
            Text('Genre : TV Drama', style: textStyle),
            SizedBox(height: 10),
            Text(
                'Plot : Seong Gi-hun, a divorced and indebted chauffeur, is invited to play a series of children’s games for a chance at a large cash prize. Accepting the offer, he is taken to an unknown location where he finds himself among 456 other players who are also deeply in debt. The players are made to wear green tracksuits and are kept under watch at all times by masked guards in pink jumpsuits, with the games overseen by the Front Man, who wears a black mask and black uniform.',
                style: textStyle),
          ],
        )
      ],
    );
  }
}
