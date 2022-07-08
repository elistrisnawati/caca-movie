import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:module_movie/data/datasources/bloc/movie_now_playing_bloc.dart';
import 'package:module_movie/data/datasources/bloc/movie_popular_bloc.dart';
import 'package:module_movie/data/datasources/bloc/movie_top_rated_bloc.dart';
import 'package:module_movie/domain/entities/movie/movie.dart';
import 'package:module_movie/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:module_movie/domain/usecases/movie/get_popular_movies.dart';
import 'package:module_movie/domain/usecases/movie/get_top_rated_movies.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies _getNowPlayingMovies;
  final GetPopularMovies _getPopularMovies;
  final GetTopRatedMovies _getTopRatedMovies;

  MovieListBloc(this._getNowPlayingMovies, this._getPopularMovies,
      this._getTopRatedMovies)
      : super(MovieListEmpty()) {
    on<OnRequestedNowPlayingMovies>(
          (event, emit) async {
        _fetchNowPlayingMovies(event, emit);
      },
    );
    on<OnRequestedPopularMovies>(
          (event, emit) async {
        _fetchPopularMovies(event, emit);
      },
    );
    on<OnRequestedTopRatedMovies>(
          (event, emit) async {
        _fetchTopRatedMovies(event, emit);
      },
    );
  }

  void _fetchNowPlayingMovies(event, emit) async {
    print("_fetchNowPlayingMovies");

    emit(NowPlayingMoviesLoading());
    final result = await _getNowPlayingMovies.execute();

    result.fold(
      (failure) {
        emit(NowPlayingMoviesError(failure.message));
      },
      (data) {
        emit(NowPlayingMoviesHasData(data));
      },
    );

    print("_fetchNowPlayingMovies DONE");
  }

  void _fetchPopularMovies(event, emit) async {
    print("_fetchPopularMovies");

    emit(PopularMoviesLoading());
    final result = await _getPopularMovies.execute();

    result.fold(
      (failure) {
        emit(PopularMoviesError(failure.message));
      },
      (data) {
        emit(PopularMoviesHasData(data));
      },
    );

    print("_fetchPopularMovies DONE");
  }

  void _fetchTopRatedMovies(event, emit) async {
    print("_fetchTopRatedMovies");

    emit(TopRatedMoviesLoading());
    final result = await _getTopRatedMovies.execute();

    result.fold(
      (failure) {
        emit(TopRatedMoviesError(failure.message));
      },
      (data) {
        emit(TopRatedMoviesHasData(data));
      },
    );

    print("_fetchTopRatedMovies DONE");
  }
}
