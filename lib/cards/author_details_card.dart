import 'package:flutter/material.dart';
import 'package:fooderlich/themes/fooderlich_theme.dart';
import 'circle_image.dart';

class AuthorCardDetails extends StatefulWidget {
  final String authorName;
  final String title;
  final ImageProvider? imageProvider;

  const AuthorCardDetails({
    Key? key,
    required this.authorName,
    required this.title,
    this.imageProvider,
  }) : super(key: key);

  @override
  State<AuthorCardDetails> createState() => _AuthorCardDetailsState();
}

class _AuthorCardDetailsState extends State<AuthorCardDetails> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleImage(
                imageProvider: widget.imageProvider,
                imageRadius: 28,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.authorName,
                    style: FooderlichTheme.lightTextTheme.headline3,
                  ),
                  Text(
                    widget.title,
                    style: FooderlichTheme.lightTextTheme.headline3,
                  )
                ],
              ),
            ],
          ),
          IconButton(
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
              iconSize: 30,
              color: Colors.red[400],
              onPressed: () {
                const snackBar = SnackBar(content: Text('Favorite Pressed'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                isFavorite = !isFavorite;
              }),
        ],
      ),
    );
  }
}
