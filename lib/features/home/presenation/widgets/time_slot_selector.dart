import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/core/cubits/slot_cubit.dart';
import 'package:lavender/core/helpers/format_helper.dart';
import '../../data/models/appointment.dart';
import 'time_slot.dart';

class TimeSlotSelector extends StatelessWidget {
  const TimeSlotSelector({
    super.key,
    required this.appointments,
    required this.selectedDate,
  });

  final List<Appointment> appointments;
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    // فلترة المواعيد بناءً على اليوم المختار
    final filteredSlots = appointments.where((slot) {
      DateTime date = DateTime.parse(slot.date);
      return date.year == selectedDate.year &&
          date.month == selectedDate.month &&
          date.day == selectedDate.day;
    }).toList();

    return BlocBuilder<SlotCubit, int?>(
      builder: (context, selectedIndex) {
        if (filteredSlots.isEmpty) {
          return const Center(child: Text("لا توجد مواعيد متاحة لهذا اليوم"));
        }

        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(filteredSlots.length, (index) {
            final slots = filteredSlots[index];
            return TimeSlot(
              label: "${FormatHelper.formatTime(slots.startTime)} - ${FormatHelper.formatTime(slots.endTime)}",
              booked: slots.isBooked,
              selected: selectedIndex == index,
              onTap: () {
                context.read<SlotCubit>().selectSlot(index);
              },
            );
          }),
        );
      },
    );
  }
}
