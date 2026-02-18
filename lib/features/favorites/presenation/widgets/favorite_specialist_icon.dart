import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/circularIcon.dart';
import 'package:lavender/features/favorites/presenation/cubit/favorit_cubit.dart';
import 'package:lavender/features/favorites/presenation/cubit/favorit_state.dart';
import 'package:lavender/features/home/data/models/specialist.dart';

class FavoriteSpecialistIcon extends StatelessWidget {
  const FavoriteSpecialistIcon({
    super.key,
    required this.specialist,
  });

  final Specialist specialist;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, favState) {
        bool isFavorite = false;

        if (favState is FavoritesLoaded) {
          isFavorite = favState.favoritesResponse.favorites
              .any((f) => f.specialistId == specialist.user.id);
        }

        return GestureDetector(
          child: CircularIcon(icon: !isFavorite ? "heart.png" : "heart_filled.png",color: Colors.white,),
          onTap: () {
            context.read<FavoritesCubit>().toggleFavorite(specialist.user.id);
          },
        );
        // return IconButton(
        //   icon: Icon(
        //     isFavorite ? Icons.favorite : Icons.favorite_border,
        //     color: isFavorite ? Colors.red : Colors.grey,
        //     size: 22.sp,
        //   ),
        //   onPressed: () {
        //     context.read<FavoritesCubit>().toggleFavorite(specialist.user.id);
        //   },
        // );
      },
    );
  }
}
