import 'package:lavender/features/programs/data/models/activities/activity_model.dart';

abstract class ActivitiesState {}

class ActivitiesInitial extends ActivitiesState {}

class ActivitiesLoaded extends ActivitiesState {
  final List<ActivityModel> activities;
  final DateTime timestamp;
  ActivitiesLoaded(this.activities, this.timestamp);
}