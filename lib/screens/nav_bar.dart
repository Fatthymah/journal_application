import 'package:flutter/material.dart';
import 'package:journal_application/app_constants/colors.dart';
import 'package:journal_application/journal/view/home_screen.dart';
import 'package:journal_application/navigation/nav_provider.dart';
import 'package:provider/provider.dart';
import '../journal/view/journal_list_screen.dart';
import '../profile/view/profile_screen.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {

    final nav = Provider.of<NavProvider>(context);

    final List<Widget> screens = [
      const HomeScreen(),
      const JournalListScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      body: screens[nav.currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: nav.currentIndex,
        onTap: (index) {
          nav.changeIndex(index);
        },
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        backgroundColor: AppColors.background,
        items: const[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: "Journals",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
