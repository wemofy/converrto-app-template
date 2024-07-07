import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import '../utils/globalfunctions.dart';
import '../utils/imageloader.dart';
import '../webviews/webpage.dart';

class MiniCards extends StatelessWidget {
  const MiniCards({super.key, required this.jsonData, required this.homedata});

  final Map<String, dynamic> jsonData;
  final Map<String, dynamic> homedata;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            homedata['minicards']['title'],
            style:const TextStyle(
              fontSize: 24,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
                color: hexToColor(homedata['minicards']['bgcolor']),
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                    width: 1,
                    color:
                    hexToColor(homedata['minicards']['border_color']))),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: LayoutGrid(
                columnSizes:
                MediaQuery
                    .of(context)
                    .orientation == Orientation.portrait
                    ? [1.fr, 1.fr, 1.fr, 1.fr]
                    : [1.fr, 1.fr, 1.fr, 1.fr, 1.fr, 1.fr],
                rowSizes: [
                  for (var i = 0; i <
                      homedata['minicards']['minicards_count'] / 4; i++)
                    auto,
                ],
                rowGap: 20,
                columnGap: 20,
                children: [
                  for (var i = 0; i < homedata['minicards']['minicards_count']; i++)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  WebPage(
                                    jsonData: jsonData,
                                    url: homedata['minicards']
                                    ['minicards_array'][i]['url'],
                                    title: homedata['minicards']
                                    ['minicards_array'][i]['title'],
                                  )),
                        );
                      },
                      child: Column(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                height: 60,
                                width: 60,
                                child: ImageLoader(
                                  url: homedata['minicards']['minicards_array']
                                  [i]['bgimage'],
                                ),
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            homedata['minicards']['minicards_array'][i]
                            ['title'],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: Theme
                                .of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                              color: hexToColor(
                                  homedata['minicards']['title_color']),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

          ),
        ],
      ),
    );
  }
}
