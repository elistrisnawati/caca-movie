import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_generic/common/constants.dart';
import 'package:module_generic/presentation/pages/about_page.dart';
import 'package:module_movie/data/datasources/bloc/movie_list/popular/movie_list_popular_bloc.dart';
import 'package:module_movie/domain/entities/movie/movie.dart';
import 'package:module_movie/presentation/pages/movie/home_movie_page.dart';
import 'package:module_movie/presentation/pages/movie/movie_detail_page.dart';
import 'package:module_movie/presentation/pages/movie/popular_movies_page.dart';
import 'package:module_movie/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:module_tv/data/datasources/bloc/tv_list/popular/tv_list_popular_bloc.dart';
import 'package:module_tv/presentation/pages/tv/home_tv_page.dart';
import 'package:module_tv/presentation/pages/tv/popular_tvs_page.dart';
import 'package:module_tv/presentation/pages/tv/search_tv_page.dart';
import 'package:module_tv/presentation/pages/tv/watchlist_tvs_page.dart';

class HomePage extends StatefulWidget {
  static const ROUTE_NAME = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    // Future.microtask(
    //   () => Provider.of<TvListNotifier>(context, listen: false)
    //     ..fetchPopularTvs(),
    // );

    // BLOC
    Future.microtask(
      () =>
          context.read<TvListPopularBloc>().add(const OnRequestedPopularTvs()),
    );

    // Provider
    // Future.microtask(
    //   () => Provider.of<MovieListNotifier>(context, listen: false)
    //     ..fetchPopularMovies(),
    // );

    // BLOC
    Future.microtask(
      () => context
          .read<MovieListPopularBloc>()
          .add(const OnRequestedPopularMovies()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('elis98@gmail.com'),
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('Tvs'),
              onTap: () {
                Navigator.pushNamed(context, HomeTvPage.routeName);
              },
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pushNamed(context, HomeMoviePage.routeName);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist (TVs)'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTvsPage.routeName);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist (Movies)'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.routeName);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.routeName);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSubHeading(
              title: 'Popular TV Series',
              onTap: () =>
                  Navigator.pushNamed(context, PopularTvsPage.routeName),
            ),

            // Provider
            // Consumer<TvListNotifier>(
            //   builder: (context, data, child) {
            //     final state = data.popularTvsState;
            //     if (state == RequestState.Loading) {
            //       return Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     } else if (state == RequestState.Loaded) {
            //       return TvList(data.popularTvs);
            //     } else {
            //       return Text('Failed');
            //     }
            //   },
            // ),

            // BLOC
            BlocBuilder<TvListPopularBloc, PopularTvsState>(
              builder: (context, state) {
                if (state is PopularTvsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularTvsHasData) {
                  final result = state.result;
                  return TvList(result);
                } else if (state is PopularTvsError) {
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
              title: 'Popular Movies',
              onTap: () =>
                  Navigator.pushNamed(context, PopularMoviesPage.routeName),
            ),

            // Provider
            // Consumer<MovieListNotifier>(
            //   builder: (context, data, child) {
            //     final state = data.popularMoviesState;
            //     if (state == RequestState.Loading) {
            //       return Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     } else if (state == RequestState.Loaded) {
            //       return MovieList(data.popularMovies);
            //     } else {
            //       return Text('Failed');
            //     }
            //   },
            // ),

            // BLOC
            BlocBuilder<MovieListPopularBloc, PopularMoviesState>(
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
          ],
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
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: movie.posterPath?.isEmpty ?? true
                      ? '$BLANK_POSTER'
                      : '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
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
