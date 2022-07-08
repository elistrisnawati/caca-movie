import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_tv/data/datasources/bloc/watchlist/tv_watchlist_bloc.dart';
import 'package:module_tv/presentation/widgets/tv/tv_card_list.dart';

class WatchlistTvsPage extends StatefulWidget {
  static const routeName = '/watchlist-tv';

  const WatchlistTvsPage({Key? key}) : super(key: key);

  @override
  _WatchlistTvsPageState createState() => _WatchlistTvsPageState();
}

class _WatchlistTvsPageState extends State<WatchlistTvsPage> with RouteAware {
  @override
  void initState() {
    super.initState();

    // Provider
    // Future.microtask(() =>
    //     Provider.of<WatchlistTvsNotifier>(context, listen: false)
    //         .fetchWatchlistTvs());

    // BLOC
    Future.microtask(
      () => context.read<WatchlistTvsBloc>().add(const OnRequested()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist Tvs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:

            // // Provider
            // Consumer<WatchlistTvsNotifier>(
            //   builder: (context, data, child) {
            //     if (data.state == RequestState.Loading) {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     } else if (data.state == RequestState.Loaded) {
            //       return ListView.builder(
            //         itemBuilder: (context, index) {
            //           final tv = data.tvs[index];
            //           return TvCard(tv);
            //         },
            //         itemCount: data.tvs.length,
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
            BlocBuilder<WatchlistTvsBloc, WatchlistTvsState>(
          builder: (context, state) {
            if (state is WatchlistTvsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistTvsHasData) {
              final result = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = result[index];
                  return TvCard(tv);
                },
                itemCount: result.length,
              );
            } else if (state is WatchlistTvsError) {
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
