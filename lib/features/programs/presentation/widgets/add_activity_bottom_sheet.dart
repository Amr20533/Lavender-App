import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/features/programs/logic/cubit/activities_cubit.dart';
import 'package:lavender/features/programs/data/models/activities/activity_model.dart';

class AddActivityBottomSheet extends StatefulWidget {
  const AddActivityBottomSheet({super.key});

  @override
  State<AddActivityBottomSheet> createState() => _AddActivityBottomSheetState();
}

class _AddActivityBottomSheetState extends State<AddActivityBottomSheet> {
  final TextEditingController _nameController = TextEditingController();
  IconData _selectedIcon = Icons.sentiment_satisfied_alt_rounded;

  final List<Map<String, dynamic>> _icons = [
    {'icon': Icons.sentiment_satisfied_alt_rounded, 'label': 'افتراضي'},
    {'icon': Icons.music_note_outlined, 'label': 'الموسيقى'},
    {'icon': Icons.directions_run_rounded, 'label': 'المشي'},
    {'icon': Icons.self_improvement_rounded, 'label': 'التنفس'},
    {'icon': Icons.book_outlined, 'label': 'القراءة'},
    {'icon': Icons.opacity_rounded, 'label': 'مياه'},
    {'icon': Icons.work_outline_rounded, 'label': 'عمل'},
    {'icon': Icons.home_outlined, 'label': 'منزلي'},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.r),
          topRight: Radius.circular(32.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 20.h),
              AlexText(
                text: "اضافة نشاط",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.button,
              ),
              SizedBox(height: 24.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AlexText(
                    text: "اسم النشاط",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  SizedBox(height: 8.h),
                  TextField(
                    controller: _nameController,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: "مثال : شرب المياه",
                      hintStyle: GoogleFonts.alexandria(
                        fontSize: 12.sp,
                        color: Colors.grey.shade400,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AlexText(
                    text: "اختار ايقونة",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  SizedBox(height: 16.h),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 16.h,
                      crossAxisSpacing: 16.w,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: _icons.length,
                    itemBuilder: (context, index) {
                      final item = _icons[index];
                      final isSelected = _selectedIcon == item['icon'];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIcon = item['icon'];
                            _nameController.text = item['label'];
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color:
                                isSelected
                                    ? Colors.transparent
                                    : Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color:
                                  isSelected
                                      ? AppColors.button
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                item['icon'],
                                color:
                                isSelected
                                    ? AppColors.button
                                    : Colors.black54,
                                size: 24.sp,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            AlexText(
                              text: item['label'],
                              fontSize: 11,
                              color:
                              isSelected
                                  ? AppColors.button
                                  : Colors.black54,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_nameController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const AlexText(
                                text: "يرجى إدخال اسم النشاط",
                                color: Colors.white,
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: Colors.red.withOpacity(0.8),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              margin: EdgeInsets.all(20.w),
                              elevation: 0,
                            ),
                          );
                          return;
                        }

                        final now = DateTime.now();
                        final hour =
                        now.hour > 12
                            ? now.hour - 12
                            : (now.hour == 0 ? 12 : now.hour);
                        final period = now.hour >= 12 ? "م" : "ص";
                        final timeStr =
                            "$hour:${now.minute.toString().padLeft(2, '0')} $period";

                        final newActivity = ActivityModel(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          title: _nameController.text.trim(),
                          time: timeStr,
                          icon: _selectedIcon,
                        );

                        try {
                          context.read<ActivitiesCubit>().addActivity(
                            newActivity,
                          );
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const AlexText(
                                text: "تم إضافة النشاط بنجاح",
                                color: Colors.white,
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: AppColors.button.withOpacity(
                                0.8,
                              ),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              margin: EdgeInsets.all(20.w),
                              elevation: 0,
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const AlexText(
                                text: "حدث خطأ أثناء حفظ النشاط",
                                color: Colors.white,
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: Colors.red.withOpacity(0.8),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              margin: EdgeInsets.all(20.w),
                              elevation: 0,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.button,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                      ),
                      child: AlexText(
                        text: "حفظ البيانات",
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade100,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                      ),
                      child: AlexText(
                        text: "الغاء",
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}