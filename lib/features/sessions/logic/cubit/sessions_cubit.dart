import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/features/sessions/data/models/session_model.dart';
import 'sessions_state.dart';

class SessionsCubit extends Cubit<SessionsState> {
  SessionsCubit() : super(SessionsInitial());

  void loadSessions() {
    emit(SessionsLoading());
    // Mock Data matching screenshot
    final today = DateTime.now();

    final upcoming = [
      SessionModel(
        id: 1,
        doctorName: "د. خليل جمال",
        doctorImage:
            "doctors/1/profile_pic.png", // Example relative path from API
        specialty: "العلاج النفسي",
        date: today,
        time: "10:30 م",
        status: "Upcoming",
        isGroup: false,
      ),
      SessionModel(
        id: 2,
        doctorName: "د. خالد مطر",
        doctorImage: "doctors/2/profile_pic.png",
        specialty: "الصحة النفسية",
        date: today.add(const Duration(days: 2)),
        time: "10:30 م",
        status: "Upcoming",
        isGroup: false,
      ),
    ];

    final groups = [
      SessionModel(
        id: 3,
        doctorName: "د. نورة سعد",
        doctorImage: "doctors/3/profile_pic.png",
        specialty: "جلسة دعم جماعي",
        date: today.add(const Duration(days: 5)),
        time: "7:00 مساء",
        status: "Upcoming",
        isGroup: true,
        price: 150,
        groupImage: "programs/group_session.png",
        attendees: 5,
        maxAttendees: 20,
      ),
    ];

    emit(
      SessionsLoaded(
        upcomingSessions: upcoming,
        groupSessions: groups,
        selectedDate: today,
        selectedFilter: 'Upcoming',
      ),
    );
  }

  void updateFilter(String filter) {
    if (state is SessionsLoaded) {
      final currentState = state as SessionsLoaded;
      emit(
        SessionsLoaded(
          upcomingSessions: currentState.upcomingSessions,
          groupSessions: currentState.groupSessions,
          selectedDate: currentState.selectedDate,
          selectedFilter: filter,
        ),
      );
    }
  }

  void updateDate(DateTime date) {
    if (state is SessionsLoaded) {
      final currentState = state as SessionsLoaded;
      emit(
        SessionsLoaded(
          upcomingSessions: currentState.upcomingSessions,
          groupSessions: currentState.groupSessions,
          selectedDate: date,
          selectedFilter: currentState.selectedFilter,
        ),
      );
    }
  }
}
