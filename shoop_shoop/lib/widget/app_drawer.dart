import 'package:flutter/material.dart';
import '../screen/order_screen.dart';
import '../screen/user_products_screen.dart';
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer( child: Column(
      children: <Widget>[
        AppBar(title: Text('Hello!'),
        automaticallyImplyLeading: false,),
        Divider(),
        ListTile(leading: Icon(Icons.shop),
        title: Text('Shoop Shoop'),
        onTap: () {
          Navigator.of(context).pushReplacementNamed('/');
        },),
        Divider(),
        ListTile(leading: Icon(Icons.payment),
        title: Text('Orders'),
        onTap: () {
          Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
        },),
         Divider(),
        ListTile(leading: Icon(Icons.edit),
        title: Text('Manage Products'),
        onTap: () {
          Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
        },)
      ],
    ),
      
    );
  }
}