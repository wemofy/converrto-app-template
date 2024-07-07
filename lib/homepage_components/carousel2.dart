import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../utils/globalfunctions.dart';
import '../utils/imageloader.dart';
import '../webviews/webpage.dart';

class CaroselCard_Custom extends StatefulWidget {
  const CaroselCard_Custom(
      {super.key, required this.jsonData, required this.homedata});

  final Map<String, dynamic> jsonData;
  final Map<String, dynamic> homedata;

  @override
  State<CaroselCard_Custom> createState() => _CaroselCardState();
}

class _CaroselCardState extends State<CaroselCard_Custom> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
            options: CarouselOptions(
              autoPlay: widget.homedata['carousel_custom']['custum_options']['autoplay'],
              aspectRatio: widget.homedata['carousel_custom']['custum_options']['ratio'],
              viewportFraction: 0.8,
              initialPage: currentIndex,
              enableInfiniteScroll:  widget.homedata['carousel_custom']['custum_options']['infinite_scroll'],
              padEnds: true,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
            items: List.generate(
              widget.homedata['carousel_custom']['carousel_count'],
                  (index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebPage(
                          jsonData: widget.jsonData,
                          url: widget.homedata['carousel_custom']
                          ['carousel_array'][index]['url'],
                          title: widget.homedata['carousel_custom']
                          ['carousel_array'][index]['title'],
                        )),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                            width: 1,
                            color: hexToColor(widget.homedata
                            ['carousel_custom']['border_color'])),
                        color: Colors.transparent,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: ImageLoader(
                            url: widget.homedata['carousel_custom']
                            ['carousel_array'][index]['bgimage']),
                      ),
                    ),
                  ),
                ),
              ),
            )),
        const SizedBox(
          height: 5,
        ),
        widget.homedata['carousel_custom']['custum_options']['dot_indicator']?DotsIndicator(
          decorator: DotsDecorator(
            size: const Size.square(12),
            activeSize: const Size.square(12),
            spacing: const EdgeInsets.fromLTRB(2.5, 0, 2.5, 0),
            color:
            hexToColor(widget.homedata['carousel_custom']['dot_color']),
            activeColor: hexToColor(
                widget.homedata['carousel_custom']['active_dot_color']),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.homedata
                ['carousel_custom']['squaredot']
                    ? 2.0
                    : 6.0)),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.homedata
                ['carousel_custom']['squaredot']
                    ? 2.0
                    : 6.0)),
          ),
          dotsCount: widget.homedata['carousel_custom']['carousel_count'],
          position: currentIndex,
        ):Container(),
      ],
    );
  }
}
