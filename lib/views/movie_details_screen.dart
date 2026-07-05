import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/providers/movie_detail_provider.dart';

class MovieDetailScreen extends ConsumerWidget {
  final int movieId;
  const MovieDetailScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(moviedetail(movieId));

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F14),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xFF0F0F14),
            expandedHeight: 260,
            pinned: true,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  details.maybeWhen(
                    data: (moviesDetail) {
                      return moviesDetail.backdropPath.isNotEmpty
                          ? Image.network(
                        "https://image.tmdb.org/t/p/w780${moviesDetail.backdropPath}",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(color: const Color(0xFF1B1B22));
                        },
                      )
                          : Container(color: const Color(0xFF1B1B22));
                    },
                    orElse: () => Container(color: const Color(0xFF1B1B22)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          const Color(0xFF0F0F14).withOpacity(0.9),
                          const Color(0xFF0F0F14),
                        ],
                        stops: const [0.4, 0.85, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          details.when(
            data: (moviesDetail) {
              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: moviesDetail.posterPath.isNotEmpty
                                ? Image.network(
                              "https://image.tmdb.org/t/p/w300${moviesDetail.posterPath}",
                              width: 110,
                              height: 160,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 110,
                                  height: 160,
                                  color: const Color(0xFF1B1B22),
                                  child: const Icon(Icons.broken_image,
                                      color: Colors.white38),
                                );
                              },
                            )
                                : Container(
                              width: 110,
                              height: 160,
                              color: const Color(0xFF1B1B22),
                              child: const Icon(Icons.movie,
                                  color: Colors.white38),
                            ),
                          ),
                          const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        moviesDetail.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.star,
                                    color: Colors.amber, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  moviesDetail.voteAverage
                                      .toStringAsFixed(1),
                                  style: const TextStyle(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      _infoRow(
                        Icons.calendar_today,
                        moviesDetail.releaseDate.isNotEmpty
                            ? moviesDetail.releaseDate
                            : "Unknown",
                      ),
                      _infoRow(
                        Icons.trending_up,
                        "Popularity: ${moviesDetail.popularity.toStringAsFixed(0)}",
                      ),
                      _infoRow(
                        Icons.calendar_today,
                        moviesDetail.genreIds.isNotEmpty
                            ? moviesDetail.genreIds.toString()
                            : "Genre Not Provided",
                      ),


                      const SizedBox(height: 14),

                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.play_arrow_rounded, size: 20),
                              label: const Text(
                                "Play Online",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE50914),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1B1B22),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                elevation: 0,
                                side: BorderSide(color: Colors.white.withOpacity(0.15)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Icon(Icons.download_outlined, size: 18),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      if (moviesDetail.genreIds.isNotEmpty)
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: moviesDetail.genreIds.map((id) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1B1B22),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white24),
                              ),
                              child: Text(
                                "Genre $id",
                                style: const TextStyle(
                                    color: Colors.white70, fontSize: 12),
                              ),
                            );
                          }).toList(),
                        ),

                      const SizedBox(height: 24),
                      const Text(
                        "Overview",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        moviesDetail.overview.isNotEmpty
                            ? moviesDetail.overview
                            : "No description available",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            error: (e, s) {
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline,
                          color: Colors.redAccent, size: 40),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'Something went wrong: ${e.toString()}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            loading: () => const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(color: Colors.redAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.white54, size: 15),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(color: Colors.white54, fontSize: 13)),
        ],
      ),
    );
  }
}