import 'package:flutter/material.dart';
import 'package:journal_application/journal/service/journal_service.dart';
import '../model/journal_model.dart';

class JournalProvider extends ChangeNotifier {
  final JournalService _service = JournalService();

  List<Journal> journals = [];
  List<Journal> filteredJournals = [];

  Future<void> fetchJournals(String userId) async {
    journals = await _service.getJournals(userId);
    filteredJournals = journals;
    notifyListeners();
  }

  Future<void> addJournal (Journal journal) async {
    await _service.addJournal(
      title: journal.title,
      content: journal.content,
      tags: journal.tags,
      userId: journal.userId,
    );
    await fetchJournals(journal.userId);
  }

  Future<void> updateJournal(
      String id,
      String title,
      String content,
      String tags,
      String userId,
      ) async {
    await _service.updateJournal(
      id: id,
      title: title,
      content: content,
      tags: tags,
    );

    await fetchJournals(userId);
  }

  void searchJournals (String query) {
    if(query.isEmpty){
      filteredJournals = journals;
    }else {
      filteredJournals = journals.where((journals){
        return journals.title.toLowerCase().contains(query.toLowerCase()) ||
               journals.content.toLowerCase().contains(query.toLowerCase()) ||
               journals.tags.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  Future<void> deleteJournal(String id,String userId) async {
    await _service.deleteJournal(id);
    await fetchJournals(userId);
  }
}