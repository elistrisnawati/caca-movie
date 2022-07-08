import 'dart:io';

import 'package:ditonton/injection.dart' as di;
import 'package:ditonton/presentation/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:module_generic/common/constants.dart';
import 'package:module_generic/common/utils.dart';
import 'package:module_generic/presentation/pages/about_page.dart';
import 'package:module_movie/presentation/pages/movie/home_movie_page.dart';
import 'package:module_movie/presentation/pages/movie/movie_detail_page.dart';
import 'package:module_movie/presentation/pages/movie/popular_movies_page.dart';
import 'package:module_movie/presentation/pages/movie/search_movie_page.dart';
import 'package:module_movie/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:module_movie/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:module_movie/presentation/provider/movie/movie_detail_notifier.dart';
import 'package:module_movie/presentation/provider/movie/movie_list_notifier.dart';
import 'package:module_movie/presentation/provider/movie/movie_search_notifier.dart';
import 'package:module_movie/presentation/provider/movie/popular_movies_notifier.dart';
import 'package:module_movie/presentation/provider/movie/top_rated_movies_notifier.dart';
import 'package:module_movie/presentation/provider/movie/watchlist_movie_notifier.dart';
import 'package:module_tv/presentation/pages/tv/home_tv_page.dart';
import 'package:module_tv/presentation/pages/tv/popular_tvs_page.dart';
import 'package:module_tv/presentation/pages/tv/search_tv_page.dart';
import 'package:module_tv/presentation/pages/tv/top_rated_tvs_page.dart';
import 'package:module_tv/presentation/pages/tv/tv_detail_page.dart';
import 'package:module_tv/presentation/pages/tv/watchlist_tvs_page.dart';
import 'package:module_tv/presentation/provider/tv/popular_tvs_notifier.dart';
import 'package:module_tv/presentation/provider/tv/top_rated_tvs_notifier.dart';
import 'package:module_tv/presentation/provider/tv/tv_detail_notifier.dart';
import 'package:module_tv/presentation/provider/tv/tv_list_notifier.dart';
import 'package:module_tv/presentation/provider/tv/tv_search_notifier.dart';
import 'package:module_tv/presentation/provider/tv/watchlist_tv_notifier.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  print("globalContext");

  final sslCert = await rootBundle.load('assets/certificates/themoviedb-org.pem');
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
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),

        // for tv series
        ChangeNotifierProvider(
          create: (_) => di.locator<TvListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvNotifier>(),
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
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchMoviePage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchMoviePage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());

            // tv
            case HomeTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeTvPage());
            case PopularTvsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvsPage());
            case TopRatedTvsPage.routeName:
              return CupertinoPageRoute(builder: (_) => TopRatedTvsPage());
            case TvDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case SearchTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchTvPage());
            case WatchlistTvsPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTvsPage());

            case AboutPage.ROUTE_NAME:
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
