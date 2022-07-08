import 'package:dartz/dartz.dart';
import 'package:module_generic/common/failure.dart';
import 'package:module_tv/domain/entities/tv/tv_detail.dart';
import 'package:module_tv/domain/repositories/tv/tv_repository.dart';

class GetTvDetail {
  final TvRepository repository;

  GetTvDetail(this.repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repository.getTvDetail(id);
  }
}
