import 'dart:io';

import 'package:ditonton/injection.dart' as di;
import 'package:ditonton/presentation/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_generic/common/constants.dart';
import 'package:module_generic/common/utils.dart';
import 'package:module_generic/presentation/pages/about_page.dart';
import 'package:module_movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:module_movie/presentation/bloc/movie_detail/recommendation/movie_detail_recommendation_bloc.dart';
import 'package:module_movie/presentation/bloc/movie_detail/watchlist/movie_detail_watchlist_bloc.dart';
import 'package:module_movie/presentation/bloc/movie_list/now_playing/movie_list_now_playing_bloc.dart';
import 'package:module_movie/presentation/bloc/movie_list/popular/movie_list_popular_bloc.dart';
import 'package:module_movie/presentation/bloc/movie_list/top_rated/movie_list_top_rated_bloc.dart';
import 'package:module_movie/presentation/bloc/popular/movie_popular_bloc.dart';
import 'package:module_movie/presentation/bloc/search/movie_search_bloc.dart';
import 'package:module_movie/presentation/bloc/top_rated/movie_top_rated_bloc.dart';
import 'package:module_movie/presentation/bloc/watchlist/movie_watchlist_bloc.dart';
import 'package:module_movie/presentation/pages/movie/home_movie_page.dart';
import 'package:module_movie/presentation/pages/movie/movie_detail_page.dart';
import 'package:module_movie/presentation/pages/movie/popular_movies_page.dart';
import 'package:module_movie/presentation/pages/movie/search_movie_page.dart';
import 'package:module_movie/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:module_movie/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:module_tv/presentation/bloc/popular/tv_popular_bloc.dart';
import 'package:module_tv/presentation/bloc/search/tv_search_bloc.dart';
import 'package:module_tv/presentation/bloc/top_rated/tv_top_rated_bloc.dart';
import 'package:module_tv/presentation/bloc/tv_detail/recommendation/tv_detail_recommendation_bloc.dart';
import 'package:module_tv/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:module_tv/presentation/bloc/tv_detail/watchlist/tv_detail_watchlist_bloc.dart';
import 'package:module_tv/presentation/bloc/tv_list/now_playing/tv_list_now_playing_bloc.dart';
import 'package:module_tv/presentation/bloc/tv_list/popular/tv_list_popular_bloc.dart';
import 'package:module_tv/presentation/bloc/tv_list/top_rated/tv_list_top_rated_bloc.dart';
import 'package:module_tv/presentation/bloc/watchlist/tv_watchlist_bloc.dart';
import 'package:module_tv/presentation/pages/tv/home_tv_page.dart';
import 'package:module_tv/presentation/pages/tv/popular_tvs_page.dart';
import 'package:module_tv/presentation/pages/tv/search_tv_page.dart';
import 'package:module_tv/presentation/pages/tv/top_rated_tvs_page.dart';
import 'package:module_tv/presentation/pages/tv/tv_detail_page.dart';
import 'package:module_tv/presentation/pages/tv/watchlist_tvs_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  print("globalContext");

  final sslCert =
      await rootBundle.load('assets/certificates/themoviedb-org.pem');
  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
  di.init(securityContext);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // for movie
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<MovieListNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<MovieDetailNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<MovieSearchNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<TopRatedMoviesNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<PopularMoviesNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<WatchlistMovieNotifier>(),
        // ),

        // MovieList BLOC
        BlocProvider(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieListNowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieListTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieListPopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailWatchlistBloc>(),
        ),

        // for tv series
        // Provider
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<TvListNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<TvDetailNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<TvSearchNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<TopRatedTvsNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<PopularTvsNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<WatchlistTvNotifier>(),
        // ),

        // TvList BLOC
        BlocProvider(
          create: (_) => di.locator<TvSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvListNowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvListTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvListPopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailWatchlistBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'DITONTON',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        // home: HomeMoviePage(),
        home: HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            // movie
            case HomeMoviePage.routeName:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.routeName:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.routeName:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchMoviePage.routeName:
              return CupertinoPageRoute(builder: (_) => SearchMoviePage());
            case WatchlistMoviesPage.routeName:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());

            // tv
            case HomeTvPage.routeName:
              return MaterialPageRoute(builder: (_) => HomeTvPage());
            case PopularTvsPage.routeName:
              return CupertinoPageRoute(builder: (_) => PopularTvsPage());
            case TopRatedTvsPage.routeName:
              return CupertinoPageRoute(builder: (_) => TopRatedTvsPage());
            case TvDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case SearchTvPage.routeName:
              return CupertinoPageRoute(builder: (_) => SearchTvPage());
            case WatchlistTvsPage.routeName:
              return MaterialPageRoute(builder: (_) => WatchlistTvsPage());

            case AboutPage.routeName:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
