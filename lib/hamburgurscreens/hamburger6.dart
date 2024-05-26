import 'package:flutter/material.dart';

import '../homescreen.dart';

class Hamburger6 extends StatelessWidget {
  const Hamburger6({super.key, required this.jsonData});

  final Map<String, dynamic> jsonData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hamburger6'),
      ),
      drawer: Drawer(
        child: MenuDrawer(jsonData: jsonData,),
      ),
    );
  }
}
