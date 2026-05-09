import 'package:find_me_words/feature/home/presentation/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    super.key,
    required this.isDataBaseConfigSuccess,
  });

  final bool isDataBaseConfigSuccess;

  @override
  ConsumerState<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!widget.isDataBaseConfigSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Failed to setup local database.",
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(
      homePageControllerProvider,
    );

    final isSearchEmpty = state.query.trim().isEmpty && state.suggestions.isEmpty;

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        minimum: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [
                const Text(
                  "Find Words",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(width: 10),

                // ONLINE STATUS
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),

                const Spacer(),

                // THEME BUTTON
                IconButton(
                  onPressed: () {
                    print("theme button tapped");
                  },
                  icon: const Icon(
                    Icons.dark_mode_outlined,
                  ),
                ),

                // BOOKMARK BUTTON
                IconButton(
                  onPressed: () {
                    print("navigate to bookmarks");
                  },
                  icon: const Icon(
                    Icons.bookmark_border,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                hintText: "Search word...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {

                  },
                  icon: const Icon(
                    Icons.arrow_forward,
                  ),
                ),
              ),

              onChanged: (value) {
                ref
                    .read(
                      homePageControllerProvider.notifier,
                    )
                    .onQueryChanged(value);
              },
            ),

            const SizedBox(height: 20),

            if (isSearchEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.cruelty_free, size: 38, color: Colors.grey),

                      const SizedBox(height: 16),

                      const Text(
                        "Search for words",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            if (state.isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),

            if (!state.isLoading && state.suggestions.isNotEmpty)
              Expanded(
                child: ListView.separated(

                  itemCount: state.suggestions.length,

                  separatorBuilder: (_, __) {
                    return const Divider(height: 1);
                  },

                  itemBuilder: (context, index) {

                    final suggestion =
                        state.suggestions[index];

                    return ListTile(

                      title: Text(suggestion),

                      leading: const Icon(
                        Icons.menu_book_outlined,
                      ),

                      onTap: () {

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




/*
import 'package:find_me_words/feature/home/presentation/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    super.key,
    required this.isDataBaseConfigSuccess,
  });

  final bool isDataBaseConfigSuccess;

  @override
  ConsumerState<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {

  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {

      if (!widget.isDataBaseConfigSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Failed to setup local database.",
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(
      homePageControllerProvider,
    );

    final shouldShowEmptyState =
        state.suggestions.isEmpty &&
        state.query.trim().isEmpty;

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        minimum: const EdgeInsets.all(20),

        child: Column(
          children: [

            // HEADER
            Row(
              children: [

                const Text(
                  "Find Words",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(width: 10),

                // ONLINE STATUS
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),

                const Spacer(),

                // THEME BUTTON
                IconButton(
                  onPressed: () {
                    print("theme button tapped");
                  },
                  icon: const Icon(
                    Icons.dark_mode_outlined,
                  ),
                ),

                // BOOKMARK BUTTON
                IconButton(
                  onPressed: () {
                    print("navigate to bookmarks");
                  },
                  icon: const Icon(
                    Icons.bookmark_border,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // SEARCH FIELD
            TextField(

              decoration: InputDecoration(

                hintText: "Search word...",

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),

                prefixIcon: const Icon(
                  Icons.search,
                ),

                // SUBMIT BUTTON
                suffixIcon: IconButton(
                  onPressed: () {
                    print("submitted");
                  },
                  icon: const Icon(
                    Icons.arrow_forward,
                  ),
                ),
              ),

              onChanged: (value) {

                ref
                    .read(
                      homePageControllerProvider.notifier,
                    )
                    .onQueryChanged(value);
              },
            ),

            const SizedBox(height: 24),

            // EMPTY STATE
            if (shouldShowEmptyState)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      RotationTransition(
                        turns: _animationController,
                        child: const Icon(
                          Icons.search,
                          size: 60,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        "Search for words",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // LOADING
            if (state.isLoading)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),

            // SUGGESTIONS
            if (!state.isLoading &&
                state.suggestions.isNotEmpty)
              Expanded(
                child: ListView.separated(

                  itemCount: state.suggestions.length,

                  separatorBuilder: (_, __) {
                    return const Divider(height: 1);
                  },

                  itemBuilder: (context, index) {

                    final suggestion =
                        state.suggestions[index];

                    return ListTile(

                      leading: const Icon(
                        Icons.menu_book_outlined,
                      ),

                      title: Text(
                        suggestion,
                      ),

                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),

                      onTap: () {
                        print(suggestion);
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
*/