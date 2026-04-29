class ProfileModel {
  final String id;
  final String userId;
  final String userName;
  final String imageUrl;

  ProfileModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.imageUrl,
});

  factory ProfileModel.fromMap(Map<String,dynamic> map){
    return ProfileModel (
      id: map['id'],
      userId: map ['user_id'],
      userName: map ['username'] ?? '',
      imageUrl: map ['image_url'] ?? '',
    );
  }
}