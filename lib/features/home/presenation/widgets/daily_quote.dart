import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/features/home/presenation/cubit/quote_cubit.dart';
import 'package:lavender/features/home/presenation/cubit/quote_state.dart';

class DailyQuote extends StatelessWidget {
  const DailyQuote({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "مقولة اليوم",
                  style: GoogleFonts.alexandria(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColorLavenderLangAndText,
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 190.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/Frame 1597882141 (1).png"),
                          fit: BoxFit.cover,
                        ),
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
                          shape: BoxShape.circle,
                        ),
                        child: BlocBuilder<QuoteCubit, QuoteState>(
                          builder: (context, state) {
                            if (state is QuotesLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is QuotesLoaded) {
                              final quote = state.quote.quote;
                              return Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      "${ApiConstants.imagePath}${quote.image}",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              );
                            } else if (state is QuotesError) {
                              return Center(
                                child: Text(
                                  state.message,
                                  style: const TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
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
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 14.h,
                                  ),
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
                    ),
                  ],
                ),
              ],
            ),
          );
  }
  }