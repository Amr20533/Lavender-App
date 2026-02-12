// class MusicCardModel {
//   final String id;
//   final String title;
//   final String author;
//   final String? album;
//   final String? albumCover;
//   final String audioUrl; // Renamed to match JSON key
//   final String duration; // The "00:00:00" string
//   final int durationSeconds; // Added for the Slider
//
//   MusicCardModel({
//     required this.id,
//     required this.title,
//     required this.author,
//     this.album,
//     this.albumCover,
//     required this.audioUrl,
//     required this.duration,
//     required this.durationSeconds,
//   });
//
//   factory MusicCardModel.fromJson(Map<String, dynamic> json) {
//     return MusicCardModel(
//       // Django UUIDs come as Strings
//       id: json["id"]?.toString() ?? "",
//       title: json["title"] ?? "Unknown Title",
//       author: json["author"] ?? "Unknown Artist",
//       album: json["album"],
//       albumCover: json["album_cover"], // DRF provides the full URL
//       audioUrl: json["audio_url"] ?? "",
//       duration: json["duration"] ?? "00:00:00",
//       durationSeconds: json["duration_seconds"] ?? 0,
//     );
//   }
// }


class MusicCardModel {
  final String id;
  final String title;
  final String author;
  final String? album;
  final String? albumCover;
  final String audioFile;
  final String duration;

  MusicCardModel({
    required this.id,
    required this.title,
    required this.author,
    this.album,
    this.albumCover,
    required this.audioFile,
    required this.duration,
  });

  factory MusicCardModel.fromJson(Map<String, dynamic> json) {
    return MusicCardModel(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      author: json["author"] ?? "",
      album: json["album"],
      albumCover: json["album_cover"],
      audioFile: json["audio_url"],
      // audioFile: json["audio_file"],
      duration: json["duration"] ?? "00:00:00",
    );
  }
}
