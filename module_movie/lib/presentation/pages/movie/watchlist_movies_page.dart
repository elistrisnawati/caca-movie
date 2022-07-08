import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_movie/data/datasources/bloc/watchlist/movie_watchlist_bloc.dart';
import 'package:module_movie/presentation/widgets/movie/movie_card_list.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const routeName = '/watchlist-movie';

  const WatchlistMoviesPage({Key? key}) : super(key: key);

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();

    // Provider
    // Future.microtask(() =>
    //     Provider.of<WatchlistMoviesNotifier>(context, listen: false)
    //         .fetchWatchlistMovies());

    // BLOC
    Future.microtask(
      () => context.read<WatchlistMoviesBloc>().add(const OnRequested()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:

            // // Provider
            // Consumer<WatchlistMoviesNotifier>(
            //   builder: (context, data, child) {
            //     if (data.state == RequestState.Loading) {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     } else if (data.state == RequestState.Loaded) {
            //       return ListView.builder(
            //         itemBuilder: (context, index) {
            //           final movie = data.movies[index];
            //           return MovieCard(movie);
            //         },
            //         itemCount: data.movies.length,
            //       );
            //     } else {
            //       return Center(
            //         key: Key('error_message'),
            //         child: Text(data.message),
            //       );
            //     }
            //   },
            // ),

            // BLOC
            BlocBuilder<WatchlistMoviesBloc, WatchlistMoviesState>(
          builder: (context, state) {
            if (state is WatchlistMoviesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistMoviesHasData) {
              final result = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = result[index];
                  return MovieCard(movie);
                },
                itemCount: result.length,
              );
            } else if (state is WatchlistMoviesError) {
              return Center(child: Text(state.message));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
