import 'package:find_me_words/feature/home/presentation/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookmarkScreen extends ConsumerStatefulWidget {
  const BookmarkScreen({
    super.key,
  });
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _BookmarkScreenState();
  }
}
class _BookmarkScreenState extends ConsumerState  {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(homePageControllerProvider.notifier).getBookmarkedItems();
    });
  }

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(
      homePageControllerProvider,
    );

    final controller = ref.read(
      homePageControllerProvider.notifier,
    );

    final bookmarkItems = state.bookmarkItems;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),

        title: const Text(
          'Bookmarks',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,
      ),

      body: SafeArea(

        child: bookmarkItems.isEmpty

            ? const Center(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [

                    Icon(
                      Icons.bookmark_border_rounded,
                      size: 80,
                      color: Colors.grey,
                    ),

                    SizedBox(height: 16),

                    Text(
                      'No bookmarks yet',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )

            : ListView.separated(

                padding:
                    const EdgeInsets.all(20),

                itemCount:
                    bookmarkItems.length,

                separatorBuilder: (_, __) {
                  return const SizedBox(
                    height: 14,
                  );
                },

                itemBuilder: (
                  context,
                  index,
                ) {

                  final word =
                      bookmarkItems[index];

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius:
                          BorderRadius.circular(
                        18,
                      ),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.05),

                          blurRadius: 10,
                          offset:
                              const Offset(0, 4),
                        ),
                      ],
                    ),

                    child: ListTile(

                      contentPadding:
                          const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),

                      leading: CircleAvatar(
                        backgroundColor:
                            Colors.blue.shade50,

                        child: Text(
                          word[0]
                              .toUpperCase(),

                          style: TextStyle(
                            color:
                                Colors.blue.shade800,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),

                      title: Text(
                        word,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),

                      trailing: IconButton(
                        onPressed: () async {

                          await controller.updateTheBookmarkState(word);

                          if (!context.mounted) {
                            return;
                          }

                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(
                            SnackBar(
                              content: Text(
                                '"$word" removed from bookmarks',
                              ),
                            ),
                          );
                        },

                        icon: const Icon(
                          Icons.bookmark_rounded,
                          color: Colors.orange,
                        ),
                      ),

                      onTap: () async {

                        /// TODO:
                        /// Navigate to detail page

                        debugPrint(
                          'Tapped: $word',
                        );
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}