import 'package:find_me_words/core/router/app_router.dart';
import 'package:find_me_words/core/theme/app_theme.dart';
import 'package:find_me_words/feature/home/presentation/controllers/home_page_controller.dart';
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

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Find Me Words',
      themeMode: themeMode,
      theme: lightTheme,
      darkTheme: darkTheme,
      routerConfig: appRouter,
    );
  }
}