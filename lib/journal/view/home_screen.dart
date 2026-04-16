import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:flutter/material.dart';
import 'package:journal_application/auth/view/login_screen.dart';
import 'package:provider/provider.dart';
import '../../../auth/controller/auth_provider.dart';
import '../../../app_constants/colors.dart';
import '../controller/journal_provider.dart';
import 'add_journal_screen.dart';
import 'journal_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final userId = user.uid;

    Future.microtask(() {
      Provider.of<JournalProvider>(context, listen: false)
          .fetchJournals(userId);
    });
  }

  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          "Daily Record",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Icon(Icons.search, color: AppColors.textPrimary),

          IconButton(
            onPressed: () async {
              await auth.logout();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
              );
            },
            icon: Icon(Icons.logout, color: AppColors.textPrimary),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Hello ",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              "Write your thoughts for today...",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),

            const SizedBox(height: 20),

            //  Real data list
            Expanded(
              child: Consumer<JournalProvider>(
                builder: (context, provider, _) {

                  if (provider.journals.isEmpty) {
                    return Center(
                      child: Text(
                        "No entries yet 📝",
                        style: TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: provider.journals.length,
                    itemBuilder: (context, index) {
                      final journal = provider.journals[index];

                      return JournalCard(journal: journal);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddJournalScreen(),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}