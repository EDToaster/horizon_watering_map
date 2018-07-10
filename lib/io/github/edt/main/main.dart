import 'package:flutter/material.dart';
import 'package:watering_map/io/github/edt/main/map.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

void main() {
  runApp(new WateringApp());
}

final webview = new FlutterWebviewPlugin();

//void _launch() async {
//  const url = "https://www.google.ca";
//  webview.onUrlChanged.listen((String url) {
//    if (url.contains("hi")) webview.close();
//  });
//  webview.launch(url,
//      rect: new Rect.fromLTWH(
//          10.0, 10.0, MediaQuery.of(context).size.width, 300.0));
//}

class WateringApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Map Example',
      theme: new ThemeData(
        primarySwatch: themeColor,
      ),
      home: new MapPage(),
    );
  }
}

// Generated using Material Design Palette/Theme Generator
// http://mcg.mbitson.com/
// https://github.com/mbitson/mcg
const int _greenPrimary = 0xFF6aa84f;

const MaterialColor themeColor = const MaterialColor(
  _greenPrimary,
  const <int, Color>{
    50: const Color(0xFFedf5ea),
    100: const Color(0xFFd2e5ca),
    200: const Color(0xFFb5d4a7),
    300: const Color(0xFF97c284),
    400: const Color(0xFF80b569),
    500: const Color(_greenPrimary),
    600: const Color(0xFF62a048),
    700: const Color(0xFF57973f),
    800: const Color(0xFF4d8d36),
    900: const Color(0xFF3c7d26),
  },
);
