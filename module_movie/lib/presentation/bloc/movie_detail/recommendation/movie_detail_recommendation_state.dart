part of 'movie_detail_recommendation_bloc.dart';

@immutable
abstract class MovieDetailRecommendationState extends Equatable {
  const MovieDetailRecommendationState();

  @override
  List<Object> get props => [];
}

class MovieDetailRecommendationEmpty extends MovieDetailRecommendationState {}

class MovieDetailRecommendationLoading extends MovieDetailRecommendationState {}

class MovieDetailRecommendationError extends MovieDetailRecommendationState {
  final String message;

  const MovieDetailRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailRecommendationHasData extends MovieDetailRecommendationState {
  late List<Movie> movieRecommendations = [];

  MovieDetailRecommendationHasData();

  @override
  List<Object> get props => [movieRecommendations];
}
