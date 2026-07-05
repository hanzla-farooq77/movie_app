

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/services/movie_service.dart';

import '../models/movie_overview_model.dart';

final moviedetailprovider = Provider<MovieService>((ref) {
  return MovieService();
});

final moviedetail = FutureProvider.family<MovieDetailModel, int>((ref, id) {
  final movieservice = ref.read(moviedetailprovider);
  return movieservice.getMovieDetails(id);
});