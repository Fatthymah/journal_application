import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:journal_application/auth/controller/auth_provider.dart';
import 'package:journal_application/firebase_options.dart';
import 'package:journal_application/screens/onboarding_screen.dart';
import 'package:journal_application/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


bool isFirstTime = true;


 Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Supabase.initialize(
    url: 'https://zvqnvwgwrltmntwcppxk.supabase.co',
    anonKey: 'sb_publishable_JuEsBnfY05vU9V_9r7uZUQ_rhC_2NMV',
  );

  final prefs = await SharedPreferences.getInstance();
  isFirstTime = prefs.getBool('isFirstTime')?? true;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          final auth = AuthProvider();
          auth.checkUser();
          return auth;
        }
        )
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
     // home: OnboardingScreen(),
    );
  }
}
