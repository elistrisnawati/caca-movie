import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_generic/common/constants.dart';
import 'package:module_tv/presentation/bloc/tv_list/now_playing/tv_list_now_playing_bloc.dart';
import 'package:module_tv/presentation/bloc/tv_list/popular/tv_list_popular_bloc.dart';
import 'package:module_tv/presentation/bloc/tv_list/top_rated/tv_list_top_rated_bloc.dart';
import 'package:module_tv/domain/entities/tv/tv.dart';
import 'package:module_tv/presentation/pages/tv/popular_tvs_page.dart';
import 'package:module_tv/presentation/pages/tv/search_tv_page.dart';
import 'package:module_tv/presentation/pages/tv/top_rated_tvs_page.dart';
import 'package:module_tv/presentation/pages/tv/tv_detail_page.dart';

class HomeTvPage extends StatefulWidget {
  static const routeName = '/home-tv';

  const HomeTvPage({Key? key}) : super(key: key);

  @override
  _HomeTvPageState createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      // Provider
      // () => Provider.of<TvListNotifier>(context, listen: false)
      //   ..fetchNowPlayingTvs()
      //   ..fetchTvList()
      //   ..fetchTopRatedTvs(),

      // BLOC
      () {
        context.read<TvListPopularBloc>().add(
              const OnRequestedPopularTvs(),
            );
        context.read<TvListTopRatedBloc>().add(
              const OnRequestedTopRatedTvs(),
            );
        context.read<TvListNowPlayingBloc>().add(
              const OnRequestedNowPlayingTvs(),
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tv List'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTvPage.routeName);
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
                'Airing Today',
                style: kHeading6,
              ),
              // Consumer
              // Consumer<TvListNotifier>(
              //   builder: (context, data, child) {
              //     final state = data.nowPlayingState;
              //     if (state == RequestState.Loading) {
              //       return const Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     } else if (state == RequestState.Loaded) {
              //       return TvList(data.nowPlayingTvs);
              //     } else {
              //       return const Text('Failed');
              //     }
              //   },
              // ),

              // BLOC
              BlocBuilder<TvListNowPlayingBloc, NowPlayingTvsState>(
                builder: (context, state) {
                  if (state is NowPlayingTvsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingTvsHasData) {
                    final result = state.result;
                    return TvList(result);
                  } else if (state is NowPlayingTvsError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),

              // Populare Heading
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvsPage.routeName),
              ),

              // Consumer
              // Consumer<TvListNotifier>(
              //   builder: (context, data, child) {
              //     final state = data.popularTvsState;
              //     if (state == RequestState.Loading) {
              //       return const Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     } else if (state == RequestState.Loaded) {
              //       return TvList(data.popularTvs);
              //     } else {
              //       return const Text('Failed');
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
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),

              // Top Rated Heading
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTvsPage.routeName),
              ),

              // Consumer
              // Consumer<TvListNotifier>(
              //   builder: (context, data, child) {
              //     final state = data.topRatedTvsState;
              //     if (state == RequestState.Loading) {
              //       return const Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     } else if (state == RequestState.Loaded) {
              //       return TvList(data.topRatedTvs);
              //     } else {
              //       return const Text('Failed');
              //     }
              //   },
              // ),

              // BLOC
              BlocBuilder<TvListTopRatedBloc, TopRatedTvsState>(
                builder: (context, state) {
                  if (state is TopRatedTvsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedTvsHasData) {
                    final result = state.result;
                    return TvList(result);
                  } else if (state is TopRatedTvsError) {
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

class TvList extends StatelessWidget {
  final List<Tv> tvs;

  const TvList(this.tvs, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvs[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvDetailPage.routeName,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: tv.posterPath?.isEmpty ?? true
                      ? BLANK_POSTER
                      : '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvs.length,
      ),
    );
  }
}
