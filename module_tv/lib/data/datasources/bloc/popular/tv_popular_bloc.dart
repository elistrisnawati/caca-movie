import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:module_tv/domain/entities/tv/tv.dart';
import 'package:module_tv/domain/usecases/tv/get_popular_tvs.dart';

part 'tv_popular_event.dart';
part 'tv_popular_state.dart';

class PopularTvsBloc extends Bloc<PopularTvsEvent, PopularTvsState> {
  final GetPopularTvs _getPopularTvs;

  PopularTvsBloc(this._getPopularTvs) : super(PopularTvsEmpty()) {
    on<OnRequested>(
      (event, emit) async {
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
      },
    );
  }
}
