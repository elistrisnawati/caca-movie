import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:module_movie/domain/entities/movie/movie.dart';
import 'package:module_movie/domain/usecases/movie/get_popular_movies.dart';

part 'movie_list_popular_event.dart';
part 'movie_list_popular_state.dart';

class MovieListPopularBloc
    extends Bloc<MovieListPopularEvent, PopularMoviesState> {
  final GetPopularMovies _getPopularMovies;

  MovieListPopularBloc(this._getPopularMovies) : super(PopularMoviesEmpty()) {
    on<OnRequestedPopularMovies>(
      (event, emit) async {
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
      },
    );
  }
}
