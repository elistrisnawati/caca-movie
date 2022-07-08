import 'package:dartz/dartz.dart';
import 'package:module_generic/common/failure.dart';
import 'package:module_movie/domain/entities/movie/movie.dart';
import 'package:module_movie/domain/repositories/movie/movie_repository.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchMovies(query);
  }
}
