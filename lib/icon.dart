import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'globalfunctions.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({super.key, required this.radius, required this.url});

  final double radius;
  final String url;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius * 2,
      width: radius * 2,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: url.toLowerCase().endsWith('.svg')
          ? (isNetworkUrl(url)
              ? SvgPicture.network(
                  url,
                  fit: BoxFit.cover,
                )
              : SvgPicture.asset(
                  convertToAssetPath(url),
                  fit: BoxFit.cover,
                ))
          : ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: isNetworkUrl(url)
                  ? Image.network(
                      url,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      url,
                      fit: BoxFit.cover,
                    ),
            ),
    );
  }
}
