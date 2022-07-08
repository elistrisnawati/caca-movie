import 'package:equatable/equatable.dart';
import 'package:module_generic/domain/entities/genre.dart';

class TvDetail extends Equatable {
  TvDetail({
    required this.adult,
    required this.backdropPath,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,

    // required this.createdBy,
    // required this.networks,
    // required this.productionCompanies,
    // required this.productionCountries,
    // required this.lastEpisodeToAir,
    // required this.nextEpisodeToAir,
    // required this.seasons,
    // required this.spokenLanguages,
  });

  final bool adult;
  final String backdropPath;
  final List<int> episodeRunTime;
  final String firstAirDate;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final bool inProduction;
  final List<String> languages;
  final String lastAirDate;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

  // final List<CreatedBy> createdBy;
  // final List<Network> networks;
  // final TEpisodeToAir lastEpisodeToAir;
  // final TEpisodeToAir nextEpisodeToAir;
  // final List<Network> productionCompanies;
  // final List<ProductionCountry> productionCountries;
  // final List<Season> seasons;
  // final List<SpokenLanguage> spokenLanguages;

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        episodeRunTime,
        firstAirDate,
        genres,
        homepage,
        id,
        inProduction,
        languages,
        lastAirDate,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,

        // createdBy,
        // networks,
        // lastEpisodeToAir,
        // nextEpisodeToAir,
        // productionCompanies,
        // productionCountries,
        // seasons,
        // spokenLanguages,
      ];
}
