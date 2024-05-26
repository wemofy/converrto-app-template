import 'package:flutter/material.dart';

import '../homescreen.dart';

class Hamburger2 extends StatelessWidget {
  const Hamburger2({super.key, required this.jsonData});

  final Map<String, dynamic> jsonData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hamburger2'),
      ),
      drawer: Drawer(
        child: MenuDrawer(jsonData: jsonData,),
      ),
    );
  }
}
