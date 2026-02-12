import 'package:lavender/features/sessions/data/models/session_model.dart';

abstract class SessionsState {}

class SessionsInitial extends SessionsState {}

class SessionsLoading extends SessionsState {}

class SessionsLoaded extends SessionsState {
  final List<SessionModel> upcomingSessions;
  final List<SessionModel> groupSessions;
  final DateTime selectedDate;
  final String selectedFilter; // 'Upcoming', 'Completed', 'Cancelled'

  SessionsLoaded({
    required this.upcomingSessions,
    required this.groupSessions,
    required this.selectedDate,
    required this.selectedFilter,
  });
}

class SessionsError extends SessionsState {
  final String message;
  SessionsError(this.message);
}
