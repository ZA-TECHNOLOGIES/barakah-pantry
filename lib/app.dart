import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/constants/app_constants.dart';
import 'core/utils/helpers/ui_helper.dart';

class BarakahPantryApp extends StatelessWidget {
  const BarakahPantryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // App Info
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: UIHelper.messengerKey,

      // Theme Configuration
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,

      // Localization
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),

      // Routing
      initialRoute: AppRouter.initial,
      getPages: AppRouter.routes,
      unknownRoute: AppRouter.unknownRoute,

      // Default Transitions
      defaultTransition: Transition.fadeIn,
      transitionDuration: AppConstants.defaultAnimationDuration,

      // Global Builder
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.noScaling,
          ),
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: child,
          ),
        );
      },
    );
  }
}
