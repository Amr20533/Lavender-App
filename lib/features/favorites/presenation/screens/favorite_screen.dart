import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/core/routing/router.dart';
import 'package:lavender/features/favorites/presenation/cubit/favorit_cubit.dart';
import 'package:lavender/features/favorites/presenation/cubit/favorit_state.dart';
import 'package:lavender/features/home/data/models/specialist.dart';
import 'package:lavender/features/home/widgets/doctor_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FavoritesLoaded) {
          final favs = state.favoritesResponse.favorites;

          if (favs.isEmpty) {
            return const Center(
              child: Text(
                "❤ No favorites yet",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.separated(
            itemCount: favs.length,
            separatorBuilder: (_, __) => Divider(),
            itemBuilder: (context, index) {
              final fav = favs[index];
              // final specialist =
              return Text('${fav.inFavorite}');
            },
          );
        } else if (state is FavoritesError) {
          return Center(child: Text("Error: ${state.message}"));
        } else {
          // state is FavoritesInitial
          return const Center(
            child: Text(
              "❤ No favorites yet",
              style: TextStyle(fontSize: 18),
            ),
          );
        }
      },
    );
  }
}
