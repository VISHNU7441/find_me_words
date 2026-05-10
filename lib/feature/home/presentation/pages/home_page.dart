import 'package:find_me_words/feature/home/presentation/controllers/home_page_controller.dart';
import 'package:find_me_words/feature/home/presentation/pages/bookmark_screen.dart';
import 'package:find_me_words/feature/home/presentation/pages/word_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key, required this.isDataBaseConfigSuccess});

  final bool isDataBaseConfigSuccess;

  @override
  ConsumerState<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!widget.isDataBaseConfigSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to setup local database.")),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    
    ref.listen(homePageControllerProvider, (previous, next) {
      if (next.wordDetails != null &&
          next.wordDetails != previous?.wordDetails) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => WordDetailScreen(word: next.wordDetails!),
          ),
        );
      }
    });

    final state = ref.watch(homePageControllerProvider);

    final isSearchEmpty =
        state.query.trim().isEmpty && state.suggestions.isEmpty;
    final themeMode = state.themeMode;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HeaderView
            Row(
              children: [
                const Text(
                  "Find Words",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),

                const SizedBox(width: 10),

                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: state.hasInternet ? Colors.green : Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),

                const Spacer(),

                IconButton(
                  onPressed: () {
                    ref.read(homePageControllerProvider.notifier).toggleTheme();
                  },
                  icon: Icon(
                    themeMode == ThemeMode.system
                        ? Icons.brightness_auto
                        : (themeMode == ThemeMode.dark
                            ? Icons.light_mode
                            : Icons.dark_mode_outlined),
                  ),
                ),

                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => BookmarkScreen()));
                  },
                  icon: const Icon(Icons.bookmark_border),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // SearchField
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search word...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {
                    final currentText = _searchController.text;
                    ref
                        .read(homePageControllerProvider.notifier)
                        .searchFor(currentText);
                  },
                  icon: const Icon(Icons.arrow_forward),
                ),
              ),

              onChanged: (value) {
                ref
                    .read(homePageControllerProvider.notifier)
                    .onQueryChanged(value);
              },
              onSubmitted: (value) {
                ref.read(homePageControllerProvider.notifier).searchFor(value);
              },
            ),

            const SizedBox(height: 20),

            // body
            if (isSearchEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.cruelty_free,
                        size: 38,
                        color: Colors.grey,
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        "Search for words",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),

            if (state.isLoading)
              const Center(child: CircularProgressIndicator()),

            if (!state.isLoading && state.suggestions.isNotEmpty)
              Expanded(
                child: ListView.separated(
                  itemCount: state.suggestions.length,

                  separatorBuilder: (_, __) {
                    return const Divider(height: 1);
                  },

                  itemBuilder: (context, index) {
                    final suggestion = state.suggestions[index];

                    return ListTile(
                      title: Text(suggestion),

                      leading: const Icon(Icons.menu_book_outlined),

                      onTap: () {
                        ref
                            .read(homePageControllerProvider.notifier)
                            .searchFor(suggestion);
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
