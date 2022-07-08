part of 'tv_list_popular_bloc.dart';

@immutable
abstract class TvListPopularEvent extends Equatable {
  const TvListPopularEvent();

  @override
  List<Object> get props => [];
}

class OnRequestedPopularTvs extends TvListPopularEvent {
  const OnRequestedPopularTvs();

  @override
  List<Object> get props => [];
}
