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
      audioFile: json["audio_file"],
      duration: json["duration"] ?? "00:00:00",
    );
  }
}
