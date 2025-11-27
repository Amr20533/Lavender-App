import 'package:meta/meta.dart';
import '../../data/models/payment_response.dart';

@immutable
abstract class AppointmentState {}

class AppointmentInitial extends AppointmentState {}

class AppointmentBookingLoading extends AppointmentState {}

class AppointmentBookingSuccess extends AppointmentState {
  final PaymentResponse paymentResponse;

  AppointmentBookingSuccess(this.paymentResponse);
}

class AppointmentBookingError extends AppointmentState {
  final String message;

  AppointmentBookingError(this.message);
}
