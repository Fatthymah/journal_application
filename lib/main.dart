import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:journal_application/auth/controller/auth_provider.dart';
import 'package:journal_application/firebase_options.dart';
import 'package:journal_application/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


bool isFirstTime = true;


 Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // for loading env file
  await dotenv.load(fileName:".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // get values form env
  final supabaseUrl = dotenv.env['SUPABASE_URL']!;
  final supabaseKey = dotenv.env['SUPABASE_KEY']!;

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
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
    );
  }
}
