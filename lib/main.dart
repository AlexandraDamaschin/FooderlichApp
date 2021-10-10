import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'themes/fooderlich_theme.dart';

void main() {
  runApp(const Fooderlich());
}

class Fooderlich extends StatelessWidget {
  const Fooderlich({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = FooderlichTheme.dark();

    return MaterialApp(
      theme: theme,
      title: 'Fooderlich',
      home: Scaffold(
        appBar: AppBar(
            title: Text(
          'Fooderlich',
          style: theme.textTheme.headline6,
        )),
        body: Center(
            child: Text(
          'Let\'s get cooking 👩‍🍳',
          style: theme.textTheme.headline1,
        )),
      ),
    );
  }
}
