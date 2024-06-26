import 'package:content_generator_front/app_theme.dart';
import 'package:content_generator_front/screens/describe_image_screen.dart';
import 'package:content_generator_front/screens/home_screen.dart';
import 'package:content_generator_front/screens/keywords_screen.dart';
import 'package:content_generator_front/screens/login_screen.dart';
import 'package:content_generator_front/screens/rating_screen.dart';
import 'package:content_generator_front/screens/register_screen.dart';
import 'package:content_generator_front/screens/description_screen.dart';
import 'package:content_generator_front/screens/title_screen.dart';
import 'package:content_generator_front/screens/validate_title_screen.dart';
import 'package:content_generator_front/services/api_service.dart';
import 'package:content_generator_front/services/cache_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApiService.init();
  await CacheService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: appTheme(),
      routes: {
        '/': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        DescriptionScreen.routeName: (context) => const DescriptionScreen(),
        KeywordsScreen.routeName: (context) => const KeywordsScreen(),
        ValidateTitleScreen.routeName: (context) => const ValidateTitleScreen(),
        RatingScreen.routeName: (context) => const RatingScreen(),
        TitleScreen.routeName: (context) => const TitleScreen(),
        DescribeImageScreen.routeName: (context) => const DescribeImageScreen(),
      },
    );
  }
}
