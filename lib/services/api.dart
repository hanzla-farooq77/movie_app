class ApiEndpoints {
  static const String apiKey = '3b64e39ad1fc34df915f1a4022869b20';

  static const String baseUrl = 'https://api.themoviedb.org/3';

  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  // Movies
  static const String trending = '$baseUrl/trending/movie/day?api_key=$apiKey';

  static const String popular = '$baseUrl/movie/popular?api_key=$apiKey';

  static const String topRated = '$baseUrl/movie/top_rated?api_key=$apiKey';

  static const String upcoming = '$baseUrl/movie/upcoming?api_key=$apiKey';

  // Search
  static String searchMovie(String query) =>
      '$baseUrl/search/movie?api_key=$apiKey&query=$query';

  // Movie Details
  static String movieDetails(int id) => '$baseUrl/movie/$id?api_key=$apiKey';

  // Similar Movies
  static String similarMovies(int id) =>
      '$baseUrl/movie/$id/similar?api_key=$apiKey';

  // Cast
  static String movieCredits(int id) =>
      '$baseUrl/movie/$id/credits?api_key=$apiKey';
}
