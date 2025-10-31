import 'package:lavender/features/home/data/models/quote_response.dart';
import 'package:lavender/features/home/data/models/specialists_response.dart';

abstract class HomeRepository {
  Future<SpecialistsResponse> getSpecialists();
  Future<QuoteResponse> getQuotes();
}


 