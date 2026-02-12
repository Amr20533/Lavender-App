import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lavender/core/routing/app_router.dart';
import 'package:lavender/lavender.dart';

import 'core/networking/dio_helper.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  DioHelper.init();
  await Hive.initFlutter();
  final box = await Hive.openBox('settings');
  await Hive.openBox('onboardingBox');
  await Hive.openBox('diaryBox');
  await Hive.openBox('localStoriesBox');
  final AppRouter appRouter = AppRouter();
  runApp(
     EasyLocalization(
        supportedLocales: [Locale('ar'), Locale('en')],
        path: 'assets/lang',
        fallbackLocale: Locale('ar'),
        startLocale: Locale('ar'),
        child: Lavender(appRouter: appRouter, box: box),
      ),
  );
}
