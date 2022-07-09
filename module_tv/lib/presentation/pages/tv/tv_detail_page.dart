import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_it/get_it.dart';
import 'package:module_generic/common/constants.dart';
import 'package:module_generic/domain/entities/genre.dart';
import 'package:module_tv/domain/entities/tv/tv.dart';
import 'package:module_tv/domain/entities/tv/tv_detail.dart';
import 'package:module_tv/presentation/bloc/tv_detail/recommendation/tv_detail_recommendation_bloc.dart';
import 'package:module_tv/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:module_tv/presentation/bloc/tv_detail/watchlist/tv_detail_watchlist_cubit.dart';

final locator = GetIt.instance;

class TvDetailPage extends StatefulWidget {
  static const routeName = '/detail-tv';

  final int id;

  const TvDetailPage({required this.id, Key? key}) : super(key: key);

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();

    // Provider
    // Future.microtask(
    //   () {
    //     Provider.of<TvDetailNotifier>(context, listen: false)
    //         .fetchTvDetail(widget.id);
    //     Provider.of<TvDetailNotifier>(context, listen: false)
    //         .loadWatchlistStatus(widget.id);
    //   },

    // BLOC
    Future.microtask(
      () {
        context.read<TvDetailBloc>().add(
              OnRequestedTvDetail(widget.id),
            );
        context.read<TvDetailRecommendationBloc>().add(
              OnRequestedTvRecommendation(widget.id),
            );
        context.read<TvDetailWatchlistCubit>().watchlistStatus(widget.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:

          // Provider
          //   Consumer<TvDetailNotifier>(
          //   builder: (context, provider, child) {
          //     if (provider.tvState == RequestState.Loading) {
          //       return Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     } else if (provider.tvState == RequestState.Loaded) {
          //       final tv = provider.tv;
          //       return SafeArea(
          //         child: DetailContent(
          //           tv,
          //           provider.tvRecommendations,
          //           provider.isAddedToWatchlist,
          //         ),
          //       );
          //     } else {
          //       return Text(provider.message);
          //     }
          //   },
          // ),

          // BlocBuilder
          BlocBuilder<TvDetailBloc, TvDetailState>(
        builder: (context, state) {
          if (state is TvDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvDetailHasData) {
            return SafeArea(
              child: DetailContent(
                state.tv,
              ),
            );
          } else if (state is TvDetailError) {
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
  final TvDetail tv;

  const DetailContent(this.tv, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
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
                              tv.name,
                              style: kHeading5,
                            ),

                            // BLOC
                            BlocBuilder<TvDetailWatchlistCubit,
                                TvDetailWatchlistState>(
                              builder: (context, state) {
                                if (state is TvDetailWatchlistLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is TvDetailWatchlistHasData) {
                                  final isAddedToWatchlist =
                                      state.isAddedToWatchlist;

                                  return ElevatedButton(
                                    onPressed: () async {
                                      if (!isAddedToWatchlist) {
                                        // Provider
                                        // await Provider.of<TvDetailNotifier>(
                                        //         context,
                                        //         listen: false)
                                        //     .addWatchlist(tv);

                                        // BLOC
                                        await BlocProvider.of<
                                                TvDetailWatchlistCubit>(context)
                                            .saveWatchlist(tv);
                                      } else {
                                        // Provider
                                        // await Provider.of<TvDetailNotifier>(
                                        //         context,
                                        //         listen: false)
                                        //     .removeFromWatchlist(tv);

                                        // BLOC
                                        await BlocProvider.of<
                                                TvDetailWatchlistCubit>(context)
                                            .removeWatchlist(tv);
                                      }

                                      final message = BlocProvider.of<
                                          TvDetailWatchlistCubit>(context).watchlistMessage;
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
                                      //     Provider.of<TvDetailNotifier>(context,
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
                                } else if (state is TvDetailWatchlistEmpty) {
                                  return const Center(
                                    child: Text("FAILED"),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),

                            Text(
                              _showGenres(tv.genres),
                            ),
                            Text(
                              _showSeasonsAndEpisodes(
                                  tv.numberOfSeasons, tv.numberOfEpisodes),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tv.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tv.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),

                            // Provider
                            // Consumer<TvDetailNotifier>(
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
                            //             final tv = recommendations[index];
                            //             return Padding(
                            //               padding: const EdgeInsets.all(4.0),
                            //               child: InkWell(
                            //                 onTap: () {
                            //                   Navigator.pushReplacementNamed(
                            //                     context,
                            //                     TvDetailPage.routeName,
                            //                     arguments: tv.id,
                            //                   );
                            //                 },
                            //                 child: ClipRRect(
                            //                   borderRadius: BorderRadius.all(
                            //                     Radius.circular(8),
                            //                   ),
                            //                   child: CachedNetworkImage(
                            //                     imageUrl:
                            //                         'https://image.tmdb.org/t/p/w500${tv.posterPath}',
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

                            BlocBuilder<TvDetailRecommendationBloc,
                                TvDetailRecommendationState>(
                              builder: (context, state) {
                                if (state is TvDetailRecommendationLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is TvDetailRecommendationHasData) {
                                  List<Tv> recommendations =
                                      state.tvRecommendations;
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tv = recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvDetailPage.routeName,
                                                arguments: tv.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tv.posterPath}',
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
                                    is TvDetailRecommendationError) {
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

  String _showSeasonsAndEpisodes(int seasons, int episodes) {
    return '$seasons seasons ($episodes episodes)';
  }
}
