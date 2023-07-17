import 'package:flutter/material.dart';
import 'package:traid_admin/app.dart';
import 'package:traid_admin/services/injection_container.dart' as injectc;

void main() {

  injectc.initFeatures();
  runApp(const App());
}
