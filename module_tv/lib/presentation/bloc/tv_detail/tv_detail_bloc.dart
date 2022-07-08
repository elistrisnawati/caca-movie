import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:module_tv/domain/entities/tv/tv_detail.dart';
import 'package:module_tv/domain/usecases/tv/get_tv_detail.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail _getTvDetail;

  late String watchlistMessage = "";

  final TvDetailHasData tvDetailHasData = TvDetailHasData();

  TvDetailBloc(
    this._getTvDetail,
  ) : super(TvDetailEmpty()) {
    on<OnRequestedTvDetail>(
      (event, emit) async {
        final query = event.query;

        emit(TvDetailLoading());
        final result = await _getTvDetail.execute(query);

        result.fold(
          (failure) {
            emit(TvDetailError(failure.message));
          },
          (data) {
            tvDetailHasData.tv = data;
            emit(tvDetailHasData);
          },
        );
      },
    );
  }
}
