import 'package:converrto/home/gridview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../homepage_components/carosel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.jsonData, required this.homedata});

  final Map<String, dynamic> jsonData;
  final Map<String, dynamic> homedata;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          for (var i = 0;
              i < widget.homedata['options']['view_order'].length;
              i++)
            GridViewScreen(
                jsonData: widget.jsonData,
                homedata: widget.homedata['options'],
                type: widget.homedata['options']['view_order'][i]),
        ],
      ),
    );
  }
}
