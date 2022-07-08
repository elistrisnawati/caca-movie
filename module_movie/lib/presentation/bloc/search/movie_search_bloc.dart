import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:module_movie/domain/entities/movie/movie.dart';
import 'package:module_movie/domain/usecases/movie/search_movies.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies _searchMovies;

  MovieSearchBloc(this._searchMovies) : super(MovieSearchEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(MovieSearchLoading());
        final result = await _searchMovies.execute(query);

        result.fold(
          (failure) {
            emit(MovieSearchError(failure.message));
          },
          (data) {
            emit(MovieSearchHasData(data));
          },
        );
      },
    );
  }
}
