import 'package:lavender/features/programs/data/models/course_model.dart';

abstract class CoursesRepository {
  Future<List<CourseModel>> getCourses();
}
