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
    final isDarkMode = state.isDarkMode;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),

        title: Text(
          'Bookmarks',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,
      ),

      body: SafeArea(

        child: bookmarkItems.isEmpty

            ? Center(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [

                    Icon(
                      Icons.bookmark_border_rounded,
                      size: 80,
                      color: isDarkMode ? Colors.grey.shade600 : Colors.grey,
                    ),

                    const SizedBox(height: 16),

                    Text(
                      'No bookmarks yet',
                      style: TextStyle(
                        fontSize: 18,
                        color: isDarkMode ? Colors.grey.shade400 : Colors.grey,
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
                      color: isDarkMode ? Colors.grey.shade900 : Colors.white,

                      borderRadius:
                          BorderRadius.circular(
                        18,
                      ),

                      boxShadow: [
                        BoxShadow(
                          color: isDarkMode ? Colors.black.withOpacity(0.3) : Colors.black
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
                            isDarkMode ? Colors.blue.shade900 : Colors.blue.shade50,

                        child: Text(
                          word[0]
                              .toUpperCase(),

                          style: TextStyle(
                            color:
                                isDarkMode ? Colors.blue.shade200 : Colors.blue.shade800,

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
                        ref
                            .read(homePageControllerProvider.notifier)
                            .searchFor(word);
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}