import 'package:dashui/responsive/enum_screens.dart';
import 'package:flutter/material.dart';

class SizingInfo {
  final Orientation orientation;
  final DeviceScreenType deviceScreenType;
  final Size screenSize;
  final Size localWidgetSize;

  SizingInfo({
    this.orientation,
    this.deviceScreenType,
    this.screenSize,
    this.localWidgetSize,
  });

  @override
  String toString() {
    return 'Orientation: $orientation \n DeviceType: $deviceScreenType, \n ScreenSize : $screenSize, \n LocalWidgetSize: $localWidgetSize';
  }
}
