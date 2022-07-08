part of 'movie_popular_bloc.dart';

@immutable
abstract class PopularMoviesEvent extends Equatable {
const PopularMoviesEvent();

@override
List<Object> get props => [];
}

class OnRequested extends PopularMoviesEvent {

const OnRequested();

@override
List<Object> get props => [];
}

