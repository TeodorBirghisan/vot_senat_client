import 'package:flutter/material.dart';
import 'package:vot_senat_client/layouts/tablet_layout.dart';
import 'package:vot_senat_client/layouts/widescreen_layout.dart';

import 'mobile_layout.dart';

enum ScreenType {
  MOBILE,
  TABLET,
  DESKTOP
}

class MultiscreenLayout extends StatelessWidget {

  final Map<ScreenType, int> _screenBreakpoints = <ScreenType, int>{
    ScreenType.MOBILE: 360,
    ScreenType.TABLET: 768,
    ScreenType.DESKTOP: 1366,
  };


  @override
  Widget build(BuildContext context) {
    int screenWidth = MediaQuery.of(context).size.width as int;

    if (screenWidth < _screenBreakpoints[ScreenType.TABLET]!) {
      return MobileLayout();
    }

    if (screenWidth < _screenBreakpoints[ScreenType.DESKTOP]!) {
      return TabletLayout();
    }

    return WidescreenLayout();
  }
}
