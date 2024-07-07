import 'package:converrto/homepage_components/buttons.dart';
import 'package:converrto/homepage_components/cards.dart';
import 'package:converrto/homepage_components/carosel.dart';
import 'package:converrto/homepage_components/carousel2.dart';
import 'package:converrto/homepage_components/minicards.dart';
import 'package:converrto/homepage_components/offercard.dart';
import 'package:flutter/material.dart';
import '../homepage_components/minicard_horizental.dart';
import '../utils/globalfunctions.dart';

class GridViewScreen extends StatefulWidget {
  const GridViewScreen(
      {super.key,
      required this.jsonData,
      required this.homedata,
      required this.type});

  final Map<String, dynamic> jsonData;
  final Map<String, dynamic> homedata;
  final String type;

  @override
  State<GridViewScreen> createState() => _GridViewScreenState();
}

class _GridViewScreenState extends State<GridViewScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.type == "minicards_horizental") {
      return widget.homedata['carousel']['active']
          ? MiniCardHorizental(jsonData: widget.jsonData, homedata: widget.homedata)
          : Container();
    }
    if (widget.type == "carousel") {
      return widget.homedata['carousel']['active']
          ? CaroselCard(jsonData: widget.jsonData, homedata: widget.homedata)
          : Container();
    }
    if (widget.type == "carousel_custom") {
      return widget.homedata['carousel_custom']['active']
          ? CaroselCard_Custom(jsonData: widget.jsonData, homedata: widget.homedata)
          : Container();
    }
    if (widget.type == "cards") {
      return widget.homedata['cards']['active']
          ? Cards(jsonData: widget.jsonData, homedata: widget.homedata)
          : Container();
    }
    if (widget.type == "minicards") {
      return widget.homedata['minicards']['active']
          ? MiniCards(jsonData: widget.jsonData, homedata: widget.homedata)
          : Container();
    }
    if (widget.type == "buttons") {
      return widget.homedata['buttons']['active']
          ? ButtonsCard(jsonData: widget.jsonData, homedata: widget.homedata)
          : Container();
    }
    if (widget.type == "offercards") {
      return widget.homedata['offercards']['active']
          ? OfferCardBuilder(
              jsonData: widget.jsonData, homedata: widget.homedata)
          : Container();
    }
    if (widget.type == "divider") {
      return Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Container(
          height: 4,
          decoration: BoxDecoration(
            color: hexToColor(widget.homedata["buttons"]['partition_color']),
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      );
    }
    return Container();
  }
}
