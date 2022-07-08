part of 'tv_detail_recommendation_bloc.dart';

@immutable
abstract class TvDetailRecommendationEvent extends Equatable {
  const TvDetailRecommendationEvent();

  @override
  List<Object> get props => [];
}

class OnRequestedTvRecommendation extends TvDetailRecommendationEvent {
  final int query;

  const OnRequestedTvRecommendation(this.query);

  @override
  List<Object> get props => [query];
}
