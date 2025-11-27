import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/back_icon.dart';
import 'package:lavender/core/widget/custom_cached_network_image.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/features/programs/data/models/music_card_model.dart';
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
      body: Container(
        height: 812.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),

        ),
        child: BlocProvider(
          create: (_) => MusicPlayerCubit(),
          child: Stack(
            children: [
              // Fullscreen blurred background
              Positioned.fill(
                child: CustomCachedNetworkImage(
                  imageUrl: musicCardModel.albumCover,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: AppColors.shadowColor,
                  ),
                ),
              ),

              MusicPlayerWidget(
                title: musicCardModel.title,
                author: musicCardModel.author,
                albumCover: musicCardModel.albumCover,
                audioFile: "icons/moral_story.mp3",
                // audioFile: musicCardModel.audioFile,
                musicId: musicCardModel.id,
                album: musicCardModel.album!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
