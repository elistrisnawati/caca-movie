part of 'movie_detail_bloc.dart';

@immutable
abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class OnRequestedMovieDetail extends MovieDetailEvent {
  final int query;

  const OnRequestedMovieDetail(this.query);

  @override
  List<Object> get props => [query];
}
