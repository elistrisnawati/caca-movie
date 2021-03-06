import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:module_generic/common/constants.dart';
import 'package:module_generic/domain/entities/genre.dart';
import 'package:module_movie/domain/entities/movie/movie.dart';
import 'package:module_movie/domain/entities/movie/movie_detail.dart';
import 'package:module_movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:module_movie/presentation/bloc/movie_detail/recommendation/movie_detail_recommendation_bloc.dart';
import 'package:module_movie/presentation/bloc/movie_detail/watchlist/movie_detail_watchlist_cubit.dart';

class MovieDetailPage extends StatefulWidget {
  static const routeName = '/detail-movie';

  final int id;

  const MovieDetailPage({required this.id, Key? key}) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();

    // Provider
    // Future.microtask(
    //   () {
    //     Provider.of<MovieDetailNotifier>(context, listen: false)
    //         .fetchMovieDetail(widget.id);
    //     Provider.of<MovieDetailNotifier>(context, listen: false)
    //         .loadWatchlistStatus(widget.id);
    //   },

    // BLOC
    Future.microtask(
      () {
        context.read<MovieDetailBloc>().add(
              OnRequestedMovieDetail(widget.id),
            );
        context.read<MovieDetailRecommendationBloc>().add(
              OnRequestedMovieRecommendation(widget.id),
            );
        context.read<MovieDetailWatchlistCubit>().watchlistStatus(widget.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:

          // Provider
          //   Consumer<MovieDetailNotifier>(
          //   builder: (context, provider, child) {
          //     if (provider.movieState == RequestState.Loading) {
          //       return Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     } else if (provider.movieState == RequestState.Loaded) {
          //       final movie = provider.movie;
          //       return SafeArea(
          //         child: DetailContent(
          //           movie,
          //           provider.movieRecommendations,
          //           provider.isAddedToWatchlist,
          //         ),
          //       );
          //     } else {
          //       return Text(provider.message);
          //     }
          //   },
          // ),

          // BlocBuilder
          BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieDetailHasData) {
            return SafeArea(
              child: DetailContent(
                state.movie,
              ),
            );
          } else if (state is MovieDetailError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;

  const DetailContent(this.movie, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: kHeading5,
                            ),

                            // BLOC
                            // BLOC
                            BlocBuilder<MovieDetailWatchlistCubit,
                                MovieDetailWatchlistState>(
                              builder: (context, state) {
                                if (state is MovieDetailWatchlistLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is MovieDetailWatchlistHasData) {
                                  final isAddedToWatchlist =
                                      state.isAddedToWatchlist;

                                  return ElevatedButton(
                                    onPressed: () async {
                                      if (!isAddedToWatchlist) {
                                        // Provider
                                        // await Provider.of<MovieDetailNotifier>(
                                        //         context,
                                        //         listen: false)
                                        //     .addWatchlist(movie);

                                        // BLOC
                                        await BlocProvider.of<
                                                    MovieDetailWatchlistCubit>(
                                                context)
                                            .saveWatchlist(movie);
                                      } else {
                                        // Provider
                                        // await Provider.of<MovieDetailNotifier>(
                                        //         context,
                                        //         listen: false)
                                        //     .removeFromWatchlist(movie);

                                        // BLOC
                                        await BlocProvider.of<
                                                    MovieDetailWatchlistCubit>(
                                                context)
                                            .removeWatchlist(movie);
                                      }

                                      final message = BlocProvider.of<
                                                  MovieDetailWatchlistCubit>(
                                              context)
                                          .watchlistMessage;
                                      if (message.isNotEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(message),
                                          ),
                                        );
                                      }

                                      // Provider
                                      // final message =
                                      //     Provider.of<MovieDetailNotifier>(context,
                                      //             listen: false)
                                      //         .watchlistMessage;
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        isAddedToWatchlist
                                            ? const Icon(Icons.check)
                                            : const Icon(Icons.add),
                                        const Text('Watchlist'),
                                      ],
                                    ),
                                  );
                                } else if (state is MovieDetailWatchlistEmpty) {
                                  return const Center(
                                    child: Text("FAILED"),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),

                            Text(
                              _showGenres(movie.genres),
                            ),
                            Text(
                              _showDuration(movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),

                            // Provider
                            // Consumer<MovieDetailNotifier>(
                            //   builder: (context, data, child) {
                            //     if (data.recommendationState ==
                            //         RequestState.Loading) {
                            //       return Center(
                            //         child: CircularProgressIndicator(),
                            //       );
                            //     } else if (data.recommendationState ==
                            //         RequestState.Error) {
                            //       return Text(data.message);
                            //     } else if (data.recommendationState ==
                            //         RequestState.Loaded) {
                            //       return Container(
                            //         height: 150,
                            //         child: ListView.builder(
                            //           scrollDirection: Axis.horizontal,
                            //           itemBuilder: (context, index) {
                            //             final movie = recommendations[index];
                            //             return Padding(
                            //               padding: const EdgeInsets.all(4.0),
                            //               child: InkWell(
                            //                 onTap: () {
                            //                   Navigator.pushReplacementNamed(
                            //                     context,
                            //                     MovieDetailPage.routeName,
                            //                     arguments: movie.id,
                            //                   );
                            //                 },
                            //                 child: ClipRRect(
                            //                   borderRadius: BorderRadius.all(
                            //                     Radius.circular(8),
                            //                   ),
                            //                   child: CachedNetworkImage(
                            //                     imageUrl:
                            //                         'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            //                     placeholder: (context, url) =>
                            //                         Center(
                            //                       child:
                            //                           CircularProgressIndicator(),
                            //                     ),
                            //                     errorWidget:
                            //                         (context, url, error) =>
                            //                             Icon(Icons.error),
                            //                   ),
                            //                 ),
                            //               ),
                            //             );
                            //           },
                            //           itemCount: recommendations.length,
                            //         ),
                            //       );
                            //     } else {
                            //       return Container();
                            //     }
                            //   },
                            // ),

                            BlocBuilder<MovieDetailRecommendationBloc,
                                MovieDetailRecommendationState>(
                              builder: (context, state) {
                                if (state is MovieDetailRecommendationLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is MovieDetailRecommendationHasData) {
                                  List<Movie> recommendations =
                                      state.movieRecommendations;
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie = recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                MovieDetailPage.routeName,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: recommendations.length,
                                    ),
                                  );
                                } else if (state
                                    is MovieDetailRecommendationError) {
                                  return Center(
                                    child: Text(state.message),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
