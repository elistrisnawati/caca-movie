import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:module_tv/domain/entities/tv/tv.dart';
import 'package:module_tv/domain/usecases/tv/get_now_playing_tvs.dart';

part 'tv_list_now_playing_event.dart';
part 'tv_list_now_playing_state.dart';

class TvListNowPlayingBloc
    extends Bloc<TvListNowPlayingEvent, NowPlayingTvsState> {
  final GetNowPlayingTvs _getNowPlayingTvs;

  TvListNowPlayingBloc(this._getNowPlayingTvs) : super(NowPlayingTvsEmpty()) {
    on<OnRequestedNowPlayingTvs>(
      (event, emit) async {
        print("_fetchNowPlayingTvs");

        emit(NowPlayingTvsLoading());
        final result = await _getNowPlayingTvs.execute();

        result.fold(
          (failure) {
            emit(NowPlayingTvsError(failure.message));
          },
          (data) {
            emit(NowPlayingTvsHasData(data));
          },
        );

        print("_fetchNowPlayingTvs DONE");
      },
    );
  }
}
