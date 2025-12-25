import 'package:lavender/features/programs/data/models/course_model.dart';
import 'package:lavender/features/programs/data/models/free_programs/free_program.dart';

abstract class CoursesState {}

class CoursesInitial extends CoursesState {}

class ProgramLoading extends CoursesState {}

class ProgramLoaded extends CoursesState {
  final List<FreeProgram> programs;
  ProgramLoaded(this.programs);
}

class ProgramError extends CoursesState {
  final String message;
  ProgramError(this.message);
}

class CoursesLoading extends CoursesState {}

class CoursesLoaded extends CoursesState {
  final List<CourseModel> courses;
  CoursesLoaded(this.courses);
}

class CoursesError extends CoursesState {
  final String message;
  CoursesError(this.message);
}
