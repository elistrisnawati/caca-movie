import 'package:flutter/material.dart';
import 'package:module_generic/common/state_enum.dart';
import 'package:module_tv/presentation/provider/tv/top_rated_tvs_notifier.dart';
import 'package:module_tv/presentation/widgets/tv/tv_card_list.dart';
import 'package:provider/provider.dart';

class TopRatedTvsPage extends StatefulWidget {
  static const routeName = '/top-rated-tv';

  const TopRatedTvsPage({Key? key}) : super(key: key);

  @override
  _TopRatedTvsPageState createState() => _TopRatedTvsPageState();
}

class _TopRatedTvsPageState extends State<TopRatedTvsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TopRatedTvsNotifier>(context, listen: false)
            .fetchTopRatedTvs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Tvs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopRatedTvsNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.tvs[index];
                  return TvCard(tv);
                },
                itemCount: data.tvs.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
