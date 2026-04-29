import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_constants/colors.dart';
import '../../auth/controller/auth_provider.dart';
import '../../auth/view/login_screen.dart';
import '../controller/profile_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Future.microtask(() {
        Provider.of<ProfileProvider>(context, listen: false)
            .fetchProfile(user.uid);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;
    final profileProvider = Provider.of<ProfileProvider>(context);
    final auth = Provider.of<AuthProvider>(context);

    final profile = profileProvider.profile;

    if (profile != null) {
      usernameController.text = profile.userName;
    }

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: AppColors.background,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const SizedBox(height: 20),

            CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.person, color: Colors.white),
            ),

            const SizedBox(height: 20),

            Text(
              user?.email ?? "",
              style: TextStyle(color: AppColors.textPrimary),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                hintText: "Enter username",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                if (user == null) return;

                await profileProvider.saveProfile(
                  user.uid,
                  usernameController.text,
                  "",
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Profile Saved")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: const Text("Save Profile"),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () async {
                await auth.logout();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                      (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}