part of 'movie_detail_bloc.dart';

@immutable
abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailEmpty extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailError extends MovieDetailState {
  final String message;

  const MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailHasData extends MovieDetailState {
  late MovieDetail movie;
  late bool isAddedToWatchlist = false;
  late List<Movie> movieRecommendations = [];

  MovieDetailHasData();

  @override
  List<Object> get props => [movie, isAddedToWatchlist, movieRecommendations];
}
