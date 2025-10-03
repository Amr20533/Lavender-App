import 'package:flutter/material.dart';
import 'package:lavender/features/home/presenation/cubit/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/features/home/presenation/cubit/home_state.dart';
import '../../../core/routing/router.dart';
import '../widgets/doctor_card.dart';

class SpecialistSlider extends StatelessWidget {
  const SpecialistSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
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
            child: Center(child: Text(state.message)),
          );
        } else {
          return SliverToBoxAdapter(child: SizedBox());
        }
      },
    );
  }
}
