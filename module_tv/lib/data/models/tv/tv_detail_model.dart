import 'package:equatable/equatable.dart';
import 'package:module_generic/data/models/genre_model.dart';
import 'package:module_tv/domain/entities/tv/tv_detail.dart';

class TvDetailResponse extends Equatable {
  const TvDetailResponse({
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
    // required this.seasons,
    // required this.spokenLanguages,
    // required this.lastEpisodeToAir,
    // required this.nextEpisodeToAir,
  });

  final bool adult;
  final String backdropPath;
  final List<int> episodeRunTime;
  final String firstAirDate;
  final List<GenreModel> genres;
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
  // final List<Network> productionCompanies;
  // final List<ProductionCountry> productionCountries;
  // final List<Season> seasons;
  // final List<SpokenLanguage> spokenLanguages;
  // final TEpisodeToAir lastEpisodeToAir;
  // final TEpisodeToAir nextEpisodeToAir;

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvDetailResponse(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"] ?? "",
        episodeRunTime: json["episode_run_time"] == null
            ? []
            : List<int>.from(json["episode_run_time"].map((x) => x)),
        firstAirDate: json["first_air_date"] ?? "",
        genres: json["genres"] == null
            ? []
            : List<GenreModel>.from(
                json["genres"].map((x) => GenreModel.fromJson(x))),
        homepage: json["homepage"] ?? "",
        id: json["id"] ?? "",
        inProduction: json["in_production"] ?? "",
        languages: json["languages"] == null
            ? []
            : List<String>.from(json["languages"].map((x) => x)),
        lastAirDate: json["last_air_date"] ?? "",
        name: json["name"] ?? "",
        numberOfEpisodes: json["number_of_episodes"] ?? "",
        numberOfSeasons: json["number_of_seasons"] ?? "",
        originCountry: json["origin_country"] == null
            ? []
            : List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"] ?? "",
        originalName: json["original_name"] ?? "",
        overview: json["overview"] ?? "",
        popularity:
            json["popularity"] == null ? 0.0 : json["popularity"].toDouble(),
        posterPath: json["poster_path"] ?? "",
        status: json["status"] ?? "",
        tagline: json["tagline"] ?? "",
        type: json["type"] ?? "",
        voteAverage: json["vote_average"] == null
            ? 0.0
            : json["vote_average"].toDouble(),
        voteCount: json["vote_count"] ?? "",

        // createdBy: List<CreatedBy>.from(
        //     json["created_by"].map((x) => CreatedBy.fromJson(x))),
        // networks: List<Network>.from(
        //     json["networks"].map((x) => Network.fromJson(x))),
        // productionCompanies: List<Network>.from(
        //     json["production_companies"].map((x) => Network.fromJson(x))),
        // seasons:
        // List<Season>.from(json["seasons"].map((x) => Season.fromJson(x))),
        // productionCountries: List<ProductionCountry>.from(
        //     json["production_countries"]
        //         .map((x) => ProductionCountry.fromJson(x))),
        // spokenLanguages: List<SpokenLanguage>.from(
        //     json["spoken_languages"].map((x) => SpokenLanguage.fromJson(x))),
        // lastEpisodeToAir: TEpisodeToAir.fromJson(json["last_episode_to_air"]),
        // nextEpisodeToAir: TEpisodeToAir.fromJson(json["next_episode_to_air"]),
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
        "first_air_date": firstAirDate,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "in_production": inProduction,
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "last_air_date": lastAirDate,
        "name": name,
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "status": status,
        "tagline": tagline,
        "type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        // "created_by": List<dynamic>.from(createdBy.map((x) => x.toJson())),
        // "networks": List<dynamic>.from(networks.map((x) => x.toJson())),
        // "production_companies":
        // List<dynamic>.from(productionCompanies.map((x) => x.toJson())),
        // "production_countries":
        // List<dynamic>.from(productionCountries.map((x) => x.toJson())),
        // "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
        // "spoken_languages":
        // List<dynamic>.from(spokenLanguages.map((x) => x.toJson())),
        // "last_episode_to_air": lastEpisodeToAir.toJson(),
        // "next_episode_to_air": nextEpisodeToAir.toJson(),
      };

  TvDetail toEntity() {
    return TvDetail(
      adult: adult,
      backdropPath: backdropPath,
      episodeRunTime: episodeRunTime,
      firstAirDate: firstAirDate,
      genres: genres.map((genre) => genre.toEntity()).toList(),
      homepage: homepage,
      id: id,
      inProduction: inProduction,
      languages: languages,
      lastAirDate: lastAirDate,
      name: name,
      numberOfEpisodes: numberOfEpisodes,
      numberOfSeasons: numberOfSeasons,
      originCountry: originCountry,
      originalLanguage: originalLanguage,
      originalName: originalName,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      status: status,
      tagline: tagline,
      type: type,
      voteAverage: voteAverage,
      voteCount: voteCount,
      // createdBy: this.createdBy,
      // networks: this.networks,
      // productionCompanies: this.productionCompanies,
      // productionCountries: this.productionCountries,
      // seasons: this.seasons,
      // spokenLanguages: this.spokenLanguages,
      // lastEpisodeToAir: this.lastEpisodeToAir,
      // nextEpisodeToAir: this.nextEpisodeToAir,
    );
  }

  @override
  // TODO: implement props
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
        // productionCompanies,
        // productionCountries,
        // seasons,
        // spokenLanguages,
        // lastEpisodeToAir,
        // nextEpisodeToAir,
      ];
}
