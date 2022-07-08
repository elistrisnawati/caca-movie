import 'package:dartz/dartz.dart';
import 'package:module_generic/common/failure.dart';
import 'package:module_movie/domain/entities/movie/movie_detail.dart';
import 'package:module_movie/domain/repositories/movie/movie_repository.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
