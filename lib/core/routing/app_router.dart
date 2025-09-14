import 'package:flutter/material.dart';
import 'package:lavender/core/routing/router.dart';
import 'package:lavender/features/Questions/screens/question_screen.dart';
import 'package:lavender/features/home/presenation/all_doctors_screen.dart';
import 'package:lavender/features/home/presenation/home_screen.dart';
import 'package:lavender/features/home/presenation/main_view.dart';
import 'package:lavender/features/home/presenation/specialists_screen.dart';
import 'package:lavender/features/onbording/presentation/screens/onbpording_screen.dart';
import 'package:lavender/features/programs/presentation/measurements_screen.dart';
import 'package:lavender/features/sign_in/presentation/screens/sign_in.dart';
import 'package:lavender/features/sign_up/presentation/screens/login_or_signup_Screen.dart';
import 'package:lavender/features/sign_up/presentation/screens/sign_up.dart';
import 'package:lavender/features/splash/presenation/screens/select_language.dart';
import 'package:lavender/features/splash/presenation/screens/splash_timer_screen.dart';

import '../../features/home/data/models/specialist.dart';
import '../../features/home/presenation/details_screen.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashTimerScreen:
        return MaterialPageRoute(builder: (_) => SplashTimerScreen());
      case Routes.selectLanguage:
        return MaterialPageRoute(builder: (_) => SelectLanguage());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => MainView());
      case Routes.onboardingScreen:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case Routes.psychologistDetailsPage:
        final specialist = settings.arguments as Specialist;
        return MaterialPageRoute(
          builder: (_) => PsychologistDetailsPage(specialist: specialist),
        );
      case Routes.loginOrSignupScreen:
        return MaterialPageRoute(builder: (_) => LoginOrSignupScreen());
      case Routes.signInScreen:
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case Routes.questionScreen:
        return MaterialPageRoute(builder: (_) => QuestionScreen());
      case Routes.specialistScreen:
        return MaterialPageRoute(builder: (_) => SpecialistsScreen());
      case Routes.allDoctorsScreen:
        return MaterialPageRoute(builder: (_) => AllDoctorsScreen());
      case Routes.measurementScreen:
        return MaterialPageRoute(builder: (_) => MeasurementsScreen());

      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(body: Center(child: Text('Page not found!'))),
        );
    }
  }
}
