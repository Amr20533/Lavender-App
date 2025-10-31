import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/back_icon.dart';
import 'package:lavender/core/widget/custom_botton.dart';
import 'package:lavender/features/programs/presentation/cubit/courses_cubit.dart';
import 'package:lavender/features/programs/presentation/cubit/courses_states.dart';
import 'package:lavender/features/programs/presentation/widgets/course_chapter_widget.dart';

class CourseOne extends StatefulWidget {
  const CourseOne({super.key});

  @override
  State<CourseOne> createState() => _CourseOneState();
}

class _CourseOneState extends State<CourseOne> {
  @override
  void initState() {
    super.initState();
    context.read<CoursesCubit>().fetchCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        shadowColor: AppColors.green1,
        title: AlexText(text: "كورس"),
        toolbarHeight: 70,
        leading: BackIcon(),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(3, 3, 10, 0),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.purple50.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.more_vert_sharp,
                color: AppColors.button,
                size: 26,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
          text: "اشترك الآن",
          textColor: AppColors.w,
          backgroundColor: AppColors.button,
          onPressed: () {
          },
        ),
      ),
      body: BlocBuilder<CoursesCubit, CoursesState>(
        builder: (context, state) {
          if (state is CoursesLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CoursesError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.message}',
                    textAlign: TextAlign.center,
                   // style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            );
          }
          if (state is CoursesLoaded) {
            if (state.courses.isEmpty) {
              return const Center(child: Text('No courses available'));
            }

            return ListView.builder(
              itemCount: state.courses.length,
              itemBuilder: (context, index) {
                final course = state.courses[index];

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.title,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.button,
                        ),
                      ),
                      SizedBox(height: 8.h),

                      Text(
                        "هتعرف ازاي تتصرف مع زملائك و ازاي تتعامل مع اي ضغط باستخدم استراتيجيات علمية مجربة .",
                       // course.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 18.sp,
                        ),
                      ),
                      SizedBox(height: 12.h),

                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20.r,
                            backgroundImage:
                                course.instructor.profilePic.isNotEmpty
                                    ? NetworkImage(course.instructor.profilePic)
                                    : null,
                            child:
                                course.instructor.profilePic.isEmpty
                                    ? const Icon(Icons.person)
                                    : null,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${course.instructor.user.firstName}${course.instructor.user.lastName}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                if (course.instructor.speciality.isNotEmpty)
                                  Text(
                                    course.instructor.speciality,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "سعر الكورس",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                '${course.price} EGP',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp,
                                  color: AppColors.button,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (course.image.isNotEmpty)
                            Image.asset("assets/images/Frame 1597882404.png"),

                          SizedBox(height: 12.h),

                          CourseChapterWidget(
                            chapter: "الفصل الأول:",
                            chapterTitle: "الاندماج",
                            lessons: [
                              LessonModel(
                                number: 1,
                                title:
                                    "كيفية التعامل مع الاختلافات الثقافية في بيئة العمل",
                                duration: "05:30 min",
                                isLocked: false,
                                hasLine: true,
                              ),
                              LessonModel(
                                number: 2,
                                title:
                                    "أهمية بناء علاقات إيجابية مع زملاء العمل",
                                duration: "05:30 min",
                                hasLine: true,
                              ),
                              LessonModel(
                                number: 3,
                                title:
                                    "استراتيجيات فعالة للاندماج السريع في فريق العمل",
                                duration: "05:30 min",
                              ),
                            ],
                          ),

                          SizedBox(height: 20),

                          CourseChapterWidget(
                            chapter: "الفصل الثاني:",
                            chapterTitle: "التكيف",
                            lessons: [
                              LessonModel(
                                number: 1,
                                title: "كيفية التكيف مع التغيرات في بيئة العمل",
                                duration: "05:30 min",
                                isLocked: true,
                                hasLine: true,
                              ),
                              LessonModel(
                                number: 2,
                                title: "طرق التعامل مع ضغوط العمل بشكل عملي",
                                duration: "05:30 min",
                                hasLine: true,
                              ),
                              LessonModel(
                                number: 3,
                                title:
                                    "نصائح من خبراء حول إدارة الوقت والمهام بكفاءة",
                                duration: "05:30 min",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
