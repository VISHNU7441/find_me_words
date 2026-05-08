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

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        minimum: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Find Words",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                hintText: "Search word...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.search),
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

            if (state.isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),

            if (!state.isLoading)
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