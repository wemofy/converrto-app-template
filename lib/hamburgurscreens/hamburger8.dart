import 'package:flutter/material.dart';

import '../homescreen.dart';

class Hamburger8 extends StatelessWidget {
  const Hamburger8({super.key, required this.jsonData});

  final Map<String, dynamic> jsonData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hamburger8'),
      ),
      drawer: Drawer(
        child: MenuDrawer(jsonData: jsonData,),
      ),
    );
  }
}
