// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../pages/home/home_page.dart';
import '../pages/setup_profile_page.dart';
import '../pages/sign_in_page.dart';
import '../pages/splash_page.dart';

const splash = '/';
const signIn = '/sign-in';
const setupProfile = '/setupProfile';
const home = '/home';

Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
  final Widget page;

  switch (routeSettings.name) {
    case splash:
      page = const SplashPage();
      break;
    case signIn:
      page = const SignInPage();
      break;
    case setupProfile:
      page = const SetupProfilePage();
      break;
    case home:
      page = const HomePage();
      break;
    default:
      page = unknownRoutePage();
  }

  return MaterialPageRoute(settings: routeSettings, builder: (context) => page);
}

Widget unknownRoutePage() {
  return const Scaffold(
    body: Center(
      child: Text('Error'),
    ),
  );
}
