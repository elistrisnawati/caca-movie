import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:module_tv/domain/entities/tv/tv.dart';
import 'package:module_tv/domain/usecases/tv/get_tv_recommendations.dart';

part 'tv_detail_recommendation_event.dart';
part 'tv_detail_recommendation_state.dart';

class TvDetailRecommendationBloc
    extends Bloc<TvDetailRecommendationEvent, TvDetailRecommendationState> {
  final GetTvRecommendations _getTvRecommendations;

  final TvDetailRecommendationHasData tvDetailHasData =
      TvDetailRecommendationHasData();

  TvDetailRecommendationBloc(this._getTvRecommendations)
      : super(TvDetailRecommendationEmpty()) {
    on<OnRequestedTvRecommendation>(
      (event, emit) async {
        final query = event.query;

        emit(TvDetailRecommendationLoading());
        final result = await _getTvRecommendations.execute(query);

        result.fold(
          (failure) {
            emit(TvDetailRecommendationError(failure.message));
          },
          (data) {
            tvDetailHasData.tvRecommendations = data;
            emit(tvDetailHasData);
          },
        );
      },
    );
  }
}
