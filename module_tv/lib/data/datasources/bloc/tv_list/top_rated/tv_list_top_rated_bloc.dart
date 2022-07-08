import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:module_tv/domain/entities/tv/tv.dart';
import 'package:module_tv/domain/usecases/tv/get_top_rated_tvs.dart';

part 'tv_list_top_rated_event.dart';
part 'tv_list_top_rated_state.dart';

class TvListTopRatedBloc extends Bloc<TvListTopRatedEvent, TopRatedTvsState> {
  final GetTopRatedTvs _getTopRatedTvs;

  TvListTopRatedBloc(this._getTopRatedTvs) : super(TopRatedTvsEmpty()) {
    on<OnRequestedTopRatedTvs>(
      (event, emit) async {
        print("_fetchTopRatedTvs");

        emit(TopRatedTvsLoading());
        final result = await _getTopRatedTvs.execute();

        result.fold(
          (failure) {
            emit(TopRatedTvsError(failure.message));
          },
          (data) {
            emit(TopRatedTvsHasData(data));
          },
        );

        print("_fetchTopRatedTvs DONE");
      },
    );
  }
}
