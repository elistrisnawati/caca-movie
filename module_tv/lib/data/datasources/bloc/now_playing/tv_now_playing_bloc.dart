import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:module_tv/domain/entities/tv/tv.dart';
import 'package:module_tv/domain/usecases/tv/get_now_playing_tvs.dart';

part 'tv_now_playing_event.dart';
part 'tv_now_playing_state.dart';

class NowPlayingTvsBloc extends Bloc<NowPlayingTvsEvent, NowPlayingTvsState> {
  final GetNowPlayingTvs _getNowPlayingTvs;

  NowPlayingTvsBloc(this._getNowPlayingTvs) : super(NowPlayingTvsEmpty()) {
    on<OnRequested>(
      (event, emit) async {
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
      },
    );
  }
}
