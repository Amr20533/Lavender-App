import 'package:flutter/material.dart';
import 'package:lavender/core/routing/router.dart';
import 'package:lavender/core/widget/user_info_profile.dart';
import 'package:lavender/features/Questions/screens/question_screen.dart';
import 'package:lavender/features/appointments/data/models/payment_response.dart';
import 'package:lavender/features/appointments/presentation/screens/payment_success.dart';
import 'package:lavender/features/appointments/presentation/screens/payment_view_screen.dart';
import 'package:lavender/features/appointments/presentation/screens/subscription_plan_screen.dart';
import 'package:lavender/features/community/data/models/post.dart';
import 'package:lavender/features/community/presentation/screen/comment_screen.dart';
import 'package:lavender/features/home/presenation/screens/all_doctors_screen.dart';
import 'package:lavender/features/home/presenation/screens/specialists_screen.dart';
import 'package:lavender/features/home/presenation/widgets/zoom_menu_layout.dart';
import 'package:lavender/features/onbording/presentation/screens/onbpording_screen.dart';
import 'package:lavender/features/programs/data/models/doctor_basic_info.dart';
import 'package:lavender/features/programs/data/models/music_card_model.dart';
import 'package:lavender/features/programs/data/models/quizzes/quiz_submission_response.dart';
import 'package:lavender/features/programs/exercises_details.dart';
import 'package:lavender/features/programs/presentation/course_one.dart';
import 'package:lavender/features/programs/presentation/first_quiz_screen.dart';
import 'package:lavender/features/programs/presentation/measurements_screen.dart';
import 'package:lavender/features/programs/presentation/music_player_screen.dart';
import 'package:lavender/features/programs/presentation/music_screen.dart';
import 'package:lavender/features/programs/presentation/quiz_result_screen.dart';
import 'package:lavender/features/programs/presentation/reviwes_screen.dart';
import 'package:lavender/features/search/presentation/search_screen.dart';
import 'package:lavender/features/sign_in/presentation/screens/sign_in.dart';
import 'package:lavender/features/sign_up/presentation/screens/login_or_signup_Screen.dart';
import 'package:lavender/features/sign_up/presentation/screens/sign_up.dart';
import 'package:lavender/features/splash/presenation/screens/select_language.dart';
import 'package:lavender/features/splash/presenation/screens/splash_timer_screen.dart';
import 'package:lavender/features/community/presentation/screen/stories_bar.dart';

import '../../features/home/data/models/specialist.dart';
import '../../features/home/presenation/screens/details_screen.dart';
import '../../features/programs/data/models/quizzes/quizzes_response.dart';
import '../../features/programs/presentation/Exercises_activities_screen.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashTimerScreen:
        return MaterialPageRoute(builder: (_) => SplashTimerScreen());
      case Routes.selectLanguage:
        return MaterialPageRoute(builder: (_) => SelectLanguage());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => ZoomMenuLayout());
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
      case Routes.musicScreen:
        return MaterialPageRoute(builder: (_) => MusicScreen());
      case Routes.quizResultScreen:
      // Extract the argument passed from Navigator.pushNamed
        final submissionResponse = settings.arguments as QuizSubmissionResponse;

        return MaterialPageRoute(
          builder: (_) => QuizResultScreen(
            // We pass the result directly from the previous API call
            result: submissionResponse.result,
          ),
        );      case Routes.searchScreen:
        return MaterialPageRoute(builder: (_) => SearchScreen());
      case Routes.paymentSuccess:
        return MaterialPageRoute(builder: (_) => PaymentSuccess());
      case Routes.musicPlayerScreen:
        final musicCardModel = settings.arguments as MusicCardModel;
        return MaterialPageRoute(
          builder: (_) => MusicPlayerScreen(musicCardModel: musicCardModel),
        );
      case Routes.reviewsScreen:
        final doctor = settings.arguments as DoctorBasicInfo;
        return MaterialPageRoute(builder: (_) => ReviewsScreen(doctor: doctor));
      case Routes.firstQuizScreen:
        final quizzes = settings.arguments as Quiz;
        return MaterialPageRoute(
          builder: (_) => FirstQuizScreen( initialQuiz: quizzes),
        );      /* case Routes.courseOne:
                final course = settings.arguments as CourseModel;
                return MaterialPageRoute(builder: (_) => CourseOne(
                  course: course,
                ));  */
      case Routes.userInfoProfile:
        return MaterialPageRoute(builder: (_) => UserInfoProfile());
      case Routes.courseOne:
        return MaterialPageRoute(builder: (_) => CourseOne());

      case Routes.paymentViewScreen:
        final payment = settings.arguments as PaymentResponse;
        return MaterialPageRoute(
          builder: (_) => PaymentViewScreen(paymentUrl: payment.url),
        );
      case Routes.commentScreen:
        final post = settings.arguments as Post;
        return MaterialPageRoute(
          builder: (_) => CommentScreen(postId: post.id),
        );

      case Routes.subscriptionPlanScreen:
       final payment = settings.arguments as PaymentResponse;
        return MaterialPageRoute(
          builder: (_) => SubscriptionPlanScreen(paymentUrl: payment.url),
        );
      case Routes.storiesBar:
        return MaterialPageRoute(builder: (_) => StoriesBar());
      case Routes.exercisesAndActivities:
        return MaterialPageRoute(builder: (_) => ExercisesActivitiesScreen());
      case Routes.exerciseDetails:
      // Retrieve the arguments passed during navigation
        final args = settings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(
          builder: (_) => ExercisesDetails(exerciseData: args),
        );
      // case Routes.musicPlayer:
      //   final args = settings.arguments as Map<String, dynamic>;
      //   return MaterialPageRoute(
      //     builder: (_) => MusicPlayerScreen(
      //       musicCardModel: args['currentSong'],
      //       playlist: args['playlist'], // Pass the full list here
      //     ),
      //   );
        default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(body: Center(child: Text('Page not found!'))),
        );
    }
  }
}
