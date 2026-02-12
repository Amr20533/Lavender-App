import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/features/programs/data/models/activities/activity_model.dart';
import 'activities_state.dart';

class ActivitiesCubit extends Cubit<ActivitiesState> {
  ActivitiesCubit() : super(ActivitiesInitial());

  void loadActivities() {
    emit(ActivitiesLoaded(ActivityModel.defaultActivities, DateTime.now()));
  }

  void toggleActivity(String id) {
    if (state is ActivitiesLoaded) {
      final currentState = state as ActivitiesLoaded;
      final updatedActivities =
      currentState.activities.map((activity) {
        if (activity.id == id) {
          return activity.copyWith(isCompleted: !activity.isCompleted);
        }
        return activity;
      }).toList();
      emit(ActivitiesLoaded(updatedActivities, DateTime.now()));
    }
  }

  void addActivity(ActivityModel activity) {
    if (state is ActivitiesLoaded) {
      final currentState = state as ActivitiesLoaded;
      final updatedActivities = List<ActivityModel>.from(
        currentState.activities,
      )..add(activity);
      emit(ActivitiesLoaded(updatedActivities, DateTime.now()));
    }
  }
}