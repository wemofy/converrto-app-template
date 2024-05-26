import 'package:flutter/material.dart';

import '../homescreen.dart';

class Hamburger5 extends StatelessWidget {
  const Hamburger5({super.key, required this.jsonData});

  final Map<String, dynamic> jsonData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hamburger5'),
      ),
      drawer: Drawer(
        child: MenuDrawer(jsonData: jsonData,),
      ),
    );
  }
}
