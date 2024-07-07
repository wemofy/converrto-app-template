import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import '../utils/globalfunctions.dart';
import '../utils/imageloader.dart';
import '../webviews/webpage.dart';

class Cards extends StatelessWidget {
  const Cards({super.key, required this.jsonData, required this.homedata});

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
            homedata['cards']['title'],
            style: const TextStyle(
              fontSize: 24,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 5,
          ),
          LayoutGrid(
            columnSizes:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? [1.fr, 1.fr, 1.fr]
                    : [1.fr, 1.fr, 1.fr, 1.fr],
            rowSizes: [
              for (var i = 0; i < homedata['cards']['cards_count'] / 3; i++)
                auto,
            ],
            rowGap: 20,
            columnGap: 20,
            children: [
              for (var i = 0; i < homedata['cards']['cards_count']; i++)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WebPage(
                                jsonData: jsonData,
                                url: homedata['cards']['cards_array'][i]
                                    ['url'],
                                title: homedata['cards']['cards_array'][i]
                                    ['title'],
                              )),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).orientation ==
                  Orientation.portrait
                  ? (MediaQuery.sizeOf(context).width - 80) / 3
                      : (MediaQuery.sizeOf(context).width - 100) / 4,
                    decoration: BoxDecoration(
                        color: hexToColor(homedata['cards']['cards_color']),
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                            width: 1,
                            color: hexToColor(
                                homedata['cards']['cards_border_color']))),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Container(
                                height: 70,
                                child: ImageLoader(
                                  url: homedata['cards']['cards_array'][i]
                                      ['bgimage'],
                                )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            homedata['cards']['cards_array'][i]['title'],
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: hexToColor(
                                      homedata['cards']['title_color']),
                                  fontSize: 14,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
