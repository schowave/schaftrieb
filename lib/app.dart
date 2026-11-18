// Stays on the SDK Material library (deprecated since Flutter 3.47) until
// flutter_image_map moves to material_ui: mixing both breaks its InkWell/Theme.
// ignore: deprecated_member_use
import 'package:flutter/material.dart';
import 'pages/property_name_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Property Name App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const PropertyNamePage(title: 'Property Name App'),
    );
  }
}
