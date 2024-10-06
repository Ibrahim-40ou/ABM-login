import 'package:abm_login/features/profile/presentation/pages/add_complaint.dart';
import 'package:abm_login/features/profile/presentation/pages/home.dart';
import 'package:abm_login/features/profile/presentation/pages/settings.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/navigation_cubit.dart';

@RoutePage()
class App extends StatelessWidget {
  App({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Theme.of(context).brightness == Brightness.dark ? true : false;
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<NavigationCubit, int>(
          builder: (context, currentIndex) {
            return PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (index) {
                context.read<NavigationCubit>().changePage(index);
              },
              children: [
                Home(),
                AddComplaint(),
                Settings(),
              ],
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<NavigationCubit, int>(
          builder: (context, currentIndex) {
            return BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: Theme.of(context).colorScheme.surface,
              onTap: (index) {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 1),
                  curve: Curves.easeInOut,
                );
                context.read<NavigationCubit>().changePage(index);
              },
              currentIndex: currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    isDarkMode ? 'assets/dark_home.svg' : 'assets/light_home.svg',
                    height: 24,
                    width: 24,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/selected_home.svg',
                    height: 24,
                    width: 24,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    isDarkMode ? 'assets/dark_add.svg' : 'assets/light_add.svg',
                    height: 24,
                    width: 24,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/selected_add.svg',
                    height: 24,
                    width: 24,
                  ),
                  label: 'Add Complaint',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    isDarkMode
                        ? 'assets/dark_settings.svg'
                        : 'assets/light_settings.svg',
                    height: 24,
                    width: 24,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/selected_settings.svg',
                    height: 24,
                    width: 24,
                  ),
                  label: 'Settings',
                ),
              ],
              selectedLabelStyle: GoogleFonts.cairo(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.normal,
              ),
              unselectedLabelStyle: GoogleFonts.cairo(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.normal,
              ),
              selectedItemColor: Theme.of(context).colorScheme.primary,
              unselectedItemColor: isDarkMode ? Colors.white : Colors.black,
            );
          },
        ),
      ),
    );
  }
}
