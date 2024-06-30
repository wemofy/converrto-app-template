import 'package:converrto/webviews/webpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import '../utils/globalfunctions.dart';
import '../utils/imageloader.dart';

class OfferCardBuilder extends StatelessWidget {
  const OfferCardBuilder(
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
            jsonData['config']['homescreen_options']['options']
            ['offercards']['title'],
            style:const TextStyle(
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
              for (var i = 0;
                  i <
                      jsonData['config']['homescreen_options']['options']
                                  ['offercards']['offercards_array']
                              .length /
                          2;
                  i++)
                auto,
            ],
            rowGap: 20,
            columnGap: 20,
            children: [
              for (var i = 0;
                  i <
                      jsonData['config']['homescreen_options']['options']
                              ['offercards']['offercards_array']
                          .length;
                  i++)
                OfferCard(
                  offercard: jsonData['config']['homescreen_options']['options']
                      ['offercards'],
                  carddata: jsonData['config']['homescreen_options']['options']
                      ['offercards']['offercards_array'][i],
                  jsonData: jsonData,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class OfferCard extends StatelessWidget {
  const OfferCard(
      {super.key,
      required this.offercard,
      required this.carddata,
      required this.jsonData});

  final Map<String, dynamic> offercard;
  final Map<String, dynamic> carddata;
  final Map<String, dynamic> jsonData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebPage(
                    jsonData: jsonData,
                    url: carddata['url'],
                    title: carddata['title'],
                  )),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            color: hexToColor(offercard['bgcolor']),
            borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: hexToColor(offercard['image_border_color']),
                          width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ImageLoader(
                        url: carddata['bgimage'],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    carddata['title'],
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                      color: hexToColor(offercard['title_color']),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    carddata['subtitle'],
                    style: TextStyle(
                      color: hexToColor(offercard['subtitle_color']),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  carddata['price']['active']
                      ? Text.rich(
                          TextSpan(
                            text: '',
                            children: <TextSpan>[
                              TextSpan(
                                  text: '\$3.99 ',
                                  style: TextStyle(
                                    color: hexToColor(offercard['title_color']),
                                  )),
                              TextSpan(
                                text: '\$8.99',
                                style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      hexToColor(offercard['subtitle_color']),
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  carddata['offer']['active']
                      ? const SizedBox(
                          height: 40,
                        )
                      : Container(),
                ],
              ),
            ),
            carddata['discount']['active']
                ? Container(
                    height: 35,
                    width: 80,
                    decoration: BoxDecoration(
                      color:
                          hexToColor(carddata['discount']['options']['color']),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    child: Center(
                      child: Text(
                        carddata['discount']['options']['text'],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: hexToColor(offercard['offer_text_color']),
                        ),
                      ),
                    ),
                  )
                : Container(),
            carddata['offer']['active']
                ? Positioned(
                    bottom: 0,
                    width: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? (MediaQuery.sizeOf(context).width - 60) / 2
                        : (MediaQuery.sizeOf(context).width - 80) / 3,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color:
                            hexToColor(carddata['offer']['options']['color']),
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                      ),
                      child: Center(
                        child: Text(
                          carddata['offer']['options']['text'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: hexToColor(offercard['offer_text_color']),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
