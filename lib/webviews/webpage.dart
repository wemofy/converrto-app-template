import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utils/globalfunctions.dart';
import '../utils/icon.dart';

class WebPage extends StatefulWidget {
  const WebPage(
      {super.key,
      required this.jsonData,
      required this.url,
      required this.title});

  final Map<String, dynamic> jsonData;
  final String url;
  final String title;

  @override
  State<WebPage> createState() => _Hamburger1State();
}

class _Hamburger1State extends State<WebPage> {
  late final WebViewController controller;
  bool _isLoading = true;
  var loadingPercentage = 0;
  String _errorMessage = '';

  @override
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageFinished: (url) {
            setState(() {
              loadingPercentage = 100;
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            if (kDebugMode) {
              const String redText = '\x1B[31m';
              const String resetText = '\x1B[0m';
              print('${redText}got itsfosfbgdfbgsjnsfngvsfgsfgsfgfgfs'
                  'bdfgdfgdfgfdgdfghdfgghfdghdhtdhdhdthdthdthdth'
                  'dthdthdththdthdhthdthdthdthfthdthdthdthdthtfh'
                  'thtfhfthtdhtfhtfhtfhtdht${resetText}');
              print(error.errorType);
            }
            if(error.errorType==WebResourceErrorType.connect
                || error.errorType==WebResourceErrorType.timeout
            ){
              setState(() {
                _isLoading = false;
                widget.jsonData['config']['extra_options']['active']?
                _errorMessage = widget.jsonData['config']['extra_options']
                ['options']['default_error_message'] +
                    "\n" +
                    widget.jsonData['config']['extra_options']['options']
                    ['try_again_text']:_errorMessage='';
              });
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.jsonData['config']['appbar']['active']
          ? AppBar(
              title: Text(widget.title),
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
      body: Stack(
        children: [
          if (!_errorMessage.isNotEmpty)
            WebViewWidget(
              controller: controller,
            ),
          widget.jsonData['config']['extra_options']['active'] &&
                  widget.jsonData['config']['extra_options']['options']
                      ['circular_loader']['active']
              ? Visibility(
                  visible: loadingPercentage < 100 || _isLoading,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingPercentage / 100.0,
                      color: hexToColor(widget.jsonData['config']
                              ['extra_options']['options']['circular_loader']
                          ['color']),
                    ),
                  ),
                )
              : Container(),
          // LinearProgressIndicator(
          //   value: loadingPercentage / 100.0,
          // ),
          if (_errorMessage.isNotEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          Positioned(
            right: 0,
            bottom: 20,
            child: Column(
              children: [
                widget.jsonData['config']['extra_options']['active'] &&
                        widget.jsonData['config']['extra_options']['options']
                            ['refreshbutton']
                    ? ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                        ),
                        child: Container(
                          width: 50,
                          height: 50,
                          color: hexToColor(
                              widget.jsonData['config']['backbutton']['color']),
                          child: TextButton(
                            child: Icon(
                              Icons.refresh,
                              color: hexToColor(widget.jsonData['config']
                                  ['backbutton']['icon_color']),
                            ),
                            onPressed: () {
                              controller.reload();
                            },
                          ),
                        ),
                      )
                    : Container(),
                const SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                  child: Container(
                    width: 50,
                    height: 50,
                    color: hexToColor(
                        widget.jsonData['config']['backbutton']['color']),
                    child: TextButton(
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: hexToColor(widget.jsonData['config']
                            ['backbutton']['icon_color']),
                      ),
                      onPressed: () async {
                        final messenger = ScaffoldMessenger.of(context);
                        if (await controller.canGoBack()) {
                          await controller.goBack();
                        } else {
                          return;
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
