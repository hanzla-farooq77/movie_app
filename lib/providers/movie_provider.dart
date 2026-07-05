import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/services/movie_service.dart';

import '../models/movie_model.dart';

final movieserviceprovider = Provider<MovieService>((ref){
  return MovieService();
});

final trendingmoviesprovider = FutureProvider<List<MovieModel>>((ref){
  final movieservice = ref.read(movieserviceprovider);
  return movieservice.getTrendingMovies();
});