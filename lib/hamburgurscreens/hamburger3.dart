import 'package:flutter/material.dart';

import '../homescreen.dart';

class Hamburger3 extends StatelessWidget {
  const Hamburger3({super.key, required this.jsonData});

  final Map<String, dynamic> jsonData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hamburger3'),
      ),
      drawer: Drawer(
        child: MenuDrawer(jsonData: jsonData,),
      ),
    );
  }
}
