import 'package:flutter/cupertino.dart';
import 'package:vot_senat_client/pages/home_page.dart';
import 'package:vot_senat_client/pages/todo_page.dart';

enum RoutesEnum {
  HOME,
  TODO
}

Map<String, Widget Function(BuildContext)> routesMap = {
  RoutesEnum.HOME.toString(): (BuildContext context) => HomePage(),
  RoutesEnum.TODO.toString(): (BuildContext context) => TodoPage(),
};