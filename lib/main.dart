import 'package:find_me_words/core/theme/app_theme.dart';
import 'package:find_me_words/feature/home/presentation/controllers/home_page_controller.dart';
import 'package:find_me_words/feature/splash/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(homePageControllerProvider.select((s) => s.themeMode));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Find Me Words',
      themeMode: themeMode,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const SplashScreen(),
    );
  }
}