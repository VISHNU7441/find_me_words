import 'package:find_me_words/core/models/remote/word_model.dart';
import 'package:find_me_words/feature/home/presentation/pages/bookmark_screen.dart';
import 'package:find_me_words/feature/home/presentation/pages/home_screen.dart';
import 'package:find_me_words/feature/home/presentation/pages/no_data_screen.dart';
import 'package:find_me_words/feature/home/presentation/pages/word_detail_screen.dart';
import 'package:find_me_words/feature/splash/presentation/splash_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) {
        final isSuccess = state.extra as bool? ?? false;
        return HomeScreen(isDataBaseConfigSuccess: isSuccess);
      },
    ),
    GoRoute(
      path: '/bookmarks',
      builder: (context, state) => const BookmarkScreen(),
    ),
    GoRoute(
      path: '/detail',
      builder: (context, state) {
        final word = state.extra as WordModel;
        return WordDetailScreen(word: word);
      },
    ),
    GoRoute(
      path: '/no-data',
      builder: (context, state) => const NoDataScreen(),
    ),
  ],
);
