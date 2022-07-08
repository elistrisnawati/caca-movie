import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:module_movie/domain/entities/movie/movie.dart';
import 'package:module_movie/domain/usecases/movie/get_watchlist_movies.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class WatchlistMoviesBloc
    extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final GetWatchlistMovies _getWatchlistMovies;

  WatchlistMoviesBloc(this._getWatchlistMovies)
      : super(WatchlistMoviesEmpty()) {
    on<OnRequested>(
      (event, emit) async {
        emit(WatchlistMoviesLoading());
        final result = await _getWatchlistMovies.execute();

        result.fold(
          (failure) {
            emit(WatchlistMoviesError(failure.message));
          },
          (data) {
            emit(WatchlistMoviesHasData(data));
          },
        );
      },
    );
  }
}
