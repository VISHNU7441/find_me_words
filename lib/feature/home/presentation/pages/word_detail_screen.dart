import 'package:find_me_words/feature/home/presentation/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/remote/word_model.dart';

class WordDetailScreen extends ConsumerWidget {
  final WordModel word;

  const WordDetailScreen({
    super.key,
    required this.word,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isWordBookMarked = ref.watch(homePageControllerProvider).bookmarkItems.contains(word.word);
    final isDarkMode = ref.watch(homePageControllerProvider).isDarkMode;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            ref.read(homePageControllerProvider.notifier).clearWordDetails();
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await ref
                  .read(homePageControllerProvider.notifier)
                  .updateTheBookmarkState(word.word);
            },
            icon: Icon(
              isWordBookMarked
                  ? Icons.bookmark_rounded
                  : Icons.bookmark_border_rounded,
              color: isWordBookMarked ? Colors.amber : (isDarkMode ? Colors.white : Colors.black),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// WORD
              Text(
                word.word,
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              /// PHONETIC
              if (word.phonetic != null)
                Text(
                  word.phonetic!,
                  style: TextStyle(
                    fontSize: 18,
                    color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                  ),
                ),

              const SizedBox(height: 24),

              /// AUDIO BUTTONS
              if (word.phonetics.isNotEmpty)
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: word.phonetics.map((phonetic) {
                    if (phonetic.audio == null || phonetic.audio!.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return ElevatedButton.icon(
                      onPressed: () {
                        /// TODO:
                        /// Play audio
                        debugPrint(
                          phonetic.audio,
                        );
                      },
                      icon: const Icon(
                        Icons.volume_up_rounded,
                      ),
                      label: Text(
                        phonetic.text ?? 'Audio',
                      ),
                    );
                  }).toList(),
                ),

              const SizedBox(height: 30),

              /// MEANINGS
              ...word.meanings.map(
                (meaning) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 28,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// PART OF SPEECH
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.blue.shade900.withOpacity(0.3) : Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            meaning.partOfSpeech,
                            style: TextStyle(
                              color: isDarkMode ? Colors.blue.shade200 : Colors.blue.shade800,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        /// DEFINITIONS
                        ...List.generate(
                          meaning.definitions.length,
                          (index) {
                            final definition = meaning.definitions[index];

                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: 16,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${index + 1}. ',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      definition.definition,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),

                        /// SYNONYMS
                        if (meaning.synonyms.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          const Text(
                            'Synonyms',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: meaning.synonyms.map((e) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: isDarkMode ? Colors.green.shade900.withOpacity(0.3) : Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(
                                    20,
                                  ),
                                ),
                                child: Text(
                                  e,
                                  style: TextStyle(
                                    color: isDarkMode ? Colors.green.shade200 : Colors.green.shade900,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],

                        /// ANTONYMS
                        if (meaning.antonyms.isNotEmpty) ...[
                          const SizedBox(height: 20),
                          const Text(
                            'Antonyms',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: meaning.antonyms.map((e) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: isDarkMode ? Colors.red.shade900.withOpacity(0.3) : Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(
                                    20,
                                  ),
                                ),
                                child: Text(
                                  e,
                                  style: TextStyle(
                                    color: isDarkMode ? Colors.red.shade200 : Colors.red.shade900,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
