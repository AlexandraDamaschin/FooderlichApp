import 'package:flutter/material.dart';
import 'package:fooderlich/screens/explore_screen.dart';
import 'package:fooderlich/screens/recipes_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int selectedIndex = 0;

  static List<Widget> pages = <Widget>[
    // MainCard(),
    RecipesScreen(),
    ExploreScreen()
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text('Fooderlich', style: Theme.of(context).textTheme.headline6)),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Author'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore')
        ],
      ),
    );
  }
}
