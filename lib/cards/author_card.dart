import 'package:flutter/material.dart';
import 'package:fooderlich/themes/fooderlich_theme.dart';

import 'author_details_card.dart';

class AuthorCard extends StatelessWidget {
  const AuthorCard({Key? key}) : super(key: key);

  final String description = 'Smoothies';
  final String recipe = 'Recipe';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: const EdgeInsets.all(16),
          constraints: const BoxConstraints.expand(width: 350, height: 450),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/latte.png'), fit: BoxFit.cover),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Column(
            children: [
              const AuthorCardDetails(
                authorName: 'Alexandra Damaschin',
                title: 'Coffee lover',
                imageProvider: AssetImage('assets/author.jpg'),
              ),
              Expanded(
                  child: Stack(
                children: [
                  Positioned(
                    child: Text(
                      description,
                      style: FooderlichTheme.lightTextTheme.headline1,
                    ),
                    bottom: 16,
                    right: 16,
                  ),
                  Positioned(
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        recipe,
                        style: FooderlichTheme.lightTextTheme.headline1,
                      ),
                    ),
                    bottom: 70,
                    left: 16,
                  )
                ],
              )),
            ],
          )),
    );
  }
}
