import 'package:dashui/global/controllers.dart';
import 'package:dashui/helpers/router.dart';
import 'package:flutter/material.dart';

Navigator localNavigator() => Navigator(
      key: navigatorController.navigationKey,
      initialRoute: "/",
      onGenerateRoute: generateRoute,
    );
