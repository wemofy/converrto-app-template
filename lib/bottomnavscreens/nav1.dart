import 'package:converrto/globalfunctions.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Nav1 extends StatefulWidget {
  const Nav1({super.key, required this.url, required this.jsonData});

  final String url;
  final Map<String, dynamic> jsonData;

  @override
  State<Nav1> createState() => _Nav1State();
}

class _Nav1State extends State<Nav1> {
  bool _isLoading = true;
  var loadingPercentage = 0;
  String _errorMessage = '';
  late final WebViewController controller;

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
            setState(() {
              _isLoading = false;
              widget.jsonData['config']['extra_options']['active']?
              _errorMessage = widget.jsonData['config']['extra_options']
                      ['options']['default_error_message'] +
                  "\n" +
                  widget.jsonData['config']['extra_options']['options']
                      ['try_again_text']:_errorMessage='';
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                    color: hexToColor(widget.jsonData['config']['extra_options']
                        ['options']['circular_loader']['color']),
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
                      borderRadius: BorderRadius.only(
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
              SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
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
                      color: hexToColor(widget.jsonData['config']['backbutton']
                          ['icon_color']),
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
    );
  }
}
