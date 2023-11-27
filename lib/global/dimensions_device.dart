
import 'package:flutter/material.dart';

double getDeviceWith({context  = BuildContext}) {
  return MediaQuery.of(context).size.width;
}

double getDeviceHeight({context  = BuildContext}) {
  return MediaQuery.of(context).size.height;
}

double getAverageDeviceSize({context  = BuildContext}) {
  return (getDeviceHeight(context: context) + getDeviceWith(context: context)) / 2;
}