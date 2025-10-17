import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/core/routing/router.dart';
import 'package:lavender/core/widget/back_icon.dart';
import 'package:lavender/core/widget/custom_cached_network_image.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/features/programs/presentation/cubit/music_cubit.dart';
import 'package:lavender/features/programs/presentation/cubit/music_state.dart';

class MusicScreen extends StatelessWidget {
  const MusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AlexText(text: "الموسيقى"),
        toolbarHeight: 70,
        leading: BackIcon(),
      ),

      body: BlocBuilder<MusicCubit, MusicState>(
        builder: (context, state) {
          if (state is MusicLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MusicError) {
            return Center(child: Text("خطأ: ${state.message}"));
          } else if (state is MusicLoaded) {
            return ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: state.musicCards.length,
              separatorBuilder: (context, index) =>
              const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final music = state.musicCards[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: Hero(
                      tag: 'album_${music.id}',
                      child: CustomCachedNetworkImage(
                        imageUrl: music.albumCover,
                        width: 60,
                        height: 60,
                        borderRadius: 8,
                      ),
                    ),
                    title: Text(
                      music.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      "${music.author} • ${music.duration}",
                      style:
                      const TextStyle(color: Colors.grey, fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: const Icon(Icons.play_arrow,
                        color: Colors.blue, size: 28),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.musicPlayerScreen,
                        arguments: music,
                      );
                    },
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
