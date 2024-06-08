import 'dart:math';

import 'package:converrto/globalfunctions.dart';
import 'package:converrto/homepage.dart';
import 'package:converrto/icon.dart';
import 'package:converrto/nav1.dart';
import 'package:converrto/hamburger1.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.jsonData, required this.navdata});

  final Map<String, dynamic> jsonData;
  final Map<String, dynamic> navdata;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.jsonData['config']['appbar']['active']
          ? AppBar(
              title: Text(
                  widget.jsonData['config']['appbar']['options']['app_title']),
              actions: [
                AppIcon(
                  radius: 28,
                  url: widget.jsonData['config']['appbar']['options']['bgicon'],
                ),
                const SizedBox(
                  width: 30,
                ),
              ],
            )
          : null,
      drawer: widget.jsonData['config']['sidebar']['active']
          ? Drawer(
              child: MenuDrawer(
                jsonData: widget.jsonData,
              ),
            )
          : null,
      body: widget.jsonData['config']['extra_options']['active'] &&
              widget.jsonData['config']['extra_options']['options']
                  ['double_press_exit']
          ? DoubleBackToCloseApp(
              snackBar: SnackBar(
                margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 10.0),
                behavior: SnackBarBehavior.floating,
                content: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    'Tap back again to leave',
                    style: TextStyle(
                        color: hexToColor(widget.jsonData['config']['snackbar']
                            ['text_color']),
                        fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
                backgroundColor:
                    hexToColor(widget.jsonData['config']['snackbar']['color']),
              ),
              child: PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                itemCount:
                    max(widget.navdata['options']['menu_options_count'] + 1, 1),
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return HomePage(
                      jsonData: widget.jsonData,
                      homedata: widget.jsonData['config']['bottom_navigation']
                          ['options']['menu_options'][0]['homescreen_options'],
                    );
                  } else {
                    return Nav1(
                      url: widget.navdata['options']['menu_options'][index]
                          ['url'],
                      jsonData: widget.jsonData,
                    );
                  }
                },
              ),
            )
          : PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              itemCount:
                  max(widget.navdata['options']['menu_options_count'] + 1, 1),
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              itemBuilder: (context, index) {
                if (index == 0) {
                  return HomePage(
                    jsonData: widget.jsonData,
                    homedata: widget.jsonData['config']['bottom_navigation']
                        ['options']['menu_options'][0]['homescreen_options'],
                  );
                } else {
                  return Nav1(
                    url: widget.navdata['options']['menu_options'][index]
                        ['url'],
                    jsonData: widget.jsonData,
                  );
                }
              },
            ),
      bottomNavigationBar: widget.navdata['active']
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor:
                  hexToColor(widget.navdata['options']['bottom_bar_color']),
              items: List.generate(
                widget.navdata['options']['menu_options_count'],
                (index) => BottomNavigationBarItem(
                  icon: isNetworkUrl(widget.navdata['options']['menu_options']
                          [index]['icon'])
                      ? SvgPicture.network(
                          widget.navdata['options']['menu_options'][index]
                              ['icon'],
                          colorFilter: ColorFilter.mode(
                              hexToColor(widget.navdata['options']
                                  ['unselected_item_color']),
                              BlendMode.srcIn),
                          height: 30,
                          width: 30,
                        )
                      : SvgPicture.asset(
                          convertToAssetPath(widget.navdata['options']
                              ['menu_options'][index]['icon']),
                          colorFilter: ColorFilter.mode(
                              hexToColor(widget.navdata['options']
                                  ['unselected_item_color']),
                              BlendMode.srcIn),
                          height: 30,
                          width: 30,
                        ),
                  activeIcon: isNetworkUrl(widget.navdata['options']
                          ['menu_options'][index]['icon'])
                      ? SvgPicture.network(
                          widget.navdata['options']['menu_options'][index]
                              ['icon'],
                          colorFilter: ColorFilter.mode(
                              hexToColor(widget.navdata['options']
                                  ['selected_item_color']),
                              BlendMode.srcIn),
                          height: 30,
                          width: 30,
                        )
                      : SvgPicture.asset(
                          convertToAssetPath(widget.navdata['options']
                              ['menu_options'][index]['icon']),
                          colorFilter: ColorFilter.mode(
                              hexToColor(widget.navdata['options']
                                  ['selected_item_color']),
                              BlendMode.srcIn),
                          height: 30,
                          width: 30,
                        ),
                  label: widget.navdata['options']['menu_options'][index]
                      ['name'],
                ),
              ),
              currentIndex: _selectedIndex,
              selectedLabelStyle: GoogleFonts.dmSans(
                textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              unselectedLabelStyle: GoogleFonts.dmSans(
                textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              selectedItemColor:
                  hexToColor(widget.navdata['options']['selected_item_color']),
              unselectedItemColor: hexToColor(
                  widget.navdata['options']['unselected_item_color']),
              onTap: _onItemTapped,
            )
          : null,
    );
  }
}

class MenuDrawer extends StatefulWidget {
  MenuDrawer({super.key, required this.jsonData});

  final Map<String, dynamic> jsonData;

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

int _selectedIndex = 0;

class _MenuDrawerState extends State<MenuDrawer> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexToColor(
          widget.jsonData['config']['sidebar']['options']['side_bar_color']),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
              child: AppIcon(
                radius: 60,
                url: widget.jsonData['config']['sidebar']['app_icon'],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(
                widget.jsonData['config']['sidebar']['app_name'],
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: hexToColor(
                      widget.jsonData['config']['sidebar']['app_name_color']),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(
                "User id : ${widget.jsonData['config']['sidebar']['app_id']}",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: hexToColor(
                      widget.jsonData['config']['sidebar']['app_id_color']),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            MenuButton(
              press: () {
                _onItemTapped(0);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(
                      jsonData: widget.jsonData,
                      navdata: widget.jsonData['config']['bottom_navigation'],
                    ),
                  ),
                );
              },
              icon: widget.jsonData['config']['sidebar']['options']
                  ['side_options'][0]['icon'],
              title: 'Home',
              is_selected: _selectedIndex == 0,
              selectedcolor: hexToColor(widget.jsonData['config']['sidebar']
                  ['options']['side_bar_item_color']),
              selected_text_color: widget.jsonData['config']['sidebar']
                  ['options']['selected_menubutton_text_color'],
              text_color: widget.jsonData['config']['sidebar']['options']
                  ['menubutton_text_color'],
            ),
            widget.jsonData['config']['sidebar']['options']
                        ['side_options_count'] >
                    0
                ? MenuButton(
                    press: () {
                      _onItemTapped(1);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Hamburger1(
                            jsonData: widget.jsonData,
                            url: widget.jsonData['config']['sidebar']['options']
                                ['side_options'][0]['url'],
                            title: widget.jsonData['config']['sidebar']
                                ['options']['side_options'][0]['name'],
                          ),
                        ),
                      );
                    },
                    icon: widget.jsonData['config']['sidebar']['options']
                        ['side_options'][0]['icon'],
                    title: widget.jsonData['config']['sidebar']['options']
                        ['side_options'][0]['name'],
                    is_selected: _selectedIndex == 1,
                    selectedcolor: hexToColor(widget.jsonData['config']
                        ['sidebar']['options']['side_bar_item_color']),
                    selected_text_color: widget.jsonData['config']['sidebar']
                        ['options']['selected_menubutton_text_color'],
                    text_color: widget.jsonData['config']['sidebar']['options']
                        ['menubutton_text_color'],
                  )
                : Container(),
            widget.jsonData['config']['sidebar']['options']
                        ['side_options_count'] >
                    1
                ? MenuButton(
                    press: () {
                      _onItemTapped(2);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Hamburger1(
                            jsonData: widget.jsonData,
                            url: widget.jsonData['config']['sidebar']['options']
                                ['side_options'][1]['url'],
                            title: widget.jsonData['config']['sidebar']
                                ['options']['side_options'][1]['name'],
                          ),
                        ),
                      );
                    },
                    icon: widget.jsonData['config']['sidebar']['options']
                        ['side_options'][1]['icon'],
                    title: widget.jsonData['config']['sidebar']['options']
                        ['side_options'][1]['name'],
                    is_selected: _selectedIndex == 2,
                    selectedcolor: hexToColor(widget.jsonData['config']
                        ['sidebar']['options']['side_bar_item_color']),
                    selected_text_color: widget.jsonData['config']['sidebar']
                        ['options']['selected_menubutton_text_color'],
                    text_color: widget.jsonData['config']['sidebar']['options']
                        ['menubutton_text_color'],
                  )
                : Container(),
            widget.jsonData['config']['sidebar']['options']
                        ['side_options_count'] >
                    2
                ? MenuButton(
                    press: () {
                      _onItemTapped(3);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Hamburger1(
                            jsonData: widget.jsonData,
                            url: widget.jsonData['config']['sidebar']['options']
                                ['side_options'][2]['url'],
                            title: widget.jsonData['config']['sidebar']
                                ['options']['side_options'][2]['name'],
                          ),
                        ),
                      );
                    },
                    icon: widget.jsonData['config']['sidebar']['options']
                        ['side_options'][2]['icon'],
                    title: widget.jsonData['config']['sidebar']['options']
                        ['side_options'][2]['name'],
                    is_selected: _selectedIndex == 3,
                    selectedcolor: hexToColor(widget.jsonData['config']
                        ['sidebar']['options']['side_bar_item_color']),
                    selected_text_color: widget.jsonData['config']['sidebar']
                        ['options']['selected_menubutton_text_color'],
                    text_color: widget.jsonData['config']['sidebar']['options']
                        ['menubutton_text_color'],
                  )
                : Container(),
            widget.jsonData['config']['sidebar']['options']
                        ['side_options_count'] >
                    3
                ? MenuButton(
                    press: () {
                      _onItemTapped(4);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Hamburger1(
                            jsonData: widget.jsonData,
                            url: widget.jsonData['config']['sidebar']['options']
                                ['side_options'][3]['url'],
                            title: widget.jsonData['config']['sidebar']
                                ['options']['side_options'][3]['name'],
                          ),
                        ),
                      );
                    },
                    icon: widget.jsonData['config']['sidebar']['options']
                        ['side_options'][3]['icon'],
                    title: widget.jsonData['config']['sidebar']['options']
                        ['side_options'][3]['name'],
                    is_selected: _selectedIndex == 4,
                    selectedcolor: hexToColor(widget.jsonData['config']
                        ['sidebar']['options']['side_bar_item_color']),
                    selected_text_color: widget.jsonData['config']['sidebar']
                        ['options']['selected_menubutton_text_color'],
                    text_color: widget.jsonData['config']['sidebar']['options']
                        ['menubutton_text_color'],
                  )
                : Container(),
            widget.jsonData['config']['sidebar']['options']
                        ['side_options_count'] >
                    4
                ? MenuButton(
                    press: () {
                      _onItemTapped(5);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Hamburger1(
                            jsonData: widget.jsonData,
                            url: widget.jsonData['config']['sidebar']['options']
                                ['side_options'][4]['url'],
                            title: widget.jsonData['config']['sidebar']
                                ['options']['side_options'][4]['name'],
                          ),
                        ),
                      );
                    },
                    icon: widget.jsonData['config']['sidebar']['options']
                        ['side_options'][4]['icon'],
                    title: widget.jsonData['config']['sidebar']['options']
                        ['side_options'][4]['name'],
                    is_selected: _selectedIndex == 5,
                    selectedcolor: hexToColor(widget.jsonData['config']
                        ['sidebar']['options']['side_bar_item_color']),
                    selected_text_color: widget.jsonData['config']['sidebar']
                        ['options']['selected_menubutton_text_color'],
                    text_color: widget.jsonData['config']['sidebar']['options']
                        ['menubutton_text_color'],
                  )
                : Container(),
            widget.jsonData['config']['sidebar']['options']
                        ['side_options_count'] >
                    5
                ? MenuButton(
                    press: () {
                      _onItemTapped(6);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Hamburger1(
                            jsonData: widget.jsonData,
                            url: widget.jsonData['config']['sidebar']['options']
                                ['side_options'][5]['url'],
                            title: widget.jsonData['config']['sidebar']
                                ['options']['side_options'][5]['name'],
                          ),
                        ),
                      );
                    },
                    icon: widget.jsonData['config']['sidebar']['options']
                        ['side_options'][5]['icon'],
                    title: widget.jsonData['config']['sidebar']['options']
                        ['side_options'][5]['name'],
                    is_selected: _selectedIndex == 6,
                    selectedcolor: hexToColor(widget.jsonData['config']
                        ['sidebar']['options']['side_bar_item_color']),
                    selected_text_color: widget.jsonData['config']['sidebar']
                        ['options']['selected_menubutton_text_color'],
                    text_color: widget.jsonData['config']['sidebar']['options']
                        ['menubutton_text_color'],
                  )
                : Container(),
            widget.jsonData['config']['sidebar']['options']
                        ['side_options_count'] >
                    6
                ? MenuButton(
                    press: () {
                      _onItemTapped(7);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Hamburger1(
                            jsonData: widget.jsonData,
                            url: widget.jsonData['config']['sidebar']['options']
                                ['side_options'][6]['url'],
                            title: widget.jsonData['config']['sidebar']
                                ['options']['side_options'][6]['name'],
                          ),
                        ),
                      );
                    },
                    icon: widget.jsonData['config']['sidebar']['options']
                        ['side_options'][6]['icon'],
                    title: widget.jsonData['config']['sidebar']['options']
                        ['side_options'][6]['name'],
                    is_selected: _selectedIndex == 7,
                    selectedcolor: hexToColor(widget.jsonData['config']
                        ['sidebar']['options']['side_bar_item_color']),
                    selected_text_color: widget.jsonData['config']['sidebar']
                        ['options']['selected_menubutton_text_color'],
                    text_color: widget.jsonData['config']['sidebar']['options']
                        ['menubutton_text_color'],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton(
      {super.key,
      required this.press,
      required this.icon,
      required this.title,
      required this.is_selected,
      required this.selectedcolor,
      required this.selected_text_color,
      required this.text_color});

  final Color selectedcolor;
  final VoidCallback press;
  final String icon;
  final String title;
  final bool is_selected;
  final String selected_text_color;
  final String text_color;

  @override
  Widget build(BuildContext context) {
    return is_selected
        ? Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 30, 0),
            child: Container(
              decoration: BoxDecoration(
                color: selectedcolor,
                border: Border.all(
                  color: Color(0xFFB99DF7),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: AppIcon(
                        radius: 20,
                        url: icon,
                      )),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                      child: Text(
                        title,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: hexToColor(selected_text_color),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : GestureDetector(
            onTap: press,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 30, 5),
              child: Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: AppIcon(
                        radius: 20,
                        url: icon,
                      )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 8.0),
                      child: Text(
                        title,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: hexToColor(text_color),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
