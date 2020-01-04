import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:state_management/locator.dart';
import 'package:state_management/ui/my_app.dart';

void main() {
  runApp(MyApp(init: (context) => setupLocator()));
}
