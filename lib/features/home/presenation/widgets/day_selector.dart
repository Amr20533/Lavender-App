import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/core/cubits/day_cubit.dart';
import 'day_chip.dart';

class DaySelector extends StatelessWidget {
  const DaySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DayCubit, DateTime>(
      builder: (context, selectedDate) {
        final weekData = context.read<DayCubit>().getCurrentWeekDaysAndDates();
        final days = weekData["days"]!;
        final dates = weekData["dates"]!;

        return SizedBox(
          height: 68,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: days.length,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              // التاريخ الفعلي
              final date = DateTime.now().add(Duration(days: index));

              return DayChip(
                day: days[index],
                date: dates[index],
                selected: date.day == selectedDate.day &&
                    date.month == selectedDate.month &&
                    date.year == selectedDate.year,
                onTap: () {
                  context.read<DayCubit>().selectDay(date);
                },
              );
            },
          ),
        );
      },
    );

  }

}
