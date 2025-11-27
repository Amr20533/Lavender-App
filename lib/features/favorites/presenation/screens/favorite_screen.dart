import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/core/routing/router.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/back_icon.dart';
import 'package:lavender/features/favorites/presenation/cubit/favorit_cubit.dart';
import 'package:lavender/features/favorites/presenation/cubit/favorit_state.dart';
import 'package:lavender/features/home/data/models/specialist.dart';
import 'package:lavender/features/home/presenation/cubit/home_cubit.dart';
import 'package:lavender/features/home/presenation/cubit/home_state.dart';
import 'package:lavender/features/home/presenation/widgets/doctor_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AlexText(text: "المفضلات"),
        toolbarHeight: 70,
        leading: BackIcon(
            onTap:(){
              Navigator.pushReplacementNamed(context, Routes.homeScreen,);
            }
        ),
      ),

      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, favState) {
          if (favState is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (favState is FavoritesLoaded) {
            final favs = favState.favoritesResponse.favorites;

            if (favs.isEmpty) {
              return const Center(
                child: Text("❤ No favorites yet", style: TextStyle(fontSize: 18)),
              );
            }

            // Get all specialists from HomeCubit
            final homeState = context.read<HomeCubit>().state;
            List<Specialist> allSpecialists = [];
            if (homeState is HomeLoaded) {
              allSpecialists = homeState.specialists.results.specialists;
            }

            // Match each favorite with its specialist
            final favSpecialists = favs
                .map((fav) {
              try {
                return allSpecialists.firstWhere(
                      (spec) => spec.user.id == fav.specialistId,
                );
              } catch (_) {
                return null;
              }
            })
                .whereType<Specialist>()
                .toList();
            return ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              itemCount: favSpecialists.length,
              separatorBuilder: (_, __) => SizedBox(height: 20,),
              itemBuilder: (context, index) {
                final specialist = favSpecialists[index];
              
                return DoctorCard(
                  specialist: specialist,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.psychologistDetailsPage,
                      arguments: specialist,
                    );
                  },
                );
              },
            );
          } else if (favState is FavoritesError) {
            return Center(child: Text("Error: ${favState.message}"));
          } else {
            return const Center(
              child: Text("❤ No favorites yet", style: TextStyle(fontSize: 18)),
            );
          }
        },
      ),
    );
  }
}
