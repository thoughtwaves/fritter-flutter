import 'package:flutter/material.dart';
import 'package:recipo/models/meal.dart';
import '../widgets/main_drawer.dart';
import './categories_screen.dart';
import './favorites_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> _favorites;

  TabsScreen(this._favorites);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Widget> _tabs;
  
  @override
  initState() {
    super.initState();
    _tabs = [CategoriesScreen(), FavoritesScreen(widget._favorites)];
  }

  int _selectedTabIndex = 0;
  void _selectTab(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //return DefaultTabController(
    //length: 2,
    //initialIndex: 1,
    //child:
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipo'),
        // bottom: TabBar(
        //   tabs: <Widget>[
        //     Tab(
        //       icon: Icon(Icons.category),
        //       child: Text('Categories'),
        //     ),
        //     Tab(
        //       icon: Icon(Icons.star),
        //       child: Text('Favourites'),
        //     )
        //   ],
        //),
      ),
      drawer: MainDrawer(),
      body: _tabs[_selectedTabIndex],
      // TabBarView(
      //   children: <Widget>[CategoriesScreen(), FavoritesScreen()],
      // ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: _selectedTabIndex,
        selectedItemColor: Colors.white,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Favorites'),
          ),
        ],
        onTap: _selectTab,
      ),
    );
  }
}
