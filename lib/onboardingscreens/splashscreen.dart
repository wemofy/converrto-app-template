import 'package:converrto/icon.dart';
import 'package:converrto/globalfunctions.dart';
import 'package:converrto/homescreen.dart';
import 'package:converrto/onboardingscreens/onboardingscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen(
      {super.key, required this.jsonData, required this.options});

  final Map<String, dynamic> jsonData;
  final Map<String, dynamic> options;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate initialization delay
    Future.delayed(Duration(seconds: widget.options['duration']), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                widget.jsonData['config']['onboardingscreen']['active']
                    ? OnboardingScreen(
                        jsonData: widget.jsonData,
                        onboardingoptions: widget.jsonData['config']
                            ['onboardingscreen'],
                      )
                    : HomeScreen(
                        jsonData: widget.jsonData,
                        navdata: widget.jsonData['config']['bottom_navigation'],
                      )),
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: hexToColor(widget.options['bgcolor']),
        body: Stack(
          children: <Widget>[
            widget.options['bgimage']['active']
                ? Container(
                    child: widget.options['bgimage']['imageurl']
                            .toLowerCase()
                            .endsWith('.svg')
                        ? (isNetworkUrl(widget.options['bgimage']['imageurl'])
                            ? SvgPicture.network(
                                widget.options['bgimage']['imageurl'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              )
                            : SvgPicture.asset(
                                widget.options['bgimage']['imageurl'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ))
                        : (isNetworkUrl(widget.options['bgimage']['imageurl'])
                            ? Image.network(
                                widget.options['bgimage']['imageurl'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              )
                            : Image.asset(
                                widget.options['bgimage']['imageurl'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              )),
                  )
                : Container(),
            Center(
              child: AppIcon(
                radius: widget.options['centericon_radius'],
                url: widget.options['centericon'],
              ),
            )
          ],
        ));
  }
}
