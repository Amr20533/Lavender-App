import 'package:lavender/features/home/data/models/specialist.dart';

class SearchResponse {
  final int count;
  final String? next;
  final String? previous;
  final ResultsWrapper results;

  SearchResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      count: json['count'] as int,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: ResultsWrapper.fromJson(json['results'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results.toJson(),
    };
  }

  @override
  String toString() {
    return 'SearchResponse(count: $count, next: $next, previous: $previous, results: $results)';
  }
}

class ResultsWrapper {
  final String status;
  final List<Specialist> specialists;

  ResultsWrapper({
    required this.status,
    required this.specialists,
  });

  factory ResultsWrapper.fromJson(Map<String, dynamic> json) {
    return ResultsWrapper(
      status: json['status'] as String,
      specialists: (json['specialists'] as List<dynamic>)
          .map((e) => Specialist.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'specialists': specialists.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'ResultsWrapper(status: $status, specialists: $specialists)';
  }
}
