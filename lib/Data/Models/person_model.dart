import 'dart:convert';

import 'package:celia_movies/Constants/Enums/media_types.dart';

PersonModel personModelFromJson(String str) =>
    PersonModel.fromJson(json.decode(str));

String personModelToJson(PersonModel data) => json.encode(data.toJson());

class PersonModel {
  PersonModel({
    this.profilePath,
    this.adult,
    this.id,
    this.knownFor,
    this.name,
    this.popularity,
  });

  String? profilePath;
  bool? adult;
  int? id;
  List<KnownFor>? knownFor;
  String? name;
  num? popularity;

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
        profilePath: json["profile_path"] ?? '',
        adult: json["adult"] ?? false,
        id: json["id"] ?? 0,
        knownFor: List<KnownFor>.from(
            json["known_for"].map((x) => KnownFor.fromJson(x))),
        name: json["name"] ?? '',
        popularity: json["popularity"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "profile_path": profilePath,
        "adult": adult,
        "id": id,
        "known_for": List<dynamic>.from(knownFor!.map((x) => x.toJson())),
        "name": name,
        "popularity": popularity,
      };
}

class KnownFor {
  KnownFor({
    this.posterPath,
    this.adult,
    this.overview,
    this.releaseDate,
    this.originalTitle,
    this.genreIds,
    this.id,
    this.mediaType,
    this.originalLanguage,
    this.title,
    this.backdropPath,
    this.popularity,
    this.voteCount,
    this.video,
    this.voteAverage,
    this.firstAirDate,
    this.originCountry,
    this.name,
    this.originalName,
  });

  String? posterPath;
  bool? adult;
  String? overview;
  DateTime? releaseDate;
  String? originalTitle;
  List<int>? genreIds;
  int? id;
  MediaType? mediaType;
  OriginalLanguage? originalLanguage;
  String? title;
  String? backdropPath;
  num? popularity;
  int? voteCount;
  bool? video;
  num? voteAverage;
  DateTime? firstAirDate;
  List<String>? originCountry;
  String? name;
  String? originalName;

  factory KnownFor.fromJson(Map<String, dynamic> json) => KnownFor(
        posterPath: json["poster_path"] ?? '',
        adult: json["adult"] ?? false,
        overview: json["overview"],
        releaseDate: json["release_date"] == null
            ? null
            : DateTime.parse(json["release_date"]),
        originalTitle: json["original_title"] ?? '',
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        mediaType: mediaTypeValues.map![json["media_type"]],
        originalLanguage:
            originalLanguageValues.map![json["original_language"]],
        title: json["title"] ?? '',
        backdropPath: json["backdrop_path"],
        popularity: json["popularity"],
        voteCount: json["vote_count"],
        video: json["video"] ?? false,
        voteAverage: json["vote_average"],
        firstAirDate: json["first_air_date"] == null
            ? null
            : DateTime.parse(json["first_air_date"]),
        originCountry: json["origin_country"] == null
            ? null
            : List<String>.from(json["origin_country"].map((x) => x)),
        name: json["name"] ?? '',
        originalName: json["original_name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "poster_path": posterPath,
        "adult": adult ?? '',
        "overview": overview,
        "release_date": releaseDate == null
            ? null
            : "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "original_title": originalTitle ?? '',
        "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
        "id": id,
        "media_type": mediaTypeValues.reverse[mediaType],
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "title": title ?? '',
        "backdrop_path": backdropPath,
        "popularity": popularity,
        "vote_count": voteCount,
        "video": video ?? '',
        "vote_average": voteAverage,
        "first_air_date": firstAirDate == null
            ? null
            : "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
        "origin_country": originCountry == null
            ? null
            : List<dynamic>.from(originCountry!.map((x) => x)),
        "name": name ?? '',
        "original_name": originalName ?? '',
      };
}

final mediaTypeValues =
    EnumValues({"movie": MediaType.movie, "tv": MediaType.tv});

enum OriginalLanguage { en, cn }

final originalLanguageValues =
    EnumValues({"cn": OriginalLanguage.cn, "en": OriginalLanguage.en});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map!.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
