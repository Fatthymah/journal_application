import 'package:flutter/material.dart';
import '../../../app_constants/colors.dart';
import 'package:provider/provider.dart';
import '../controller/journal_provider.dart';
import '../model/journal_model.dart';
import 'add_journal_screen.dart';

class JournalCard extends StatelessWidget {
  final Journal journal;

  const JournalCard({super.key, required this.journal});

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<JournalProvider>(context, listen: false);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: AppColors.primary),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddJournalScreen(
                        journal: journal,
                      ),
                    ),
                  );
                },
              ),

              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  provider.deleteJournal(
                    journal.id,
                    journal.userId,
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            journal.content,
            style: TextStyle(
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "#${journal.tags}",
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}