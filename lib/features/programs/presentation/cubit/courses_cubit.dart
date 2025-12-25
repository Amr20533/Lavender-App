import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/features/programs/logic/repository_interface/course_repository.dart';
import 'package:lavender/features/programs/presentation/cubit/courses_states.dart';

class CoursesCubit extends Cubit<CoursesState> {
  final CoursesRepository repository;

  CoursesCubit(this.repository) : super(CoursesInitial());

  Future<void> fetchFreePrograms() async {
    emit(ProgramLoading());
    try {
      final programs = await repository.getFreePrograms();
      emit(ProgramLoaded(programs));
    } catch (e) {
      emit(ProgramError(e.toString()));
    }
  }

  // Future<void> fetchCourses() async {
  //   emit(CoursesLoading());
  //   try {
  //     final courses = await repository.getCourses();
  //     emit(CoursesLoaded(courses));
  //   } catch (e) {
  //     emit(CoursesError(e.toString()));
  //   }
  // }
}
