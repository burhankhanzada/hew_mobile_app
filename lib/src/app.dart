import 'package:flutter/material.dart';
import 'package:spaces/spaces.dart';

import 'constants/color_constants.dart';
import 'pages/home/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData.light().copyWith(primaryColor: red),
      builder: (context, child) => Spacing.fixed(
        data: SpacingData.generate(10),
        child: child!,
      ),
    );
  }
}
