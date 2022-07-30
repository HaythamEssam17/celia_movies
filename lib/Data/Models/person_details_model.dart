import 'dart:convert';

PersonDetailsModel personDetailsModelFromJson(String str) =>
    PersonDetailsModel.fromJson(json.decode(str));

String personDetailsModelToJson(PersonDetailsModel data) =>
    json.encode(data.toJson());

class PersonDetailsModel {
  PersonDetailsModel({
    this.birthday,
    this.knownForDepartment,
    this.deathday,
    this.id,
    this.name,
    this.alsoKnownAs,
    this.gender,
    this.biography,
    this.popularity,
    this.placeOfBirth,
    this.profilePath,
    this.adult,
    this.imdbId,
    this.homepage,
  });

  DateTime? birthday;
  String? knownForDepartment;
  DateTime? deathday;
  int? id;
  String? name;
  List<String>? alsoKnownAs;
  int? gender;
  String? biography;
  double? popularity;
  String? placeOfBirth;
  String? profilePath;
  bool? adult;
  String? imdbId;
  dynamic homepage;

  factory PersonDetailsModel.fromJson(Map<String, dynamic> json) =>
      PersonDetailsModel(
        birthday: json["birthday"] == null
            ? DateTime.now()
            : DateTime.parse(json["birthday"]),
        knownForDepartment: json["known_for_department"] ?? '',
        deathday: json["deathday"] == null
            ? DateTime.now()
            : DateTime.parse(json["deathday"]),
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        alsoKnownAs: json["also_known_as"] == null
            ? []
            : List<String>.from(json["also_known_as"].map((x) => x)),
        gender: json["gender"] ?? 0,
        biography: json["biography"] ?? '',
        popularity: json["popularity"].toDouble(),
        placeOfBirth: json["place_of_birth"] ?? '',
        profilePath: json["profile_path"] ?? '',
        adult: json["adult"] ?? false,
        imdbId: json["imdb_id"] ?? '0',
        homepage: json["homepage"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "birthday":
            "${birthday!.year.toString().padLeft(4, '0')}-${birthday!.month.toString().padLeft(2, '0')}-${birthday!.day.toString().padLeft(2, '0')}",
        "known_for_department": knownForDepartment,
        "deathday":
            "${deathday!.year.toString().padLeft(4, '0')}-${deathday!.month.toString().padLeft(2, '0')}-${deathday!.day.toString().padLeft(2, '0')}",
        "id": id,
        "name": name,
        "also_known_as": List<String>.from(alsoKnownAs!.map((x) => x)),
        "gender": gender,
        "biography": biography,
        "popularity": popularity,
        "place_of_birth": placeOfBirth,
        "profile_path": profilePath,
        "adult": adult,
        "imdb_id": imdbId,
        "homepage": homepage,
      };
}
