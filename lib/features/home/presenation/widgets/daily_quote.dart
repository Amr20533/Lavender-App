import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/features/home/presenation/cubit/quote_cubit.dart';
import 'package:lavender/features/home/presenation/cubit/quote_state.dart';
import 'package:lavender/features/home/presenation/widgets/quote_painter.dart';

class DailyQuote extends StatelessWidget {
  const DailyQuote({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
            padding: EdgeInsetsDirectional.only(start: 12.w,end: 12.w,bottom: 20),
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
                    SizedBox(
                      width: double.infinity,
                      height: 180.h,
                      child: CustomPaint(
                        painter: QuotePainter(),
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
                                child: AlexText(
                                 text:  state.message,
                                  fontSize: 12,
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
                          return Padding(
                            padding: EdgeInsets.only(
                              top: 50.h,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 12,
                              children: [
                                AlexText(
                                 text: quote.text,
                                  textAlign: TextAlign.center,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                                AlexText(
                                  text: quote.author,
                                    fontSize: 12.sp,
                                    color: AppColors.purple100,
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
                    PositionedDirectional(
                      bottom: -12,end: 30.w,
                    child: Image.asset("assets/images/quote_bottom_left.png"),
                    ),
                    PositionedDirectional(
                      top: 15,start: 30.w,
                      child: Image.asset("assets/images/quote_top_right.png"),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
  }

