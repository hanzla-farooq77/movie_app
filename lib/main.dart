import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/views/movie_details_screen.dart';
import 'package:movie_app/views/movie_homescreen.dart';
import 'package:movie_app/views/signupscreen.dart';
import 'package:movie_app/views/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(
                builder: (context) => const SplashScreen(),
              );

            case '/home':
              return MaterialPageRoute(
                builder: (context) => MovieHomescreen(),
              );

            case '/detail':
              final movieId = settings.arguments as int;
              return MaterialPageRoute(
                builder: (context) => MovieDetailScreen(movieId: movieId),
              );

            case '/signup':
              return MaterialPageRoute(
                builder: (context) => SignupScreen(),
              );

            default:
              return MaterialPageRoute(
                builder: (context) => const Scaffold(
                  body: Center(
                    child: Text("Page not found"),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}