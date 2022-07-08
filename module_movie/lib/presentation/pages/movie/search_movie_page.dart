import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_generic/common/constants.dart';
import 'package:module_movie/presentation/bloc/search/movie_search_bloc.dart';
import 'package:module_movie/presentation/widgets/movie/movie_card_list.dart';

class SearchMoviePage extends StatelessWidget {
  static const routeName = '/search-movie';

  const SearchMoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                // Provider
                // Provider.of<MovieSearchNotifier>(context, listen: false)
                //     .fetchMovieSearch(query);

                // BLOC
                context.read<MovieSearchBloc>().add(OnQueryChanged(query));
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),

            // // Consumer
            // Consumer<MovieSearchNotifier>(
            //   builder: (context, data, child) {
            //     if (data.state == RequestState.Loading) {
            //       return Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     } else if (data.state == RequestState.Loaded) {
            //       final result = data.searchResult;
            //       return Expanded(
            //         child: ListView.builder(
            //           padding: const EdgeInsets.all(8),
            //           itemBuilder: (context, index) {
            //             final movie = data.searchResult[index];
            //             return MovieCard(movie);
            //           },
            //           itemCount: result.length,
            //         ),
            //       );
            //     } else {
            //       return Expanded(
            //         child: Container(),
            //       );
            //     }
            //   },
            // ),

            // BlocBuilder
            BlocBuilder<MovieSearchBloc, MovieSearchState>(
              builder: (context, state) {
                if (state is MovieSearchLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MovieSearchHasData) {
                  final result = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final movie = result[index];
                        return MovieCard(movie);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else if (state is MovieSearchError) {
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
}
