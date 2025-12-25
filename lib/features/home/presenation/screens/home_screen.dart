import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/features/home/presenation/widgets/daily_quote.dart';
import 'package:lavender/features/home/presenation/widgets/home_header.dart';
import 'package:lavender/features/home/presenation/widgets/specialists_slider.dart';
import 'package:lavender/features/home/presenation/widgets/subscription_card.dart';
import 'package:lavender/features/home/presenation/widgets/trip_cards.dart';
import '../../../../core/routing/router.dart';
import '../widgets/view_all_row.dart';
import '../../../../../l10n/app_localizations.dart';
import 'package:lavender/features/home/presenation/cubit/quote_cubit.dart';
import 'package:lavender/features/home/presenation/cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          final homeCubit = context.read<HomeCubit>();
          final quoteCubit = context.read<QuoteCubit>();

          await homeCubit.fetchSpecialists();
          await quoteCubit.fetchQuotes();
        },
        child: CustomScrollView(
          slivers: [
            // Header part: HomeHeader
            SliverToBoxAdapter(
              child: HomeHeader(),
            ),
            // Spacing
            SliverToBoxAdapter(
              child: SizedBox(height: 25.h),
            ),
            // Subscription Card
            SliverToBoxAdapter(
              child: SubscriptionCard(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 10.h),
            ),
            // ViewAllRow (first)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ViewAllRow(
                  title: AppLocalizations.of(context)?.start_your_journey ?? "ابدأ رحلتك",
                  onTap: () {
                    Navigator.pushNamed(context, Routes.specialistScreen);
                  },
                ),
              ),
            ),
            // TripCards
            SliverToBoxAdapter(
              child: TripCards(),
            ),
            // ViewAllRow (second)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 12),
                child: ViewAllRow(
                  title: AppLocalizations.of(context)?.start_your_journey ?? "افضل الاخصائيين",
                  onTap: () {
                    Navigator.pushNamed(context, Routes.allDoctorsScreen);
                  },
                ),
              ),
            ),

            SpecialistSlider(),

            // DailyQuote at bottom
            SliverToBoxAdapter(
              child: DailyQuote(),
            ),
          ],
        ),
      ),
    );
  }
}