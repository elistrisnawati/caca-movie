import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:module_movie/domain/entities/movie/movie.dart';
import 'package:module_movie/domain/usecases/movie/get_popular_movies.dart';

part 'movie_popular_event.dart';
part 'movie_popular_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies _getPopularMovies;

  PopularMoviesBloc(this._getPopularMovies) : super(PopularMoviesEmpty()) {
    on<OnRequested>(
      (event, emit) async {
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
      },
    );
  }
}
