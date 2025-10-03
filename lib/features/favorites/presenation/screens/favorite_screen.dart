import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/features/favorites/presenation/cubit/favorit_cubit.dart';
import 'package:lavender/features/home/data/models/specialist.dart';
import 'package:lavender/features/home/presenation/widgets/doctor_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
      body: BlocBuilder<FavoritesCubit, List<Specialist>>(
        builder: (context, specialists) {
          if (specialists.isEmpty) {
            return const Center(
              child: Text(
                "❤No favorites yet",
                style: TextStyle(fontSize: 18),
              ),
            );
          }
         
          return ListView.builder(
            itemCount: specialists.length,
            itemBuilder: (context, index) {
              final specialist = specialists[index];
              return DoctorCard(
               specialist: specialist,
               onTap: (){
                
               },
              );
            },
          );
        },
     ),
);
}
}