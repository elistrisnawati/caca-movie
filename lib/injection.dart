import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';
import 'package:module_movie/data/datasources/db/database_helper_movie.dart';
import 'package:module_movie/data/datasources/movie/movie_local_data_source.dart';
import 'package:module_movie/data/datasources/movie/movie_remote_data_source.dart';
import 'package:module_movie/data/repositories/movie/movie_repository_impl.dart';
import 'package:module_movie/domain/repositories/movie/movie_repository.dart';
import 'package:module_movie/domain/usecases/movie/get_movie_detail.dart';
import 'package:module_movie/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:module_movie/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:module_movie/domain/usecases/movie/get_popular_movies.dart';
import 'package:module_movie/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:module_movie/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:module_movie/domain/usecases/movie/get_watchlist_status_movie.dart';
import 'package:module_movie/domain/usecases/movie/remove_movie_watchlist.dart';
import 'package:module_movie/domain/usecases/movie/save_movie_watchlist.dart';
import 'package:module_movie/domain/usecases/movie/search_movies.dart';
import 'package:module_movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:module_movie/presentation/bloc/movie_detail/recommendation/movie_detail_recommendation_bloc.dart';
import 'package:module_movie/presentation/bloc/movie_detail/watchlist/movie_detail_watchlist_bloc.dart';
import 'package:module_movie/presentation/bloc/movie_list/now_playing/movie_list_now_playing_bloc.dart';
import 'package:module_movie/presentation/bloc/movie_list/popular/movie_list_popular_bloc.dart';
import 'package:module_movie/presentation/bloc/movie_list/top_rated/movie_list_top_rated_bloc.dart';
import 'package:module_movie/presentation/bloc/now_playing/movie_now_playing_bloc.dart';
import 'package:module_movie/presentation/bloc/popular/movie_popular_bloc.dart';
import 'package:module_movie/presentation/bloc/search/movie_search_bloc.dart';
import 'package:module_movie/presentation/bloc/top_rated/movie_top_rated_bloc.dart';
import 'package:module_movie/presentation/bloc/watchlist/movie_watchlist_bloc.dart';
import 'package:module_tv/data/datasources/db/database_helper_tv.dart';
import 'package:module_tv/data/datasources/tv/tv_local_data_source.dart';
import 'package:module_tv/data/datasources/tv/tv_remote_data_source.dart';
import 'package:module_tv/data/repositories/tv/tv_repository_impl.dart';
import 'package:module_tv/domain/repositories/tv/tv_repository.dart';
import 'package:module_tv/domain/usecases/tv/get_now_playing_tvs.dart';
import 'package:module_tv/domain/usecases/tv/get_popular_tvs.dart';
import 'package:module_tv/domain/usecases/tv/get_top_rated_tvs.dart';
import 'package:module_tv/domain/usecases/tv/get_tv_detail.dart';
import 'package:module_tv/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:module_tv/domain/usecases/tv/get_watchlist_status_tv.dart';
import 'package:module_tv/domain/usecases/tv/get_watchlist_tvs.dart';
import 'package:module_tv/domain/usecases/tv/remove_tv_watchlist.dart';
import 'package:module_tv/domain/usecases/tv/save_tv_watchlist.dart';
import 'package:module_tv/domain/usecases/tv/search_tvs.dart';
import 'package:module_tv/presentation/bloc/now_playing/tv_now_playing_bloc.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

void init(SecurityContext securityContext) {
  locator.registerLazySingleton(
    // () => IOClient(HttpClient()),
    () => IOClient(HttpClient(context: securityContext)),
  );

  locator.registerSingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );

  // movie provider
  // locator.registerFactory(
  //   () => MovieListNotifier(
  //     getNowPlayingMovies: locator(),
  //     getPopularMovies: locator(),
  //     getTopRatedMovies: locator(),
  //   ),
  // );
  //
  // locator.registerFactory(
  //   () => MovieDetailNotifier(
  //     getMovieDetail: locator(),
  //     getMovieRecommendations: locator(),
  //     getWatchListStatus: locator(),
  //     saveWatchlist: locator(),
  //     removeWatchlist: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => MovieSearchNotifier(
  //     searchMovies: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => PopularMoviesNotifier(
  //     locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => TopRatedMoviesNotifier(
  //     getTopRatedMovies: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => WatchlistMovieNotifier(
  //     getWatchlistMovies: locator(),
  //   ),
  // );

  // movie use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusMovie(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // what list use case
  locator.registerLazySingleton(() => SaveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistMovie(locator()));

  // movie repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // movie data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  locator.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(
      databaseHelper: locator(),
    ),
  );

  // helper
  locator.registerLazySingleton<DatabaseHelperMovie>(
    () => DatabaseHelperMovie(),
  );

  // tv provider
  // locator.registerFactory(
  //   () => TvListNotifier(
  //     getNowPlayingTvs: locator(),
  //     getPopularTvs: locator(),
  //     getTopRatedTvs: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => TvDetailNotifier(
  //     getTvDetail: locator(),
  //     getTvRecommendations: locator(),
  //     getWatchListStatus: locator(),
  //     saveWatchlist: locator(),
  //     removeWatchlist: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => TvSearchNotifier(
  //     searchTvs: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => PopularTvsNotifier(
  //     locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => TopRatedTvsNotifier(
  //     getTopRatedTvs: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => WatchlistTvNotifier(
  //     getWatchlistTvs: locator(),
  //   ),
  // );

  // tv use case
  locator.registerLazySingleton(() => GetNowPlayingTvs(locator()));
  locator.registerLazySingleton(() => GetPopularTvs(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvs(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvs(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvs(locator()));

  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));

  // tv repository
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));

  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelperTv>(() => DatabaseHelperTv());

  // bloc
  locator.registerFactory(
    () => MovieListPopularBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieListNowPlayingBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieListTopRatedBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(() => WatchlistMoviesBloc(
        locator(),
      ));
  locator.registerFactory(
    () => MovieDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailRecommendationBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailWatchlistBloc(
      locator(),
      locator(),
      locator(),
    ),
  );

  // bloc
  locator.registerFactory(
    () => TvListPopularBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvListNowPlayingBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvListTopRatedBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingTvsBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvsBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvsBloc(
      locator(),
    ),
  );
  locator.registerFactory(() => WatchlistTvsBloc(
        locator(),
      ));
  locator.registerFactory(
    () => TvDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailRecommendationBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailWatchlistBloc(
      locator(),
      locator(),
      locator(),
    ),
  );
}
