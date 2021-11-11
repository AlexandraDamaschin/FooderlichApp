import 'package:flutter/material.dart';
import 'package:fooderlich/api/api_service.dart';
import 'package:fooderlich/components/recipes_grid_view.dart';
import '../models/models.dart';

class RecipesScreen extends StatelessWidget {
  final exploreService = ApiService();

  RecipesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: exploreService.getRecipes(),
      builder: (context, AsyncSnapshot<List<SimpleRecipe>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return RecipesGridView(recipes: snapshot.data ?? []);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
