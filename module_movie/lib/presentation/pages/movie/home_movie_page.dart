import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_generic/common/constants.dart';
import 'package:module_movie/data/datasources/bloc/movie_list_bloc.dart';
import 'package:module_movie/data/datasources/bloc/movie_now_playing_bloc.dart';
import 'package:module_movie/data/datasources/bloc/movie_popular_bloc.dart';
import 'package:module_movie/data/datasources/bloc/movie_top_rated_bloc.dart';
import 'package:module_movie/domain/entities/movie/movie.dart';
import 'package:module_movie/presentation/pages/movie/movie_detail_page.dart';
import 'package:module_movie/presentation/pages/movie/search_movie_page.dart';
import 'package:module_movie/presentation/pages/movie/top_rated_movies_page.dart';

class HomeMoviePage extends StatefulWidget {
  static const routeName = '/home-movie';

  const HomeMoviePage({Key? key}) : super(key: key);

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      // Provider
      // () => Provider.of<MovieListNotifier>(context, listen: false)
      //   ..fetchNowPlayingMovies()
      //   ..fetchMovieList()
      //   ..fetchTopRatedMovies(),

      // BLOC
      () => context.read<MovieListBloc>()
        ..add(const OnRequestedNowPlayingMovies())
        ..add(const OnRequestedPopularMovies())
        ..add(const OnRequestedTopRatedMovies()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie List'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchMoviePage.routeName);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              // Consumer
              // Consumer<MovieListNotifier>(
              //   builder: (context, data, child) {
              //     final state = data.nowPlayingState;
              //     if (state == RequestState.Loading) {
              //       return const Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     } else if (state == RequestState.Loaded) {
              //       return MovieList(data.nowPlayingMovies);
              //     } else {
              //       return const Text('Failed');
              //     }
              //   },
              // ),

              // BLOC
              BlocBuilder<MovieListBloc, MovieListState>(
                builder: (context, state) {
                  if (state is NowPlayingMoviesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingMoviesHasData) {
                    final result = state.result;
                    return MovieList(result);
                  } else if (state is NowPlayingMoviesError) {
                    return Expanded(
                      child: Center(
                        child: Text(state.message),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Container(),
                    );
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, HomeMoviePage.routeName),
              ),

              // Consumer
              // Consumer<MovieListNotifier>(
              //   builder: (context, data, child) {
              //     final state = data.popularMoviesState;
              //     if (state == RequestState.Loading) {
              //       return const Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     } else if (state == RequestState.Loaded) {
              //       return MovieList(data.popularMovies);
              //     } else {
              //       return const Text('Failed');
              //     }
              //   },
              // ),

              // BLOC
              BlocBuilder<MovieListBloc, MovieListState>(
                builder: (context, state) {
                  if (state is PopularMoviesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularMoviesHasData) {
                    final result = state.result;
                    return MovieList(result);
                  } else if (state is PopularMoviesError) {
                    return Expanded(
                      child: Center(
                        child: Text(state.message),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Container(),
                    );
                  }
                },
              ),

              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.routeName),
              ),

              // Consumer
              // Consumer<MovieListNotifier>(
              //   builder: (context, data, child) {
              //     final state = data.topRatedMoviesState;
              //     if (state == RequestState.Loading) {
              //       return const Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     } else if (state == RequestState.Loaded) {
              //       return MovieList(data.topRatedMovies);
              //     } else {
              //       return const Text('Failed');
              //     }
              //   },
              // ),

              // BLOC
              BlocBuilder<MovieListBloc, MovieListState>(
                builder: (context, state) {
                  if (state is TopRatedMoviesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedMoviesHasData) {
                    final result = state.result;
                    return MovieList(result);
                  } else if (state is TopRatedMoviesError) {
                    return Expanded(
                      child: Center(
                        child: Text(state.message),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Container(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.routeName,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(const Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: movie.posterPath?.isEmpty ?? true
                      ? BLANK_POSTER
                      : '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
