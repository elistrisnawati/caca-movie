part of 'tv_detail_recommendation_bloc.dart';

@immutable
abstract class TvDetailRecommendationState extends Equatable {
  const TvDetailRecommendationState();

  @override
  List<Object> get props => [];
}

class TvDetailRecommendationEmpty extends TvDetailRecommendationState {}

class TvDetailRecommendationLoading extends TvDetailRecommendationState {}

class TvDetailRecommendationError extends TvDetailRecommendationState {
  final String message;

  const TvDetailRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class TvDetailRecommendationHasData extends TvDetailRecommendationState {
  late List<Tv> tvRecommendations = [];

  TvDetailRecommendationHasData();

  @override
  List<Object> get props => [tvRecommendations];
}
