import 'package:flutter/widgets.dart';
import 'enum_screens.dart';

DeviceScreenType getDeviceType(MediaQueryData mediaQuery) {
  var orientation = mediaQuery.orientation;
  double deviceWidth = mediaQuery.size.width;

  if (deviceWidth >= 900) {
    return DeviceScreenType.Desktop;
  }
  if (deviceWidth >= 600) {
    return DeviceScreenType.Tablet;
  }

  return DeviceScreenType.Mobile;
}
