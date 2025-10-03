import 'package:lavender/features/home/data/models/specialist.dart';

abstract class SearchRepository {
  Future<List<Specialist>> searchSpecialists(String query);
}
