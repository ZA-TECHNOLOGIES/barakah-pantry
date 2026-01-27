import 'package:barakah_pantry/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:barakah_pantry/core/theme/app_typography.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../home/presentation/screens/home_screen.dart';
import '../../../pantry/presentation/screens/pantry_screen.dart';
import '../../../ai_recipe/presentation/screens/ai_recipe_screen.dart';
import '../../../favorites/presentation/screens/favorites_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../controllers/navigation_controller.dart';

class MainNavigationScreen extends GetView<NavigationController> {
  const MainNavigationScreen({super.key});

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const PantryScreen(),
      const AIRecipeScreen(),
      const FavoritesScreen(),
      const ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_rounded),
        title: 'Home',
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.grey500,
        textStyle: AppTypography.h3,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.eco_rounded),
        title: 'Pantry',
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.grey500,
        textStyle: AppTypography.h3,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.auto_awesome_rounded),
        title: 'AI Recipe',
        activeColorPrimary: AppColors.primary,
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: AppColors.grey500,
        textStyle: AppTypography.h3,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.favorite_rounded),
        title: 'Favorites',
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.grey500,
        textStyle: AppTypography.h3,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.person_rounded,
        ),
        title: 'Profile',
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.grey500,
        textStyle: AppTypography.h3,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller.tabController,
      screens: _buildScreens(),
      items: _navBarItems(),
      confineToSafeArea: true,
      backgroundColor: AppColors.background,
      navBarHeight: 80,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      navBarStyle: NavBarStyle.style15,
      onItemSelected: (index) => controller.changeTabIndex(index),
      decoration: NavBarDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
    );
  }
}
