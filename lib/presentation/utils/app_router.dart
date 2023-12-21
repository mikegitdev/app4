import 'package:audio_service/audio_service.dart';
import 'package:app4/presentation/pages/home/home_page.dart';
import 'package:app4/presentation/pages/player_page.dart';
import 'package:app4/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AppRouter {
  static const String splashRoute = '/';
  static const String homeRoute = '/home';
  static const String playerRoute = '/player';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const SplashPage(),
        );
      case homeRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const HomePage(),
        );
      case playerRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => PlayerPage(
            mediaItem: settings.arguments as MediaItem,
          ),
        );
      default:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const SplashPage(),
        );
    }
  }
}
