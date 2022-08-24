import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spaces/spaces.dart';

import 'constants/color_constants.dart';
import 'state/app_state.dart';
import 'utils/routes_util.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(create: (_) => AppState()),
      ],
      child: MaterialApp(
        initialRoute: splash,
        onGenerateRoute: onGenerateRoute,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(primaryColor: red),
        builder: (context, child) => Spacing.fixed(
          data: SpacingData.generate(10),
          child: child!,
        ),
      ),
    );
  }
}
