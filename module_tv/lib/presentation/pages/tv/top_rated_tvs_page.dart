import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_tv/presentation/bloc/top_rated/tv_top_rated_bloc.dart';
import 'package:module_tv/presentation/widgets/tv/tv_card_list.dart';

class TopRatedTvsPage extends StatefulWidget {
  static const routeName = '/top-rated-tv';

  @override
  _TopRatedTvsPageState createState() => _TopRatedTvsPageState();
}

class _TopRatedTvsPageState extends State<TopRatedTvsPage> {
  @override
  void initState() {
    super.initState();

    // Provider
    // Future.microtask(() =>
    //     Provider.of<TopRatedTvsNotifier>(context, listen: false)
    //         .fetchTopRatedTvs());

    // BLOC
    Future.microtask(
      () => context.read<TopRatedTvsBloc>().add(const OnRequested()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TopRated Tvs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:

            // // Provider
            // Consumer<TopRatedTvsNotifier>(
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
            BlocBuilder<TopRatedTvsBloc, TopRatedTvsState>(
          builder: (context, state) {
            if (state is TopRatedTvsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTvsHasData) {
              final result = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = result[index];
                  return TvCard(tv);
                },
                itemCount: result.length,
              );
            } else if (state is TopRatedTvsError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
