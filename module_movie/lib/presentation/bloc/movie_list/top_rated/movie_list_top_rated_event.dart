part of 'movie_list_top_rated_bloc.dart';

@immutable
abstract class MovieListTopRatedEvent extends Equatable {
  const MovieListTopRatedEvent();

  @override
  List<Object> get props => [];
}

class OnRequestedTopRatedMovies extends MovieListTopRatedEvent {
  const OnRequestedTopRatedMovies();

  @override
  List<Object> get props => [];
}
