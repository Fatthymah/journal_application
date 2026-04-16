import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/journal_model.dart';

class JournalService {
  final supabase = Supabase.instance.client;

  // create
  Future<void> addJournal({
    required String title,
    required String content,
    required String tags,
    required String userId,
  }) async {
    try {
      await supabase.from('journals').insert({
        'title': title,
        'content': content,
        'tags': tags,
        'user_id': userId,
      });
    } catch (e) {
      print("Supabase Error: $e");
      throw e;
    }
  }

  // read
  Future<List<Journal>> getJournals(String userId) async {
    final response = await supabase
        .from('journals')
        .select()
        .eq('user_id', userId)
        .order('created_at',ascending: false);

    return response.map((e)=> Journal.fromJson(e)).toList();
  }

  // update
  Future<void> updateJournal ({
    required String id,
    required String title,
    required String content,
    required String tags,
})async {
    await supabase.from('journals').update({
      'title':title,
      'content':content,
      'tags':tags,
    }).eq('id', id);
  }

  // delete
  Future<void> deleteJournal(String id) async {
    await supabase.from('journals').delete().eq('id', id);
  }
}