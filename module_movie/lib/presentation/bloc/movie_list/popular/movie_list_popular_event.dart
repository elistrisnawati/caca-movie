part of 'movie_list_popular_bloc.dart';

@immutable
abstract class MovieListPopularEvent extends Equatable {
  const MovieListPopularEvent();

  @override
  List<Object> get props => [];
}

class OnRequestedPopularMovies extends MovieListPopularEvent {
  const OnRequestedPopularMovies();

  @override
  List<Object> get props => [];
}
