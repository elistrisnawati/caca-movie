import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:module_movie/domain/entities/movie/movie.dart';
import 'package:module_movie/domain/usecases/movie/get_now_playing_movies.dart';

part 'movie_list_now_playing_event.dart';
part 'movie_list_now_playing_state.dart';

class MovieListNowPlayingBloc
    extends Bloc<MovieListNowPlayingEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  MovieListNowPlayingBloc(this._getNowPlayingMovies)
      : super(NowPlayingMoviesEmpty()) {
    on<OnRequestedNowPlayingMovies>(
      (event, emit) async {
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
      },
    );
  }
}
