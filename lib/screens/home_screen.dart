import 'package:flutter/material.dart';
import 'package:journal_application/auth/view/login_screen.dart';
import 'package:provider/provider.dart';
import '../../auth/controller/auth_provider.dart';
import '../app_constants/colors.dart';
import 'journal_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
       backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          "Daily Record",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){
              // todo: go to search screen
            },
            icon: Icon(Icons.search,color: AppColors.textPrimary),
          ),
          // logout
          IconButton(
            onPressed: () async{
             await auth.logout();

             Navigator.pushAndRemoveUntil(
               context,
               MaterialPageRoute(builder: (_)=> const LoginScreen()),
                 (route)=> false,
             );
            },
            icon: Icon(Icons.logout,color: AppColors.textPrimary),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello",
              style:  TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Write your thoughts for today...",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),

            // journal list just for temporary
            Expanded(
              child: ListView(
                children: const[
                  JournalCard(),
                  JournalCard(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: (){
          // todo: navigate to add entry
        },
        child: const Icon(Icons.add,color: Colors.white),
      ),
    );
  }
}
