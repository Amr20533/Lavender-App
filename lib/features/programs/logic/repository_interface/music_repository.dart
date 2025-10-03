import 'package:lavender/features/programs/data/models/music_card_model.dart';

abstract class MusicRepository {
  Future<List<MusicCardModel>> getMusicCards();
}
