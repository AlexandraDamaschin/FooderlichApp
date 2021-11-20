import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/navigation/app_router.dart';
import 'package:fooderlich/models/grocery_manager.dart';
import 'models/profile_manager.dart';
import 'themes/fooderlich_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Fooderlich());
}

class Fooderlich extends StatefulWidget {
  const Fooderlich({Key? key}) : super(key: key);
  @override
  _FooderlichState createState() => _FooderlichState();
}

class _FooderlichState extends State<Fooderlich> {
  final groceryManager = GroceryManager();
  final profileManager = ProfileManager();
  final appStateManager = AppStateManager();
  late AppRouter appRouter;

  @override
  void initState() {
    appRouter = AppRouter(
        appStateManager: appStateManager,
        groceryManager: groceryManager,
        profileManager: profileManager);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => groceryManager,
        ),
        ChangeNotifierProvider(
          create: (context) => profileManager,
        ),
        ChangeNotifierProvider(
          create: (context) => appStateManager,
        )
      ],
      child: Consumer<ProfileManager>(
        builder: (context, profileManager, child) {
          ThemeData theme;
          if (profileManager.darkMode) {
            theme = FooderlichTheme.dark();
          } else {
            theme = FooderlichTheme.light();
          }

          return MaterialApp(
            theme: theme,
            title: 'Fooderlich',
            home: Router(routerDelegate: appRouter),
          );
        },
      ),
    );
  }
}
