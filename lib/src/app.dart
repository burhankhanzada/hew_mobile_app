import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spaces/spaces.dart';

import 'constants/color_constants.dart';
import 'pages/home/home_page.dart';
import 'pages/setup_profile_page.dart';
import 'pages/sign_in_page.dart';
import 'state/app_state.dart';
import 'utils/firebase_utils.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(create: (_) => AppState()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(primaryColor: red),
        builder: (context, child) => Spacing.fixed(
          data: SpacingData.generate(10),
          child: child!,
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: navigateAccordingToAuth,
        ),
      ),
    );
  }

  Widget navigateAccordingToAuth(
    BuildContext context,
    AsyncSnapshot<User?> snapshot,
  ) {
    if (snapshot.hasData) {
      final user = snapshot.data;

      final uid = user?.uid;

      userRef(uid!).get().then((value) {
        if (value.exists) {
          return const HomePage();
        }

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute<void>(
            builder: (contex) => const SetupProfilePage(),
          ),
          (route) => false,
        );
      });
    }

    return const SignInPage();
  }
}
