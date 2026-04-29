import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:journal_application/journal/controller/journal_provider.dart';
import 'package:provider/provider.dart';
import '../../app_constants/colors.dart';
import 'journal_card.dart';


class JournalListScreen extends StatefulWidget {
  const JournalListScreen({super.key});

  @override
  State<JournalListScreen> createState() => _JournalListScreenState();
}

class _JournalListScreenState extends State<JournalListScreen> {

  @override
  void initState(){
    super.initState();

    final user = FirebaseAuth.instance.currentUser;

    if(user == null) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<JournalProvider>(context, listen: false)
          .fetchJournals(user.uid);
    });
  }


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<JournalProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("All Journals"),
        backgroundColor: AppColors.background,
      ),
      body: Column(
        children: [

          // search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) {
                Provider.of<JournalProvider>(context, listen: false)
                    .searchJournals(value);
              },
              decoration: InputDecoration(
                hintText: "Search journals...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppColors.card,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          //  List
          Expanded(
            child: provider.filteredJournals.isEmpty
                ? const Center(child: Text("No journals yet"))
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: provider.filteredJournals.length,
              itemBuilder: (context, index) {
                return JournalCard(
                  journal: provider.filteredJournals[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
