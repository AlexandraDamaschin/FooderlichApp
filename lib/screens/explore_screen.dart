import 'package:flutter/material.dart';
import 'package:fooderlich/api/api_service.dart';
import 'package:fooderlich/components/friend_post_list.dart';
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
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView(
            children: [
              TodayRecipeListView(recipes: snapshot.data?.todayRecipes ?? []),
              const SizedBox(height: 16),
              FriendPostListView(friendPosts: snapshot.data?.friendPosts ?? []),
              Container(
                height: 400,
                color: Colors.green,
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
