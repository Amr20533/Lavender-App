import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/features/community/presentaion/community_screen.dart';
import 'package:lavender/features/home/presenation/home_screen.dart';
import 'package:lavender/features/programs/presentation/programs_screen.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    const Center(child: Text("🔍 Search")),
    ProgramsScreen(),
    const CommunityScreen(),
    const Center(child: Text("👤 Profile")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

      bottomNavigationBar: Container(
        height: 80.h,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, -2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(5, (index) {
            // final icons = [Icons.home, Icons.search, Icons.favorite, Icons.person];
            final inactiveIcons = ["inactive_home.svg", "inactive_session.svg", "inactive_programs.svg","inactive_community.svg", "inactive_more.svg"];
            final activeIcons = ["active_home.svg", "active_session.svg", "active_programs.svg", "active_community.svg", "active_more.svg"];
            final labels = ["Home", "Sessions", "Programs", "Community", "More"];

            final isActive = _currentIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() => _currentIndex = index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutBack,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  // color: isActive ? Colors.deepPurple.shade50 : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    AnimatedScale(
                      scale: isActive ? 1.0 : 0.9,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutBack,
                      child: SvgPicture.asset(isActive ? "assets/svg/${activeIcons[index]}" : "assets/svg/${inactiveIcons[index]}"),
                    ),
                    if (isActive) ...[
                      const SizedBox(width: 6),
                      Text(
                        labels[index],
                        style: GoogleFonts.alexandria(
                          color: AppColors.primaryColorLavenderLangAndText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
