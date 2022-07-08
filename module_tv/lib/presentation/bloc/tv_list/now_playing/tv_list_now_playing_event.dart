part of 'tv_list_now_playing_bloc.dart';

@immutable
abstract class TvListNowPlayingEvent extends Equatable {
  const TvListNowPlayingEvent();

  @override
  List<Object> get props => [];
}

class OnRequestedNowPlayingTvs extends TvListNowPlayingEvent {
  const OnRequestedNowPlayingTvs();

  @override
  List<Object> get props => [];
}
