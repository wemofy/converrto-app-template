import 'package:converrto/webpage.dart';
import 'package:flutter/material.dart';

import 'globalfunctions.dart';
import 'imageloader.dart';

class GridViewScreen extends StatelessWidget {
  const GridViewScreen(
      {super.key,
      required this.jsonData,
      required this.homedata,
      required this.type});

  final Map<String, dynamic> jsonData;
  final Map<String, dynamic> homedata;
  final String type;

  @override
  Widget build(BuildContext context) {
    if (type == "cards") {
      return homedata['cards']['active']
          ? GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 3
                          : 5,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  mainAxisExtent: 130),
              padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
              shrinkWrap: true,
              itemCount: homedata['cards']['cards_count'],
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WebPage(
                                jsonData: jsonData,
                                url: homedata['cards']['cards_array'][index]['url'],
                                title: homedata['cards']['cards_array'][index]
                                    ['title'],
                              )),
                    );
                  },
                  child: Container(
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
                                  url: homedata['cards']['cards_array'][index]
                                      ['bgimage'],
                                )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            homedata['cards']['cards_array'][index]['title'],
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
                );
              },
            )
          : Container();
    }
    if (type == "minicards") {
      return homedata['minicards']['active']
          ? Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              child: Container(
                height: 92.0 *
                        ((homedata['minicards']['minicards_count'] /
                                (MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? 4
                                    : 6))
                            .ceil()) +
                    20,
                decoration: BoxDecoration(
                    color: hexToColor(homedata['minicards']['bgcolor']),
                    borderRadius: BorderRadius.circular(0),
                    border: Border.all(
                        width: 1,
                        color:
                            hexToColor(homedata['minicards']['border_color']))),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 4
                          : 6,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      mainAxisExtent: 90),
                  padding: const EdgeInsets.all(10),
                  shrinkWrap: true,
                  itemCount: homedata['minicards']['minicards_count'],
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WebPage(
                                    jsonData: jsonData,
                                    url: homedata['minicards']['minicards_array']
                                        [index]['url'],
                                    title: homedata['minicards']['minicards_array']
                                        [index]['title'],
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
                                      [index]['bgimage'],
                                ),
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            homedata['minicards']['minicards_array'][index]
                                ['title'],
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
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
                    );
                  },
                ),
              ),
            )
          : Container();
    }
    if (type == "buttons") {
      return homedata['buttons']['active']
          ? GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 2
                          : 4,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  mainAxisExtent: 46),
              padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
              shrinkWrap: true,
              itemCount: homedata['buttons']['buttons_count'],
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WebPage(
                                jsonData: jsonData,
                                url: homedata['buttons']['buttons_array'][index]
                                    ['url'],
                                title: homedata['buttons']['buttons_array']
                                    [index]['title'],
                              )),
                    );
                  },
                  child: Container(
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
                        homedata['buttons']['buttons_array'][index]['title'],
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
                );
              },
            )
          : Container();
    }
    if (type == "divider") {
      return Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Container(
          height: 4,
          decoration: BoxDecoration(
            color: hexToColor(homedata["buttons"]['partition_color']),
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      );
    }
    return Container();
  }
}
