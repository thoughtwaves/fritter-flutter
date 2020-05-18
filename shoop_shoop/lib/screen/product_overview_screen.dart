import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoop_shoop/widget/app_drawer.dart';
import './cart_screen.dart';
import '../provider/cart_provider.dart';
import '../provider/products_provider.dart';
import '../widget/badge.dart';
import '../widget/products_grid.dart';

enum FilterOptions { Favorites, All }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavorties = false;

  @override
  Widget build(BuildContext context) {
    final _products = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Shoop Shoop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions option) {
              setState(() {
                if (option == FilterOptions.Favorites) {
                  _showFavorties = true;
                } else
                  _showFavorties = false;
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text('Favorites'), value: FilterOptions.Favorites),
              PopupMenuItem(child: Text('All'), value: FilterOptions.All)
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, child) => Badge(
              child: child,
              value: cart.count.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showFavorties),
    );
  }
}
