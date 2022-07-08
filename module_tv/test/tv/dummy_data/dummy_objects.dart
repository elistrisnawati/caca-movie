import 'package:module_generic/domain/entities/genre.dart';
import 'package:module_tv/data/models/tv/tv_table.dart';
import 'package:module_tv/domain/entities/tv/tv.dart';
import 'package:module_tv/domain/entities/tv/tv_detail.dart';

final testTv = Tv(
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  voteAverage: 7.2,
  voteCount: 13507,
  // additional
  firstAirDate: "firstAirDate",
  name: "name",
  originCountry: ["originCountry"],
  originalLanguage: "originalLanguage",
  originalName: "originalName",
);

final testTvList = [testTv];

final testTvDetail = TvDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  voteAverage: 1,
  voteCount: 1,
  // additional
  firstAirDate: "firstAirDate",
  name: "name",
  originCountry: ["originCountry"],
  originalName: "originalName",
  inProduction: false,
  numberOfEpisodes: 0,
  lastAirDate: "lastAirDate",
  episodeRunTime: [0],
  numberOfSeasons: 0,
  type: "numberOfSeasons",
  languages: ["languages"],
  homepage: 'homepage',
  originalLanguage: 'originalLanguage',
  popularity: 0.0,
  status: 'status',
  tagline: 'tagline',
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  posterPath: 'posterPath',
  overview: 'overview',
  // additional
  name: "name",
);

final testTvTable = TvTable(
  id: 1,
  posterPath: 'posterPath',
  overview: 'overview',
  // additional
  name: "name",
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
