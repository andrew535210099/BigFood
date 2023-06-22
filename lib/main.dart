import 'package:duds/Components/onboarding_second_screen.dart';
import 'package:duds/Components/fill_screen.dart';
import 'package:duds/Components/onboarding_first_screen.dart';
import 'package:duds/Components/loading_screen.dart';
import 'package:duds/constants.dart';
import 'package:flutter/material.dart';

import 'Components/payment_screen.dart';
import 'Components/testing_screen.dart';
import 'Components/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kPrimaryLightColor
      ),
      initialRoute: '/profile',
      routes: {
        '/': (context) => const LoadingScreen(),
        '/welcome': (context) => const OnboardingFirstScreen(),
        '/welcome2': (context) => const OnboardingSecondScreen(),
        '/fillprofile': (context) => FillProfileScreen(),
        '/payment': (context) => PaymentMethodPage(),
        '/testing': (context) => TestingScreen(),
        '/profile': (context) => UploadProfilePage(),
      },
    );
  }
}
