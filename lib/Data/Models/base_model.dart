import 'dart:convert';

import 'package:celia_movies/Data/Models/person_model.dart';

BaseModel baseModelFromJson(String str) => BaseModel.fromJson(json.decode(str));

String baseModelToJson(BaseModel data) => json.encode(data.toJson());

class BaseModel {
  BaseModel({
    this.page,
    this.totalResults,
    this.totalPages,
    this.results,
  });

  int? page;
  List<PersonModel>? results;
  int? totalResults;
  int? totalPages;

  factory BaseModel.fromJson(Map<String, dynamic> json) => BaseModel(
        page: json["page"] ?? 0,
        results: json["results"] == null
            ? []
            : List<PersonModel>.from(
                json["results"].map((x) => PersonModel.fromJson(x))),
        totalResults: json["total_results"] ?? 0,
        totalPages: json["total_pages"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<PersonModel>.from(results!.map((x) => x.toJson())),
        "total_results": totalResults,
        "total_pages": totalPages,
      };
}
