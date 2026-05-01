import 'package:find_me_words/feature/home/presentation/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        minimum: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("data", style: TextStyle(fontSize: 18)),
            
            Spacer(),

            TextField(
              decoration: InputDecoration(
                labelText: "Search word.."
              ),
              onSubmitted: (value) {
                
              },
              onChanged: (value) {
                print("changed");
                ref.read(homePageControllerProvider.notifier).onQueryChanged(value); // call the query function on every value change.
              },
              
            )
          ],
        ),
      )
    );
  }
}