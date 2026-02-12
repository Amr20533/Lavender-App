import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/back_icon.dart';
import 'package:lavender/core/widget/custom_cached_network_image.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/features/programs/data/models/music_card_model.dart';
import 'package:lavender/features/programs/presentation/cubit/music_cubit.dart';
import 'package:lavender/features/programs/presentation/cubit/music_player_cubit.dart';
import 'package:lavender/features/programs/presentation/widgets/music_player_widget.dart';

class MusicPlayerScreen extends StatelessWidget {
  const MusicPlayerScreen({super.key, required this.musicCardModel});
  final MusicCardModel musicCardModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: AlexText(text: "الموسيقى", color: Colors.white,),
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        leading: BackIcon(),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: RefreshIndicator(
          onRefresh: () async {
            await context.read<MusicCubit>().fetchMusicCards();
          },
          backgroundColor: Colors.white,
          color: AppColors.primaryColorLavenderLangAndText,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: BlocProvider(
              create: (_) => MusicPlayerCubit(),
              child: Stack(
                children: [
                  // Fullscreen Background Image
                  Positioned.fill(
                    child: CustomCachedNetworkImage(
                      imageUrl: musicCardModel.albumCover,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Solid Shade Overlay
                  Positioned.fill(
                    child: Container(
                      color: AppColors.shadeColor,
                    ),
                  ),

                  MusicPlayerWidget(
                    title: musicCardModel.title,
                    author: musicCardModel.author,
                    albumCover: musicCardModel.albumCover,
                    audioFile: musicCardModel.audioFile,
                    musicId: musicCardModel.id,
                    album: musicCardModel.album ?? "فردي",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),    );
  }
}
