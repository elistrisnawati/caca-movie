import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:module_movie/domain/entities/movie/movie.dart';
import 'package:module_movie/domain/usecases/movie/get_movie_recommendations.dart';

part 'movie_detail_recommendation_event.dart';
part 'movie_detail_recommendation_state.dart';

class MovieDetailRecommendationBloc extends Bloc<MovieDetailRecommendationEvent,
    MovieDetailRecommendationState> {
  final GetMovieRecommendations _getMovieRecommendations;

  final MovieDetailRecommendationHasData movieDetailHasData =
      MovieDetailRecommendationHasData();

  MovieDetailRecommendationBloc(this._getMovieRecommendations)
      : super(MovieDetailRecommendationEmpty()) {
    on<OnRequestedMovieRecommendation>(
      (event, emit) async {
        final query = event.query;

        emit(MovieDetailRecommendationLoading());
        final result = await _getMovieRecommendations.execute(query);

        result.fold(
          (failure) {
            emit(MovieDetailRecommendationError(failure.message));
          },
          (data) {
            movieDetailHasData.movieRecommendations = data;
            emit(movieDetailHasData);
          },
        );
      },
    );
  }
}
