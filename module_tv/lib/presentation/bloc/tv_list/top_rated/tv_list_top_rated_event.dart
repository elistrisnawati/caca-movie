part of 'tv_list_top_rated_bloc.dart';

@immutable
abstract class TvListTopRatedEvent extends Equatable {
  const TvListTopRatedEvent();

  @override
  List<Object> get props => [];
}

class OnRequestedTopRatedTvs extends TvListTopRatedEvent {
  const OnRequestedTopRatedTvs();

  @override
  List<Object> get props => [];
}
