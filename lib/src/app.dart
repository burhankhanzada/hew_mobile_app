import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spaces/spaces.dart';

import 'constants/color_constants.dart';
import 'models/user_model.dart';
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
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return navigateAccordingToAuth(snapshot.data!);
            }

            return const SignInPage();
          },
        ),
      ),
    );
  }

  Widget navigateAccordingToAuth(User user) {
    return FutureBuilder<DataSnapshot>(
      future: userRef(user.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final datasnapshot = snapshot.data!;

          if (!datasnapshot.exists) {
            return const SetupProfilePage();
          } else {
            debugPrint('user data exits in database');

            final map = datasnapshot.value! as Map<dynamic, dynamic>;

            final userModel = UserModel.fromMap(map);

            context.read<AppState>().userModel = userModel;

            return const HomePage();
          }
        }

        return const SignInPage(isLoading: true);
      },
    );
  }
}
