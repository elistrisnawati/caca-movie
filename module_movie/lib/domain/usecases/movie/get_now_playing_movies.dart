import 'package:dartz/dartz.dart';
import 'package:module_generic/common/failure.dart';
import 'package:module_movie/domain/entities/movie/movie.dart';
import 'package:module_movie/domain/repositories/movie/movie_repository.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getNowPlayingMovies();
  }
}
