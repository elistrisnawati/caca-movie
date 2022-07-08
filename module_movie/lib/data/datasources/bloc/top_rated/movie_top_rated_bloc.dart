import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:module_movie/domain/entities/movie/movie.dart';
import 'package:module_movie/domain/usecases/movie/get_top_rated_movies.dart';

part 'movie_top_rated_event.dart';
part 'movie_top_rated_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMoviesBloc(this._getTopRatedMovies) : super(TopRatedMoviesEmpty()) {
    on<OnRequested>(
      (event, emit) async {
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
      },
    );
  }
}
