import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import 'home/home_page.dart';
import 'setup_profile_page.dart';
import 'sign_in_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AppState>(
        builder: (context, value, child) {
          return value.user == null
              ? const SignInPage()
              : value.userModel == null
                  ? const SetupProfilePage()
                  : const HomePage();
        },
      ),
    );
  }
}
