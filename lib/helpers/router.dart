// ignore_for_file: avoid_unnecessary_containers

import 'package:dashui/pages/dashboard.dart';
import 'package:dashui/pages/personal.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/":
      return _getPageRoute(const DashBoard());
    case "/personal":
      return _getPageRoute(const Personal());
    default:
      return _getPageRoute(const DashBoard());
  }
}

PageRoute _getPageRoute(Widget child) {
  return SlideRightRoute(page: child);
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(5, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
