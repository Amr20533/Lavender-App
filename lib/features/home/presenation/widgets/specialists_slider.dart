import 'package:flutter/material.dart';
import 'package:lavender/core/widget/exception_view.dart';
import 'package:lavender/features/community/presentation/widgets/doctor_card_shimmer.dart';
import 'package:lavender/features/home/presenation/cubit/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/features/home/presenation/cubit/home_state.dart';
import '../../../../core/routing/router.dart';
import 'doctor_card.dart';

class SpecialistSlider extends StatelessWidget {
  const SpecialistSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: const DoctorCardShimmer(),
                  );
                },
                childCount: 5, // Show 5 skeleton loaders
              ),
            ),
          );
        } else if (state is HomeLoaded) {
          final specialists = state.specialists.results.specialists;

          return SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final specialist = specialists[index];
                  return Column(
                    spacing: 16,
                    children: [
                      DoctorCard(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.psychologistDetailsPage,
                            arguments: specialist,
                          );
                        },
                        specialist: specialist,
                      ),
                      SizedBox(height: 12.h),  // separator
                    ],
                  );
                },
                childCount: specialists.length,
              ),
            ),
          );
        } else if (state is HomeError) {
          return SliverToBoxAdapter(
            child: ExceptionView(
              onPressed: () => context.read<HomeCubit>().fetchSpecialists(),
              message: state.message,
            ),
          );
        } else {
          return SliverToBoxAdapter(child: SizedBox());
        }
      },
    );
  }
}
