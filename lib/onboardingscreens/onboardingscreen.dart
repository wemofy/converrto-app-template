import 'package:converrto/globalfunctions.dart';
import 'package:converrto/homescreen.dart';
import 'package:converrto/onboardingscreens/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen(
      {super.key, required this.jsonData, required this.onboardingoptions});

  final Map<String, dynamic> jsonData;
  final Map<String, dynamic> onboardingoptions;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexToColor(widget.onboardingoptions['options']['screen_options']['bgcolor']),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 80),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: widget.onboardingoptions['options']['screen_options']['screen_count'],
                  controller: _pageController,
                  itemBuilder: (context, index) => OnboardContent(
                    title: widget.onboardingoptions['options']['screens_config'][index]['title'],
                    description: widget.onboardingoptions['options']['screens_config'][index]
                        ['description'],
                    imagepath: widget.onboardingoptions['options']['screens_config'][index]
                        ['bgimage'],
                    scaleh: widget.onboardingoptions['options']['screens_config'][index]
                        ['height_scale_ofimage'],
                    scalew: widget.onboardingoptions['options']['screens_config'][index]
                        ['width_scale_ofimage'],
                    bradius: widget.onboardingoptions['options']['screens_config'][index]
                        ['border_radius_ofimage'],
                    titlecolor: widget.onboardingoptions['options']['screens_config'][index]
                        ['titlecolor'],
                    desciptioncolor: widget.onboardingoptions['options']['screens_config'][index]
                    ['descriptioncolor'],
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomButton(
                    press: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(
                            jsonData: widget.jsonData,
                            navdata: widget.jsonData['config']
                                ['bottom_navigation'],
                          ),
                        ),
                      );
                    },
                    buttonname: "Skip",
                    color: widget.onboardingoptions['options']['screen_options']['button_color'],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                    child: SmoothPageIndicator(
                      controller: _pageController, // PageController
                      count: widget.onboardingoptions['options']['screen_options']['screen_count'],
                      effect: ScaleEffect(
                        spacing: 9.0,
                        scale: 1.5,
                        radius: widget.onboardingoptions['options']['screen_options']['squaredot']?2.0:5.0,
                        dotWidth: 10.0,
                        dotHeight: 10.0,
                        strokeWidth: 10,
                        dotColor:
                            hexToColor(widget.onboardingoptions['options']['screen_options']['dot_color']),
                        activeDotColor: hexToColor(
                            widget.onboardingoptions['options']['screen_options']['active_dot_color']),
                      ),
                    ),
                  ),
                  const Spacer(),
                  CustomButton(
                    press: () {
                      _pageController.page !=
                              widget.onboardingoptions['options']['screen_options']['screen_count'] - 1
                          ? _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            )
                          : Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                  jsonData: widget.jsonData,
                                  navdata: widget.jsonData['config']
                                      ['bottom_navigation'],
                                ),
                              ),
                            );
                    },
                    buttonname: "Next",
                    color: widget.onboardingoptions['options']['screen_options']['button_color'],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardContent extends StatelessWidget {
  const OnboardContent(
      {super.key,
      required this.imagepath,
      required this.title,
      required this.description,
      required this.scaleh,
      required this.scalew,
      required this.bradius,
      required this.titlecolor,
      required this.desciptioncolor});

  final String title, description, imagepath;

  final double scaleh;
  final double scalew;
  final double bradius;
  final String titlecolor;
  final String desciptioncolor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(
          flex: 10,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.55 * scaleh,
          width: MediaQuery.of(context).size.width * 0.8 * scalew,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(bradius),
            child: imagepath.toLowerCase().endsWith('.svg')
                ? (isNetworkUrl(imagepath)
                ? SvgPicture.network(
              imagepath,
              fit: BoxFit.cover,
            )
                : SvgPicture.asset(
              imagepath,
              fit: BoxFit.cover,
            ))
                : (isNetworkUrl(imagepath)
                ? Image.network(
              imagepath,
              fit: BoxFit.cover,
            )
                : Image.asset(
              imagepath,
              fit: BoxFit.cover,
            )),
          )
        ),
        const Spacer(
          flex: 6,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: hexToColor(titlecolor),
              ),
          textAlign: TextAlign.center,
        ),
        const Spacer(
          flex: 2,
        ),
        Text(
          description,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: hexToColor(desciptioncolor),
              ),
          textAlign: TextAlign.center,
        ),
        const Spacer(
          flex: 4,
        ),
      ],
    );
  }
}
