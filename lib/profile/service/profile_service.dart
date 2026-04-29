import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  final supabase = Supabase.instance.client;

  Future<Map<String, dynamic>?>getProfile(String userId) async {
    final data = await supabase
        .from('profile')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    return data;
  }

  Future<void> createOrUpdateProfile({
    required String userId,
    required String username,
    required String imageUrl,
})async {
    await
    supabase.from('profile').upsert({
      'user_id':userId,
      'username':username,
      'image_url':imageUrl,
    });
  }
}