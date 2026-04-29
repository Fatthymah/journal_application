import 'package:flutter/cupertino.dart';
import 'package:journal_application/profile/model/profile_model.dart';
import 'package:journal_application/profile/service/profile_service.dart';

class ProfileProvider extends ChangeNotifier{
  final ProfileService _service = ProfileService();

  ProfileModel? profile;

  Future<void> fetchProfile(String userId) async {
    final data = await _service.getProfile(userId);
    if(data != null) {
      profile = ProfileModel.fromMap(data);
    }
    notifyListeners();
  }

  Future<void> saveProfile(
      String userId,
      String username,
      String imageUrl,
      )async {
    await _service.createOrUpdateProfile(userId: userId, username: username, imageUrl: imageUrl);

    await fetchProfile(userId);
  }
}