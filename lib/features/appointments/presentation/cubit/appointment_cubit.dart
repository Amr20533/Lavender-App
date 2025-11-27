import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/features/appointments/data/repositories/appointment_repo_impl.dart';
import 'package:lavender/features/appointments/presentation/cubit/appointment_state.dart';
import '../../data/models/payment_response.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final AppointmentRepositoryImpl repository;

  AppointmentCubit(this.repository) : super(AppointmentInitial());

  Future<void> bookAppointment(int appointmentId) async {
    try {
      emit(AppointmentBookingLoading());

      final PaymentResponse response = await repository.bookAppointment(appointmentId);

      emit(AppointmentBookingSuccess(response));
    } catch (e) {
      emit(AppointmentBookingError(e.toString()));
    }
  }
}
