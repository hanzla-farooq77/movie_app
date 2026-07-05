import 'package:dio/dio.dart';
import 'package:movie_app/models/cast_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/movie_overview_model.dart';
import 'api.dart';

class MovieService {
  final Dio dio = Dio();

  // Trending Movies
  Future<List<MovieModel>> getTrendingMovies() async {
    try {
      final response = await dio.get(ApiEndpoints.trending);

      if (response.statusCode == 200) {
        final List movies = response.data['results'];

        return movies
            .map((movie) => MovieModel.fromJson(movie))
            .toList();
      } else {
        throw Exception('Failed to load Trending Movies');
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  // Popular Movies
  Future<List<MovieModel>> getPopularMovies() async {
    try {
      final response = await dio.get(ApiEndpoints.popular);

      if (response.statusCode == 200) {
        final List movies = response.data['results'];

        return movies
            .map((movie) => MovieModel.fromJson(movie))
            .toList();
      } else {
        throw Exception('Failed to load Popular Movies');
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  // Top Rated Movies
  Future<List<MovieModel>> getTopRatedMovies() async {
    try {
      final response = await dio.get(ApiEndpoints.topRated);

      if (response.statusCode == 200) {
        final List movies = response.data['results'];

        return movies
            .map((movie) => MovieModel.fromJson(movie))
            .toList();
      } else {
        throw Exception('Failed to load Top Rated Movies');
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  // Upcoming Movies
  Future<List<MovieModel>> getUpcomingMovies() async {
    try {
      final response = await dio.get(ApiEndpoints.upcoming);

      if (response.statusCode == 200) {
        final List movies = response.data['results'];

        return movies
            .map((movie) => MovieModel.fromJson(movie))
            .toList();
      } else {
        throw Exception('Failed to load Upcoming Movies');
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  // Search Movies
  Future<List<MovieModel>> searchMovies(String query) async {
    try {
      final response = await dio.get(
        ApiEndpoints.searchMovie(query),
      );

      if (response.statusCode == 200) {
        final List movies = response.data['results'];

        return movies
            .map((movie) => MovieModel.fromJson(movie))
            .toList();
      } else {
        throw Exception('Failed to search Movies');
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  // Movie Details
  Future<MovieDetailModel> getMovieDetails(int id) async {
    try {
      final response = await dio.get(
        ApiEndpoints.movieDetails(id),
      );

      if (response.statusCode == 200) {
        return MovieDetailModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load Movie Details');
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  // Movie Cast
  Future<List<CastModel>> getMovieCast(int id) async {
    try {
      final response = await dio.get(
        ApiEndpoints.movieCredits(id),
      );

      if (response.statusCode == 200) {
        final List cast = response.data['cast'];

        return cast
            .map((actor) => CastModel.fromJson(actor))
            .toList();
      } else {
        throw Exception('Failed to load Movie Cast');
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}