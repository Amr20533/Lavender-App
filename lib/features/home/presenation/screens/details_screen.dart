import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/cubits/slot_cubit.dart';
import 'package:lavender/core/helpers/format_helper.dart';
import 'package:lavender/core/networking/api_constants.dart';
import 'package:lavender/core/routing/router.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/back_icon.dart';
import 'package:lavender/core/widget/custom_cached_network_image.dart';
import 'package:lavender/features/appointments/presentation/cubit/appointment_cubit.dart';
import 'package:lavender/features/appointments/presentation/cubit/appointment_state.dart';
import 'package:lavender/features/home/data/models/specialist.dart';
import 'package:lavender/features/home/presenation/widgets/info_card.dart';
import 'package:lavender/features/home/presenation/widgets/time_slot_selector.dart';
import 'package:lavender/features/programs/data/models/doctor_basic_info.dart';
import '../../../../core/cubits/day_cubit.dart';
import '../widgets/day_selector.dart';

class PsychologistDetailsPage extends StatefulWidget {
  const PsychologistDetailsPage({super.key, required this.specialist});
  final Specialist specialist;

  @override
  State<PsychologistDetailsPage> createState() =>
      _PsychologistDetailsPageState();
}

class _PsychologistDetailsPageState extends State<PsychologistDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 446,
            floating: true,
            pinned: true,
            // Optional: adds a smooth dark overlay so the bottom row is readable against the image
            backgroundColor: Colors.white,
            leading: BackIcon(),
            flexibleSpace: FlexibleSpaceBar(
              background: CustomCachedNetworkImage(
                imageUrl: "${ApiConstants.imagePath}${widget.specialist.profilePic}",
                fit: BoxFit.cover,
                // Note: Ensure heroTag is on the Image widget inside CustomCachedNetworkImage
                heroTag: "specialist_${widget.specialist.user.id}",
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(100.0),
              child: Container(
                padding: EdgeInsetsDirectional.only(start: 16),
                height: 100.0,
                // 2. Add scrolling to prevent overflow if text is long
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    // Note: 'spacing' is only available in very recent Flutter versions.
                    // If it fails, use SizedBox(width: 8) between items.
                    children: [
                      CategoryCard(
                        backgroundColor: AppColors.green1,
                        color: AppColors.green2,
                        text: "نشط الان",
                      ),
                      const SizedBox(width: 8),
                      CategoryCard(
                        backgroundColor: AppColors.button,
                        color: AppColors.purple50,
                        text: widget.specialist.speciality,
                      ),
                      const SizedBox(width: 8),
                      CategoryCard(
                        backgroundColor: AppColors.orang2,
                        color: AppColors.orang,
                        text: widget.specialist.extraSpecialty,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          /// Body content
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "مرحباً 👋",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "أنا ${widget.specialist.user.firstName} ${widget.specialist.user.lastName}",
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: Colors.indigo),
                        ),
                        GestureDetector(
                          onTap: () async {
                            // نروح لصفحة التقييم ونستنى النتيجة (النجوم الجديدة)
                            final newRating = await Navigator.pushNamed(
                              context,
                              Routes.reviewsScreen,
                              arguments: DoctorBasicInfo.fromSpecialist(
                                widget.specialist,
                              ),
                            );

                            // لو المستخدم رجع تقييم جديد (يعني ضغط "إرسال التقييم")
                            if (newRating != null && newRating is double) {
                              setState(() {
                                //  widget.specialist.avgRating = newRating; // ← نحدّث التقييم المعروض
                              });
                            }
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber),
                              const SizedBox(width: 4),
                              Text(
                                "${widget.specialist.avgRating}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      spacing: 10.w,
                      children: [
                        Icon(
                          Icons.watch_later_outlined,
                          color: AppColors.grey,
                          size: 20.sp,
                        ),
                        Text(
                          // "${widget.specialist.appointments.first.startTime} ${widget.specialist.appointments.first.endTime}",
                          "03:00 ص - 08:00 ص",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    /// Description
                    Text(
                      widget.specialist.bio,
                      style: TextStyle(color: Colors.grey[800], height: 1.5),
                    ),
                    const SizedBox(height: 16),

                    /// Info stats
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InfoCard(
                          title: "${widget.specialist.yearsOfExperience} سنين",
                          subtitle: "خبرة",
                          icon: 'medal-star.png',
                        ),
                        InfoCard(
                          title: "50+",
                          subtitle: "المعالجون",
                          icon: 'emoji-normal.png',
                        ),
                        InfoCard(
                          title:
                          "${FormatHelper.removeExtraDots(widget.specialist.pricePerHour)} جنيه",
                          subtitle: "سعر الساعة",
                          icon: 'moneys.png',
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(spacing: 7,
                      children: [
                        Image.asset('assets/icons/calendar.png', cacheWidth: 800, width: 22,height: 22,),
                        AlexText(text: "اختر الميعاد")
                      ],
                    ),
                    const SizedBox(height: 24),

                    DaySelector(),
                    const SizedBox(height: 24),

                    /// Schedule
                    /// Schedule
                    Row(spacing: 7,
                      children: [
                        Image.asset('assets/icons/note-favorite.png', cacheWidth: 800, width: 22,height: 22,),
                        AlexText(text: "الجدول")
                      ],
                    ),
                    const SizedBox(height: 12),
                    BlocBuilder<DayCubit, DateTime>(
                      builder: (context, selectedDate) {
                        return TimeSlotSelector(
                          appointments: widget.specialist.appointments,
                          selectedDate: selectedDate,
                        );
                      },
                    ),
                    const SizedBox(height: 32),

                    /// Button
                    SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: BlocConsumer<AppointmentCubit, AppointmentState>(
                        listener: (context, state) {
                          if (state is AppointmentBookingSuccess) {
                            Navigator.of(context).pushNamed(Routes.paymentViewScreen, arguments: state.paymentResponse);
                            // Navigator.of(context).pushNamed(Routes.subscriptionPlanScreen, arguments: state.paymentResponse);
                          }
                        },
                        builder: (context, state) {
                          if (state is AppointmentBookingLoading) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColorLavenderLangAndText,
                              ),
                            );
                          }

                          return BlocBuilder<SlotCubit, int?>(
                            builder: (context, selectedSlot) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColorLavenderLangAndText,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28.sp),
                                  ),
                                ),
                                onPressed: () {
                                  if (selectedSlot != null) {
                                    context.read<AppointmentCubit>().bookAppointment(selectedSlot);
                                  } else {
                                    debugPrint("Please select an available slot");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("من فضلك اختر موعدًا أولاً")),
                                    );
                                  }
                                },
                                child: AlexText(
                                  text: "احجز استشارة",
                                  color: Colors.white,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.backgroundColor,
    required this.color,
    required this.text,
  });

  final Color backgroundColor;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: AlexText(
              text: text,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}