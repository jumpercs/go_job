import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_job/firebase_options.dart';
import 'package:go_job/models/user_model.dart';
import 'package:go_job/pages/home_page.dart';
import 'package:go_job/pages/login_page.dart';
import 'package:go_job/pages/register_user/register_page.dart';
import 'package:go_job/pages/scort_details.dart';
import 'package:go_job/pages/verifiy_page.dart';
import 'package:go_job/providers/user_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoJob',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
        ),
      ),
      routes: {
        '/': (context) => SignInPage(),
        '/home': (context) => const MyHomePage(),
        '/register': (context) => SignUpPage(),
        '/verify': (context) => VerificationPage(),
        '/scort_details': (context) => const ScortDetailsPage(),
      },
      initialRoute: '/',
    );
  }
}
