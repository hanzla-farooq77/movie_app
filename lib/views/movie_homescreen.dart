import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/providers/movie_provider.dart';
import 'package:movie_app/utils/Fluttertoast.dart';

import '../providers/search_movie.dart';

class MovieHomescreen extends ConsumerWidget {
  MovieHomescreen({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(trendingmoviesprovider, (previous, next) {
      next.whenOrNull(error: (e, s) => showToastMessage(e.toString()));
    });

    final movies = ref.watch(trendingmoviesprovider);
    final searchResults = ref.watch(searchProvider);
    final isSearching = searchController.text.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xFF0A0A0F),
            elevation: 0,
            pinned: true,
            floating: true,
            expandedHeight: 70,
            title: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFE50914), Color(0xFF8B0000)],
                    ),
                  ),
                  child: const Icon(Icons.play_arrow_rounded,
                      color: Colors.white, size: 20),
                ),
                const SizedBox(width: 10),
                const Text(
                  "UltraFlix",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF1B1B22),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      color: Colors.white70,
                      size: 19,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: searchController,
                      onChanged: (value) {
                        ref.read(searchProvider.notifier).searchMovies(value);
                      },
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                      cursorColor: Colors.redAccent,
                      decoration: InputDecoration(
                        hintText: "Search movies, shows...",
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.35),
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(Icons.search,
                            color: Colors.white54, size: 21),
                        suffixIcon: searchController.text.isNotEmpty
                            ? IconButton(
                          icon: const Icon(Icons.close,
                              color: Colors.white54, size: 19),
                          onPressed: () {
                            searchController.clear();
                            ref
                                .read(searchProvider.notifier)
                                .searchMovies("");
                          },
                        )
                            : null,
                        filled: true,
                        fillColor: const Color(0xFF1B1B22),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide:
                          const BorderSide(color: Colors.redAccent, width: 1.4),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // ---------- Featured banner (only when not searching) ----------
          if (!isSearching)
            movies.maybeWhen(
              data: (movieList) {
                if (movieList.isEmpty) return const SliverToBoxAdapter(child: SizedBox());
                final featured = movieList.first;
                return SliverToBoxAdapter(
                  child: _buildFeaturedBanner(context, featured),
                );
              },
              orElse: () => const SliverToBoxAdapter(child: SizedBox()),
            ),

          if (!isSearching)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(18, 22, 18, 12),
                child: Row(
                  children: [
                    Icon(Icons.local_fire_department_rounded,
                        color: Colors.redAccent, size: 20),
                    SizedBox(width: 6),
                    Text(
                      "Trending Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          if (isSearching)
            _buildGrid(searchResults, context)
          else
            movies.when(
              data: (movieList) => _buildGrid(movieList, context),
              loading: () => const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(color: Colors.redAccent),
                ),
              ),
              error: (e, s) => SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.error_outline, color: Colors.redAccent, size: 40),
                      SizedBox(height: 8),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'Something went wrong',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  Widget _buildFeaturedBanner(BuildContext context, dynamic movie) {
    final posterPath = movie.posterPath;
    final title = movie.title;
    final overview = movie.overview;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/detail', arguments: movie.id);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 230,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                posterPath != null && posterPath.isNotEmpty
                    ? Image.network(
                  "https://image.tmdb.org/t/p/w780$posterPath",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(color: const Color(0xFF1B1B22)),
                )
                    : Container(color: const Color(0xFF1B1B22)),

                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.4),
                        Colors.black.withOpacity(0.9),
                      ],
                      stops: const [0.3, 0.7, 1.0],
                    ),
                  ),
                ),

                Positioned(
                  top: 14,
                  left: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "FEATURED",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        overview.isNotEmpty ? overview : "No description available",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.75),
                          fontSize: 12.5,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 9),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.play_arrow_rounded,
                                    color: Colors.black, size: 18),
                                SizedBox(width: 4),
                                Text(
                                  "Play",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.all(9),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.3)),
                            ),
                            child: const Icon(Icons.info_outline,
                                color: Colors.white, size: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(List movieList, BuildContext context) {
    if (movieList.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.movie_filter_outlined,
                  color: Colors.white.withOpacity(0.2), size: 56),
              const SizedBox(height: 12),
              Text(
                "No movies found",
                style: TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.5)),
              ),
            ],
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 14,
          childAspectRatio: 0.6,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          final movie = movieList[index];
          if (movie.title.isEmpty) return const SizedBox.shrink();

          final posterPath = movie.posterPath;
          final title = movie.title;

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/detail', arguments: movie.id);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.35),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          posterPath != null && posterPath.isNotEmpty
                              ? Image.network(
                            "https://image.tmdb.org/t/p/w300$posterPath",
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return Container(
                                color: const Color(0xFF1B1B22),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: const Color(0xFF1B1B22),
                                child: const Icon(Icons.broken_image,
                                    color: Colors.white38, size: 36),
                              );
                            },
                          )
                              : Container(
                            color: const Color(0xFF1B1B22),
                            child: const Icon(Icons.movie,
                                color: Colors.white38, size: 36),
                          ),

                          // Rating badge (top-right corner)
                          if (movie.voteAverage != null && movie.voteAverage > 0)
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.65),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.star,
                                        color: Colors.amber, size: 11),
                                    const SizedBox(width: 2),
                                    Text(
                                      movie.voteAverage.toStringAsFixed(1),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          );
        }, childCount: movieList.length),
      ),
    );
  }
}