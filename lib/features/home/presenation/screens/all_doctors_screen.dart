import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/routing/router.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/features/home/presenation/cubit/home_cubit.dart';
import 'package:lavender/features/home/presenation/cubit/home_state.dart';
import 'package:lavender/features/home/presenation/widgets/doctor_card.dart';

class AllDoctorsScreen extends StatelessWidget {
  const AllDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.w,
        title: Text("الاخصائيين"),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.purple500),
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 10, top: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return const Center(
                          child: CircularProgressIndicator());
                    } else if (state is HomeLoaded) {
                      return ListView.separated(
                        itemCount: state.specialists.results.specialists.length,
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        separatorBuilder: (context, index) => SizedBox(height: 12.h),
                        itemBuilder: (context, index) {
                          final specialist = state.specialists.results.specialists[index];
                          return DoctorCard(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.psychologistDetailsPage,
                                arguments: specialist,
                              );
                            },
                            specialist: specialist,
                            // name: "${specialist.user.firstName} ${specialist.user.lastName}",
                            // speciality: specialist.speciality,
                            // imageUrl: specialist.profilePic,
                          );
                        },
                      );
                    } else if (state is HomeError) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox.shrink();
                  }

              ),
            ],
          )
        ),
      ),
    );
  }
}