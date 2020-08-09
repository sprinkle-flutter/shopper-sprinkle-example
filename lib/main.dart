import 'package:flutter/material.dart';
import 'package:sprinkle/Supervisor.dart';
import 'package:sprinkle/sprinkle.dart';

import 'manager/CartManager.dart';
import 'screen/CartScreen.dart';
import 'manager/CatalogManager.dart';
import 'screen/CatalogScreen.dart';
import 'screen/LoginScreen.dart';

var supervisor = Supervisor()
    .register<CartManager>(() => CartManager())
    .register<CatalogManager>(() => CatalogManager());

void main() {
  runApp(Sprinkle(supervisor: supervisor, child: App()));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.yellow),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/catalog': (context) => CatalogScreen(),
        '/cart': (context) => CartScreen(),
      },
    );
  }
}
