import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/features/home/presenation/cubit/home_cubit.dart';
import 'package:lavender/features/home/presenation/cubit/home_state.dart';
import 'package:lavender/features/home/presenation/cubit/quote_cubit.dart';
import 'package:lavender/features/home/presenation/cubit/quote_state.dart';
import 'package:lavender/features/home/widgets/alex_text.dart';
import 'package:lavender/features/home/widgets/specialists_card.dart';
import '../../../core/routing/router.dart';
import '../widgets/doctor_card.dart';
import '../widgets/view_all_row.dart';
import '../../../../l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 204,
                decoration: BoxDecoration(
                  color: AppColors.inActiveDateColor,
                  // gradient: AppColors.linearGradient,
                  borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(32),
                    bottomEnd: Radius.circular(32),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 190, top: 90),
                  child: SvgPicture.asset("assets/svg/Meditation Icon.svg"),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 60,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: const Color.fromARGB(142, 190, 151, 196),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(
                          "assets/images/Ellipse 1188.png",
                        ),
                      ),
                    ),

                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "صباح الخير",
                          style: GoogleFonts.alexandria(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                          ),
                        ),
                        Text("محمد حسن", style: GoogleFonts.alexandria(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white
                        )),
                      ],
                    ),
                    Spacer(),
                    // Image.asset("assets/icons/Frame 1597881900.png"),
                    SizedBox(width: 10),
                    // Image.asset("assets/icons/Frame 1597881901.png"),
                  ],
                ),
              ),

              Positioned(
                bottom: 15,
                right: 13,
                left: 13,
                child: Material(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.transparent,

                  child: CupertinoSearchTextField(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.doctorCardColor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    placeholder: "ابحث عن استشاري..".tr(),
                    placeholderStyle: TextStyle(
                      color: AppColors.grey4,
                    ),
                    prefixIcon: Icon(
                      Icons.search_outlined,
                      size: 25,
                      color: AppColors.doctorCardColor,
                    ),
                    //   suffixIcon: Icon(Icons.search_outlined,
                    // size: 25,
                    //  color: AppColors.doctorCardColor,
                    //   )
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 25.h),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                        Container(
                          height: 146.h,
                          width: 343.w,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 243, 243, 248),
                            borderRadius: BorderRadius.circular(15),
                          ),

                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text(
                                      "احصل علي دعم كامل لرحلتك في\n الباقة السنوية",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.purple300,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "اشترك الان",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primaryColorDarkText,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.arrow_forward_rounded),
                                        ),
                                      ],
                                    ),

                                    // DotsIndicator(itemCount: 3, currentIndex: 1),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Image.asset(
                                "assets/images/Frame 1597881905.png",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),

                        ViewAllRow(
                          title:
                          AppLocalizations.of(context)?.start_your_journey ??
                              "ابدأ رحلتك",
                          onTap: () {
                            Navigator.pushNamed(context, Routes.specialistScreen);
                          },
                        ),


                        Wrap(
                          spacing: 12.w,
                          runSpacing: 12.h,
                          children: [
                            SpecialistCard(
                              text: "اخصائي نفسي",
                              imagePath: "assets/images/Frame1_of_specialists.png",
                            ),
                            SpecialistCard(
                              text: "اخصائي تربوي للاطفال",
                              imagePath: "assets/images/Frame2_of_specialists.png",
                            ),
                            SpecialistCard(
                              text: "اخصائي مشاكل اسرية",
                              imagePath: "assets/images/Frame3_of_specialists.png",
                            ),
                            SpecialistCard(
                              text: "مشورة سرية",
                              imagePath: "assets/images/Frame4_of_specialists.png",
                            ),
                            SpecialistCard(
                              text: "اخصائي ADHD",
                              imagePath: "assets/images/Frame5_of_specialists.png",
                            ),
                            SpecialistCard(
                              text: "اخصائي التوحد",
                              imagePath: "assets/images/Frame6_of_specialists.png",
                            ),
                          ],
                        ),

                        ViewAllRow(
                          title:
                          AppLocalizations.of(context)?.start_your_journey ??
                              "افضل الاخصائيين",
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.allDoctorsScreen,
                            );
                          },
                        ),

                          BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
                            if (state is HomeLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (state is HomeLoaded) {
                              return ListView.separated(
                                itemCount: state.specialists.results.specialists.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (context, index) => SizedBox(height: 12.h),
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
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

                          Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AlexText(text: "مقولة اليوم"),
                            Stack(
                              alignment: Alignment.center,
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 190.h,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage("assets/images/Frame 1597882141 (1).png"), fit: BoxFit.cover),
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  child: Container(
                                    width: 55.w,
                                    height: 55.w,
                                    padding: EdgeInsets.all(5.sp),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                      shape: BoxShape.circle
                                    ),
                                    child: BlocBuilder<QuoteCubit, QuoteState>(
                                      builder: (context, state) {
                                        if (state is QuotesLoading) {
                                          return const Center(child: CircularProgressIndicator());
                                        } else if (state is QuotesLoaded) {
                                          final quote = state.quote.quote;
                                          return Container(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(image: NetworkImage("${ApiConstants.imagePath}${quote.image}"), fit: BoxFit.cover),
                                                shape: BoxShape.circle
                                            ),

                                          );
                                        } else if (state is QuotesError) {
                                          return Center(
                                            child: Text(
                                              state.message,
                                              style: const TextStyle(color: Colors.red),
                                            ),
                                          );
                                        }
                                        return const SizedBox.shrink();
                                      },
                                    )
                                  ),
                                ),
                                BlocBuilder<QuoteCubit, QuoteState>(
                                  builder: (context, state) {
                                    if (state is QuotesLoading) {
                                      return const Center(child: CircularProgressIndicator());
                                    } else if (state is QuotesLoaded) {
                                      final quote = state.quote.quote;
                                      return Align(
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                                              child: Text(
                                                quote.text,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.alexandria(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              quote.author,
                                              style: GoogleFonts.alexandria(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else if (state is QuotesError) {
                                      return Center(
                                        child: Text(
                                          state.message,
                                          style: const TextStyle(color: Colors.red),
                                        ),
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  },
                                )

                              ],
                            ),


                            ],
                          ),
                        ),

                      ],
                    )
            ),
          ),


        ],
      ),
    );
  }
}
