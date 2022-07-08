import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:module_tv/domain/entities/tv/tv.dart';
import 'package:module_tv/domain/usecases/tv/get_popular_tvs.dart';

part 'tv_list_popular_event.dart';
part 'tv_list_popular_state.dart';

class TvListPopularBloc extends Bloc<TvListPopularEvent, PopularTvsState> {
  final GetPopularTvs _getPopularTvs;

  TvListPopularBloc(this._getPopularTvs) : super(PopularTvsEmpty()) {
    on<OnRequestedPopularTvs>(
      (event, emit) async {
        print("_fetchPopularTvs");

        emit(PopularTvsLoading());
        final result = await _getPopularTvs.execute();

        result.fold(
          (failure) {
            emit(PopularTvsError(failure.message));
          },
          (data) {
            emit(PopularTvsHasData(data));
          },
        );

        print("_fetchPopularTvs DONE");
      },
    );
  }
}
