import 'package:flutter/material.dart';
import 'package:journal_application/app_constants/colors.dart';
import 'package:journal_application/model/onboarding_model.dart';
import '../app_constants/texts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../auth/view/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<OnboardingModel> pages = [
    OnboardingModel(
      title:AppStrings.title1,
      description:AppStrings.desc1,
      image: 'assets/images/img1.svg',
    ),
    OnboardingModel(
      title:  AppStrings.title2,
      description: AppStrings.desc2,
      image: 'assets/images/img2.svg',
    ),
    OnboardingModel(
      title:  AppStrings.title3,
      description: AppStrings.desc3,
      image: 'assets/images/img3.svg',
    ),
  ];

  void nextPage() async{
    if(currentIndex < pages.length - 1) {
      _controller.nextPage(duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
      );
    }else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isFirstTime',false);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: AppColors.background,
      body: Column(
        children: [
          // skip button
          Align(
            alignment: Alignment.topRight,
            child: TextButton(onPressed: () async{
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isFirstTime', false);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginScreen(),
                ),
              );
            },
              child: const Text(AppStrings.skip),
            ),
          ),
          // Pageview
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: pages.length,
              onPageChanged: (index){
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context,index){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   SvgPicture.asset(
                     pages[index].image,
                     height: 320,
                     placeholderBuilder: (context)=> CircularProgressIndicator(),
                   ),
                    const SizedBox(height: 40),

                  Text(
                   pages[index].title,
                   style:TextStyle(
                     fontSize: 24,
                     fontWeight: FontWeight.bold,
                     color: AppColors.textSecondary,
                   ),
                ),
                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        pages[index].description,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // Indicator Dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              pages.length,
                (index) => Container(
                  margin: const EdgeInsets.all(4),
                  width: currentIndex == index ? 12 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? AppColors.primary
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
            ),
          ),
          const SizedBox(height: 20),

          // Next Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: nextPage,
                child: Text(
                  currentIndex == pages.length - 1
                      ? AppStrings.getStarted
                      : AppStrings.next,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
