import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:lavender/core/widget/alex_text.dart';
import 'package:lavender/core/widget/custom_cached_network_image.dart';
import 'package:lavender/core/widget/inter_text.dart';
import 'package:lavender/features/programs/presentation/cubit/music_player_cubit.dart';
import 'package:lavender/features/programs/presentation/cubit/music_player_states.dart';

class MusicPlayerWidget extends StatefulWidget {
  final String title;
  final String author;
  final String? albumCover;
  final String audioFile;
  final String musicId;
  final String album;

  const MusicPlayerWidget({
    super.key,
    required this.title,
    required this.album,
    required this.author,
    this.albumCover,
    required this.audioFile,
    required this.musicId,
  });

  @override
  State<MusicPlayerWidget> createState() => _MusicPlayerWidgetState();
}

class _MusicPlayerWidgetState extends State<MusicPlayerWidget> {
  @override
  void initState() {
    super.initState();
    context.read<MusicPlayerCubit>().play(widget.audioFile);
  }

  String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicPlayerCubit, MusicPlayerState>(
      builder: (context, state) {
        Duration current = Duration.zero;
        Duration total = const Duration(minutes: 3, seconds: 25);
        bool isPlaying = false;

        if (state is MusicPlayerPlaying) {
          current = state.currentDuration;
          total = state.totalDuration;
          isPlaying = true;
        } else if (state is MusicPlayerPaused) {
          current = state.currentDuration;
          total = state.totalDuration;
        }

        final totalSeconds = total.inSeconds;
        final currentSeconds = current.inSeconds.clamp(0, totalSeconds);

        final progress =
            (totalSeconds > 0) ? currentSeconds / totalSeconds : 0.0;

        return Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: AlexText(
                  text: widget.album,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),

              CustomCachedNetworkImage(
                imageUrl: widget.albumCover,
                width: 220,
                height: 220,
                borderRadius: 16,
                heroTag: 'album_${widget.musicId}',
              ),
              AlexText(text: widget.title, fontSize: 20, color: Colors.white),
              InterText(
                text: "Author Name: ${widget.author}",
                color: Colors.white,
              ),

              // Slider Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      formatDuration(current),
                      style: const TextStyle(fontSize: 12 , color:AppColors.w, ),
                    ),
                    Expanded(
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackShape: const RoundedRectSliderTrackShape(),
                          trackHeight: 6,
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 8,
                          ),
                          overlayShape: const RoundSliderOverlayShape(
                            overlayRadius: 14,
                          ),
                          activeTrackColor: Colors.white,
                          inactiveTrackColor: Colors.grey.shade400,
                          thumbColor: Colors.white,
                        ),
                        child: Slider(
                          value: currentSeconds.toDouble(),
                          max: totalSeconds.toDouble(),
                          onChanged: (value) {
                            context.read<MusicPlayerCubit>().seekTo(
                              Duration(seconds: value.toInt()),
                            );
                          },
                        ),
                      ),
                    ),
                    Text(
                      formatDuration(total),
                      style: const TextStyle(
                        fontSize: 12,
                        color:AppColors.w, 
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Control Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.shuffle, size: 28, color: AppColors.w),
                  const Icon(Icons.skip_previous, size: 36, color: AppColors.w),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 62,
                        height: 62,
                        child: CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 4,
                          backgroundColor: Colors.grey.shade300,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.button,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // context.read<MusicPlayerCubit>().togglePlayPause();
                          context.read<MusicPlayerCubit>().play(
                            widget.audioFile,
                          );
                        },
                        child: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 40,
                          color: AppColors.button,
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.skip_next, size: 36, color: AppColors.w),
                  const Icon(Icons.repeat, size: 28, color: AppColors.w),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
