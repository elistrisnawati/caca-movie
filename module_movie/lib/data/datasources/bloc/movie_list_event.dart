part of 'movie_list_bloc.dart';

@immutable
abstract class MovieListEvent extends Equatable {
  const MovieListEvent();

  @override
  List<Object> get props => [];
}

class OnRequestedTopRatedMovies extends MovieListEvent {
  const OnRequestedTopRatedMovies();

  @override
  List<Object> get props => [];
}

class OnRequestedNowPlayingMovies extends MovieListEvent {
  const OnRequestedNowPlayingMovies();

  @override
  List<Object> get props => [];
}

class OnRequestedPopularMovies extends MovieListEvent {
  const OnRequestedPopularMovies();

  @override
  List<Object> get props => [];
}
