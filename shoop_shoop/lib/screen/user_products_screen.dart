import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './edit_product_screen.dart';
import '../widget/app_drawer.dart';
import '../widget/user_product_item.dart';
import '../provider/products_provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const String routeName = '/user-products';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context).products;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      drawer: AppDrawer(), 
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: productsData.length,
            itemBuilder: (_, index) => UserProductItem(productsData[index])),
      ),
    );
  }
}
