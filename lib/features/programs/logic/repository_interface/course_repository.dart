import 'package:lavender/features/programs/data/models/course_model.dart';
import '../../data/models/free_programs/free_program.dart';

abstract class CoursesRepository {
  Future<List<CourseModel>> getCourses();
  Future<List<FreeProgram>> getFreePrograms();
}
