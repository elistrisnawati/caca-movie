part of 'movie_detail_recommendation_bloc.dart';

@immutable
abstract class MovieDetailRecommendationEvent extends Equatable {
  const MovieDetailRecommendationEvent();

  @override
  List<Object> get props => [];
}

class OnRequestedMovieRecommendation extends MovieDetailRecommendationEvent {
  final int query;

  const OnRequestedMovieRecommendation(this.query);

  @override
  List<Object> get props => [query];
}
