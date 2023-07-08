import 'package:duds/Components/chat.dart';
import 'package:duds/Components/filter_screen.dart';
import 'package:duds/Components/onboarding_two_screen.dart';
import 'package:duds/Components/profilepage.dart';
import 'package:duds/Components/resetpass_screen.dart';
import 'package:duds/Components/testing_screen.dart';
import 'package:duds/Components/loading_screen.dart';
import 'package:duds/Components/uploadpreview_screen.dart';
import 'package:duds/Components/yourorders_screen.dart';
import 'package:duds/constants.dart';
import 'package:duds/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Components/deleteaccount_screen.dart';
import 'Components/login_screen.dart';
import 'Components/onboarding_one_screen.dart';
import 'Components/payment_screen.dart';
import 'Components/setlocation_screen.dart';
import 'Components/signupsuccess_screen.dart';
import 'Components/successnotification_screen.dart';
import 'Components/testfirestore_screen.dart';
import 'Components/uploadphoto_screen.dart';
import 'Components/signup_process_screen.dart';
import 'Components/help.dart';
import 'Components/signup_screen.dart';
import 'Components/verificationcode_screen.dart';
import 'Components/orderdetails.dart';
import 'Components/viamethod_screen.dart';
import 'Components/home.dart';
import 'Components/homebar.dart';
import './UserData/user_provider.dart';
import 'UserData/cart_screen';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoadingScreen(),
        '/welcome': (context) => const OnboardingOneScreen(),
        '/welcome2': (context) => const OnboardingTwoScreen(),
        '/testing': (context) =>  TestingScreen(),
        '/payment': (context) =>  const PaymentMethodPage(),
        '/signup1': (context) =>  SignUpProcess(),
        '/login': (context) =>  LoginScreen(),
        '/signup': (context) =>  SignUpScreen(),
        '/verification': (context) =>  VerificationScreen(),
        '/profile': (context) =>  UploadProfilePage(),
        '/viamethod': (context) =>  ViaMethodScreen(),
        '/resetpass' : (context) => ResetPasswordPage(),
        '/successnotif' : (context) => SuccessNotif(),
        '/signupsuccesspage' : (context) => SignUpSuccessPage(),
        '/setlocationpage' : (context) => SetLocationPage(),
        '/homepage' : (context) => HomePage(),
        '/homebar': (context) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?; // Perhatikan penggunaan '?'
      final currentIndex = args?['currentIndex'] as int? ?? 0; // Perhatikan penggunaan '?'
      return HomeBar(currentIndex: currentIndex);
    },
        '/firestore' : (context) => const TestFirestoreScreen(),
        '/profile1' : (context) =>  ProfileScreen(),
        '/deleteaccount' : (context) => const DeleteAccount(),
        '/filter' : (context) => FilterScreenPage(),
        // '/chat' : (context) => Chat(),
        '/orderdetails' : (context) => OrderDetail(),
        '/profilepage' : (context) => ProfilePage(),
        '/cartScreen' : (context) => CartScreen(),
        '/orderlast' : (context) => yourOrders(),
        '/help' : (context) => HelpPage(),
      },
    );
  }
}
