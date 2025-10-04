import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:lavender/core/routing/app_router.dart';
import 'package:lavender/core/routing/router.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/features/community/data/repositories/community_repo_impl.dart';
import 'package:lavender/features/community/presentaion/cubit/community_cubit.dart';
import 'package:lavender/features/favorites/data/repository/favorites_repository_impl.dart';
import 'package:lavender/features/favorites/presenation/cubit/favorit_cubit.dart';
import 'package:lavender/features/home/data/repositories/home_repo_impl.dart';
import 'package:lavender/features/home/presenation/cubit/home_cubit.dart';
import 'package:lavender/features/home/presenation/cubit/quote_cubit.dart';
import 'package:lavender/features/onbording/presentation/cubit/onbording_cubit.dart';
import 'package:lavender/features/profile/data/repositories/profile_repo_impl.dart';
import 'package:lavender/features/profile/presentation/cubit/current_user_cubit.dart';
import 'package:lavender/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:lavender/features/programs/data/repositories/music_repository_impl.dart';
import 'package:lavender/features/programs/data/repositories/quizzes_repository_impl.dart';
import 'package:lavender/features/programs/presentation/cubit/music_cubit.dart';
import 'package:lavender/features/programs/presentation/cubit/quiz_cubit.dart';
import 'package:lavender/features/search/data/repositories/search_repository_impl.dart';
import 'package:lavender/features/search/presentation/cubit/search_cubit.dart';
import 'package:lavender/features/sign_in/logic/use_cases/sign_in_usecase.dart';
import 'package:lavender/features/sign_in/logic/use_cases/sign_out_use_case.dart';
import 'package:lavender/features/sign_in/presentation/cubit/sign_in_cubit.dart';
import 'package:lavender/features/sign_up/data/repositories/auth_repository_impl.dart';
import 'package:lavender/features/sign_up/logic/use_cases/sign_up_usecase.dart';
import 'package:lavender/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:lavender/features/splash/presenation/cubit/splash_cubit.dart';

import 'core/cubits/day_cubit.dart';
import 'core/cubits/slot_cubit.dart';
class Lavender extends StatelessWidget {

  const Lavender({super.key, required this.appRouter, required this.box});
  final AppRouter appRouter;
  final Box box;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(374, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SplashCubit()),
        BlocProvider(
          create: (_) => OnbordingCubit(box)
            ..checkIfOnboardingCompleted(),
        ),
        BlocProvider(create: (_) => SlotCubit(),),
        BlocProvider(create: (_) => DayCubit(),),
        BlocProvider(create: (_) => SignInCubit(SignInUseCase(AuthRepositoryImpl()), SignOutUseCase(AuthRepositoryImpl())),),
        BlocProvider(create: (_) => SignUpCubit(SignUpUseCase(AuthRepositoryImpl(),),),),
        BlocProvider(create: (_) => HomeCubit(HomeRepositoryImpl())..fetchSpecialists()),
        BlocProvider(create: (_) => QuoteCubit(HomeRepositoryImpl())..fetchQuotes(),),
        BlocProvider(create: (_) => QuizCubit(QuizRepositoryImpl())..fetchMeasurementQuizzes(),),
        BlocProvider(create: (_) => MusicCubit(MusicRepositoryImpl())..fetchMusicCards()),
        BlocProvider(create: (_) => ProfileCubit(ProfileRepositoryImpl())..fetchUsers()),
        BlocProvider(create: (_) => CurrentUserCubit(ProfileRepositoryImpl())..fetchCurrentUser()),
        BlocProvider(create: (_) => PostsCubit(CommunityRepositoryImpl())..fetchPosts()),
        BlocProvider(create: (_) => SearchCubit(SearchRepositoryImpl())),
        BlocProvider(create: (_) => FavoritesCubit(FavoritesRepositoryImpl())..fetchFavorites()),
        ],
          child: MaterialApp(
           locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            initialRoute: Routes.splashTimerScreen,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: appRouter.generateRoute,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                centerTitle: true,
                shadowColor: AppColors.shadowColor,
                scrolledUnderElevation: 0,
                elevation: 0,
              )
            ),
          ),
        );
      },
    );
  }
}
