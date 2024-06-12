import 'package:carousel_slider/carousel_slider.dart';
import 'package:converrto/globalfunctions.dart';
import 'package:converrto/gridview_screen.dart';
import 'package:converrto/imageloader.dart';
import 'package:converrto/webpage.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.jsonData, required this.homedata});

  final Map<String, dynamic> jsonData;
  final Map<String, dynamic> homedata;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          widget.homedata['carousel']['active']
              ? CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 2,
                    viewportFraction: 1,
                    initialPage: currentIndex,
                    enableInfiniteScroll: false,
                    padEnds: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                  items: List.generate(
                    widget.homedata['carousel']['carousel_count'],
                    (index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WebPage(
                                    jsonData: widget.jsonData,
                                    url: widget.homedata['carousel']
                                        ['carousel_array'][index]['url'],
                                    title: widget.homedata['carousel']
                                        ['carousel_array'][index]['title'],
                                  )),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                  width: 1,
                                  color: hexToColor(widget.homedata['carousel']
                                      ['border_color'])),
                              color: Colors.transparent,
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: ImageLoader(
                                  url: widget.homedata['carousel']
                                      ['carousel_array'][index]['bgimage']),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ))
              : Container(),
          const SizedBox(
            height: 5,
          ),
          widget.homedata['carousel']['active']
              ? DotsIndicator(
                  decorator: DotsDecorator(
                    size: const Size.square(12),
                    activeSize: const Size.square(12),
                    spacing: const EdgeInsets.fromLTRB(2.5, 0, 2.5, 0),
                    color: hexToColor(widget.homedata['carousel']['dot_color']),
                    activeColor: hexToColor(
                        widget.homedata['carousel']['active_dot_color']),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            widget.homedata['carousel']['squaredot']
                                ? 2.0
                                : 6.0)),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            widget.homedata['carousel']['squaredot']
                                ? 2.0
                                : 6.0)),
                  ),
                  dotsCount: widget.homedata['carousel']['carousel_count'],
                  position: currentIndex,
                )
              : Container(),
          const SizedBox(
            height: 10,
          ),
          widget.homedata['view_order'].length >= 1
              ? GridViewScreen(
                  jsonData: widget.jsonData,
                  homedata: widget.homedata,
                  type: widget.homedata['view_order'][0])
              : Container(),
          widget.homedata['view_order'].length >= 2
              ? GridViewScreen(
                  jsonData: widget.jsonData,
                  homedata: widget.homedata,
                  type: widget.homedata['view_order'][1])
              : Container(),
          widget.homedata['view_order'].length >= 3
              ? GridViewScreen(
                  jsonData: widget.jsonData,
                  homedata: widget.homedata,
                  type: widget.homedata['view_order'][2])
              : Container(),
          widget.homedata['view_order'].length >= 4
              ? GridViewScreen(
                  jsonData: widget.jsonData,
                  homedata: widget.homedata,
                  type: widget.homedata['view_order'][3])
              : Container(),
          widget.homedata['view_order'].length >= 5
              ? GridViewScreen(
                  jsonData: widget.jsonData,
                  homedata: widget.homedata,
                  type: widget.homedata['view_order'][4])
              : Container(),
          widget.homedata['view_order'].length >= 6
              ? GridViewScreen(
                  jsonData: widget.jsonData,
                  homedata: widget.homedata,
                  type: widget.homedata['view_order'][5])
              : Container(),
          widget.homedata['view_order'].length >= 7
              ? GridViewScreen(
              jsonData: widget.jsonData,
              homedata: widget.homedata,
              type: widget.homedata['view_order'][6])
              : Container(),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}
