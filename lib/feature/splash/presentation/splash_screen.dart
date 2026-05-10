import 'dart:async';

import 'package:find_me_words/core/database/app_database.dart';
import 'package:find_me_words/core/database/services/dictionary_preload_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   bool _isDataBaseConfigSuccess = false;

  @override
  void initState() {
    super.initState();

    _initializeApp();
  }

  Future<void> _initializeApp() async {
  try {
    final preloadService = DictionaryPreloadService(
      AppDatabase(),
    );

    await preloadService.preloadDictionary();

    if (mounted) { 
      setState(() {
        _isDataBaseConfigSuccess = true;
      });
    }

  } catch (e, stackTrace) {
    if (mounted) {
      setState(() {
        _isDataBaseConfigSuccess = false;
      });
    }

    debugPrint('Initialization Error: $e');
    debugPrintStack(stackTrace: stackTrace);

  } finally {

    if (mounted) {
      context.go('/home', extra: _isDataBaseConfigSuccess);
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [

            Icon(
              Icons.menu_book_rounded,
              size: 100,
              color: Colors.white,
            ),

            SizedBox(height: 20),

            Text(
              'Dictionary App',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 10),

            Text(
              'Learn new words everyday',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}