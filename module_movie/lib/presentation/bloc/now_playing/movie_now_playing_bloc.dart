import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:module_movie/domain/entities/movie/movie.dart';
import 'package:module_movie/domain/usecases/movie/get_now_playing_movies.dart';

part 'movie_now_playing_event.dart';
part 'movie_now_playing_state.dart';

class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMoviesBloc(this._getNowPlayingMovies)
      : super(NowPlayingMoviesEmpty()) {
    on<OnRequested>(
      (event, emit) async {
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
      },
    );
  }
}
