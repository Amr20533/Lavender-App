import 'package:lavender/features/appointments/data/models/payment_response.dart';

abstract class AppointmentRepo {
  Future<PaymentResponse> bookAppointment(int appointmentId);
}


