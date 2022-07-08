part of 'tv_detail_bloc.dart';

@immutable
abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}

class OnRequestedTvDetail extends TvDetailEvent {
  final int query;

  const OnRequestedTvDetail(this.query);

  @override
  List<Object> get props => [query];
}
