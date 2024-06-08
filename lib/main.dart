import 'dart:convert';
import 'package:converrto/globalfunctions.dart';
import 'package:converrto/homescreen.dart';
import 'package:converrto/onboardingscreens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'onboardingscreens/onboardingscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String jsonData = await loadJsonData();
  runApp(MyApp(jsonData: jsonDecode(jsonData)));
}

Future<String> loadJsonData() async {
  return await rootBundle.loadString('assets/config.json');
}

class MyApp extends StatefulWidget {
  final Map<String, dynamic> jsonData;
  const MyApp({super.key, required this.jsonData});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: buildThemeDataFromConfig(),
      home: widget.jsonData['config']['splashscreen']['active']
          ? SplashScreen(
        jsonData: widget.jsonData,
        options: widget.jsonData['config']['splashscreen']['options'],
      )
          : widget.jsonData['config']['onboardingscreen']['active']
          ? OnboardingScreen(
        jsonData: widget.jsonData,
        onboardingoptions: widget.jsonData['config']
        ['onboardingscreen'],
      )
          : HomeScreen(
        jsonData: widget.jsonData,
        navdata: widget.jsonData['config']['bottom_navigation'],
      ),
    );
  }

  ThemeData buildThemeDataFromConfig() {
    Map<String, dynamic> config = widget.jsonData;
    print(config['config']['splashscreen']['options']['bgcolor']);
    Map<String, dynamic> splashConfig =
    config['config']['splashscreen']['options'];
    return ThemeData(
        scaffoldBackgroundColor: config['config']['extra_options']['active']
            ? hexToColor(config['config']['extra_options']['options']['app_bgcolor']):Color(0xFFFFFFFF),
        primaryColor: getColor(splashConfig['bgcolor']),
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              size: 30,
              color: hexToColor(
                  config['config']['appbar']['options']['app_title_color']),
            ),
            centerTitle: config['config']['appbar']['options']['centertitle'],
            color: hexToColor(
                widget.jsonData['config']['appbar']['options']['bgcolor']),
            titleTextStyle: TextStyle(
              color: hexToColor(
                  config['config']['appbar']['options']['app_title_color']),
              fontSize: double.parse(
                  config['config']['appbar']['options']['title_fontsize']),
              fontFamily: config['config']['appbar']['options']['title_font_family'],
              fontWeight: getFontWeight(config['config']['appbar']['options']['title_font_weight']),

            )),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            fontFamily: 'axiforma',
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            fontFamily: 'axiforma',
          ),
          titleSmall: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            fontFamily: 'axiforma',
          ),
          labelLarge: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            fontFamily: 'axiforma',
          ),
          labelMedium: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            fontFamily: 'axiforma',
          ),
          labelSmall: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            fontFamily: 'axiforma',
          ),
          bodyLarge: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
            fontFamily: 'axiforma',
          ),
          bodyMedium: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            fontFamily: 'axiforma',
          ),
          bodySmall: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            fontFamily: 'axiforma',
          ),
        )
      // Add more theme properties as needed
    );
  }

  Color getColor(String colorString) {
    return Color(int.parse(colorString.substring(1), radix: 16));
  }
}
