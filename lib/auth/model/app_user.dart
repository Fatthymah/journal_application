class AppUser {
  final String uid;
  final String email;

  AppUser({
    required this.uid,
    required this.email,
});

  // convert firebase user - AppUser
  factory AppUser.fromFirebase(user) {
    return AppUser(
      uid: user.uid,
      email: user.email ?? "",
    );
  }
}