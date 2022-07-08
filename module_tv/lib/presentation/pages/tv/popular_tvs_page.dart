import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_tv/data/datasources/bloc/popular/tv_popular_bloc.dart';
import 'package:module_tv/presentation/widgets/tv/tv_card_list.dart';

class PopularTvsPage extends StatefulWidget {
  static const routeName = '/popular-tv';

  const PopularTvsPage({Key? key}) : super(key: key);

  @override
  _PopularTvsPageState createState() => _PopularTvsPageState();
}

class _PopularTvsPageState extends State<PopularTvsPage> {
  @override
  void initState() {
    super.initState();

    // Provider
    // Future.microtask(() =>
    //     Provider.of<PopularTvsNotifier>(context, listen: false)
    //         .fetchPopularTvs());

    // BLOC
    Future.microtask(
      () => context.read<PopularTvsBloc>().add(const OnRequested()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tvs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:

            // // Provider
            // Consumer<PopularTvsNotifier>(
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
            BlocBuilder<PopularTvsBloc, PopularTvsState>(
          builder: (context, state) {
            if (state is PopularTvsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvsHasData) {
              final result = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = result[index];
                  return TvCard(tv);
                },
                itemCount: result.length,
              );
            } else if (state is PopularTvsError) {
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
