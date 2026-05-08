import 'package:find_me_words/feature/home/presentation/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key, required this.isDataBaseConfigSuccess});

  final bool isDataBaseConfigSuccess;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  @override
  void initState() {
    super.initState();

    if (!widget.isDataBaseConfigSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to setup local Database."))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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