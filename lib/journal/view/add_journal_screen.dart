import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app_constants/colors.dart';
import '../controller/journal_provider.dart';
import '../model/journal_model.dart';

class AddJournalScreen extends StatefulWidget {
  final Journal? journal;
  const AddJournalScreen({super.key,this.journal});

  @override
  State<AddJournalScreen> createState() => _AddJournalScreenState();
}

class _AddJournalScreenState extends State<AddJournalScreen> {

  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final tagsController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.journal != null) {
      titleController.text = widget.journal!.title;
      contentController.text = widget.journal!.content;
      tagsController.text = widget.journal!.tags;
    }
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<JournalProvider>(context,listen: false);

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text("New Entry"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: titleController,
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
              decoration: const InputDecoration(hintText: "Title"),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: contentController,
              maxLength: null,
              maxLines: 6,
              decoration: const InputDecoration(hintText: "Content"),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: tagsController,
              decoration: const InputDecoration(hintText: "Tags"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                print("Save clicked");

                final user = FirebaseAuth.instance.currentUser;

                if (user == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("User not logged in")),
                  );
                  return;
                }

                final userId = user.uid;

                print("User id: $userId");

                if (titleController.text.isEmpty ||
                    contentController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please fill all fields")),
                  );
                  return;
                }

                final provider = Provider.of<JournalProvider>(context,listen: false);

                if (widget.journal == null) {
                  // create
                  await provider.addJournal(
                    Journal(
                      id: '',
                      userId: userId,
                      title: titleController.text,
                      content: contentController.text,
                      tags: tagsController.text,
                      createdAt: DateTime.now(),
                    ),
                  );
                  print("Created");
                } else {
                  //  Update
                  await provider.updateJournal(
                    widget.journal!.id,
                    titleController.text,
                    contentController.text,
                    tagsController.text,
                    userId,
                  );
                  print("Insert success");
                }

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: Text(
                widget.journal == null ? "Save" : "Update",
              ),
            )
          ],
        ),
      ),
    );
  }
}