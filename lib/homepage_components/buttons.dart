import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import '../utils/globalfunctions.dart';
import '../webviews/webpage.dart';

class ButtonsCard extends StatelessWidget {
  const ButtonsCard(
      {super.key, required this.jsonData, required this.homedata});

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
            homedata['buttons']['title'],
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
                    ? [1.fr, 1.fr]
                    : [1.fr, 1.fr, 1.fr],
            rowSizes: [
              for (var i = 0; i < homedata['buttons']['buttons_count'] / 2; i++)
                auto,
            ],
            rowGap: 20,
            columnGap: 20,
            children: [
              for (var i = 0; i < homedata['buttons']['buttons_count']; i++)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WebPage(
                                jsonData: jsonData,
                                url: homedata['buttons']['buttons_array'][i]
                                    ['url'],
                                title: homedata['buttons']['buttons_array'][i]
                                    ['title'],
                              )),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? (MediaQuery.sizeOf(context).width - 60) / 2
                        : (MediaQuery.sizeOf(context).width - 80) / 3,
                    decoration: BoxDecoration(
                        color: hexToColor(homedata['buttons']['buttons_color']),
                        borderRadius: BorderRadius.circular(23),
                        border: Border.all(
                            width: 1,
                            color: hexToColor(
                                homedata['buttons']['border_color']))),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text(
                        homedata['buttons']['buttons_array'][i]['title'],
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: hexToColor(
                                  homedata['buttons']['title_color']),
                              fontSize: 14,
                            ),
                        // style: TextStyle(
                        //   color: hexToColor(
                        //       widget.homedata['tab']['title_color']),
                        //   fontSize: 14,
                        // ),
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
