import 'package:flutter/material.dart';
import 'package:fooderlich/api/api_service.dart';
import 'package:fooderlich/components/today_recipe_list.dart';
import 'package:fooderlich/models/explore_data.dart';

class ExploreScreen extends StatelessWidget {
  final mockService = ApiService();

  ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mockService.getExploreData(),
      builder: (context, AsyncSnapshot<ExploreData> snapshot) {
        // TODO: Add Nested List Views
        // 4
        if (snapshot.connectionState == ConnectionState.done) {
          final recipes = snapshot.data?.todayRecipes ?? [];
          return TodayRecipeListView(recipes: recipes);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
