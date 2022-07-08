import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_generic/common/state_enum.dart';
import 'package:module_movie/data/datasources/bloc/movie_top_rated_bloc.dart';
import 'package:module_movie/presentation/widgets/movie/movie_card_list.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const routeName = '/top-rated-movie';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();

    // Provider
    // Future.microtask(() =>
    //     Provider.of<TopRatedMoviesNotifier>(context, listen: false)
    //         .fetchTopRatedMovies());

    // BLOC
    Future.microtask(
          () => context.read<TopRatedMoviesBloc>().add(const OnRequested()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TopRated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:

        // // Provider
        // Consumer<TopRatedMoviesNotifier>(
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
        BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
          builder: (context, state) {
            if (state is TopRatedMoviesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedMoviesHasData) {
              final result = state.result;
              return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = result[index];
                    return MovieCard(movie);
                  },
                  itemCount: result.length,
                ),
              );
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
      ),
    );
  }
}
