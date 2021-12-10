import 'package:flutter/cupertino.dart';
import 'package:vot_senat_client/pages/home_page.dart';
import 'package:vot_senat_client/pages/todo_page.dart';

import 'layouts/multiscreen_layout.dart';

enum RoutesEnum {
  HOME,
  TODO
}

Map<String, Widget Function(BuildContext)> routesMap = {
  RoutesEnum.HOME.toString(): (BuildContext context) => MultiscreenLayout(),
  RoutesEnum.TODO.toString(): (BuildContext context) => TodoPage(),
};