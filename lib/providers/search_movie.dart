import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/movie_model.dart';
import '../services/movie_service.dart';

final searchProvider = StateNotifierProvider<SearchNotifier, List<MovieModel>>((
  ref,
) {
  return SearchNotifier();
});

class SearchNotifier extends StateNotifier<List<MovieModel>> {
  SearchNotifier() : super([]);

  final MovieService service = MovieService();

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      state = [];
      return;
    }

    try {
      final results = await service.searchMovies(query);
      state = results;
    } catch (e) {
      state = [];
    }
  }

  void clear() {
    state = [];
  }
}
