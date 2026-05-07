import 'package:json_annotation/json_annotation.dart';

part 'word_model.g.dart';

typedef DictionaryResponse = List<WordModel>;

@JsonSerializable()
class WordModel {
  final String word;
  final String? phonetic;
  final List<PhoneticModel> phonetics;
  final List<MeaningModel> meanings;
  final LicenseModel? license;
  final List<String> sourceUrls;

  WordModel({
    required this.word,
    this.phonetic,
    required this.phonetics,
    required this.meanings,
    this.license,
    required this.sourceUrls,
  });

  factory WordModel.fromJson(Map<String, dynamic> json) =>
      _$WordModelFromJson(json);

  Map<String, dynamic> toJson() => _$WordModelToJson(this);
}

// ------------------------
@JsonSerializable()
class PhoneticModel {
  final String? text;
  final String? audio;
  final String? sourceUrl;
  final LicenseModel? license;

  PhoneticModel({
    this.text,
    this.audio,
    this.sourceUrl,
    this.license,
  });

  factory PhoneticModel.fromJson(Map<String, dynamic> json) =>
      _$PhoneticModelFromJson(json);

  Map<String, dynamic> toJson() => _$PhoneticModelToJson(this);
}

// ----------------------------
@JsonSerializable()
class MeaningModel {
  final String partOfSpeech;
  final List<DefinitionModel> definitions;
  final List<String> synonyms;
  final List<String> antonyms;

  MeaningModel({
    required this.partOfSpeech,
    required this.definitions,
    required this.synonyms,
    required this.antonyms,
  });

  factory MeaningModel.fromJson(Map<String, dynamic> json) =>
      _$MeaningModelFromJson(json);

  Map<String, dynamic> toJson() => _$MeaningModelToJson(this);
}


// -----------------------------
@JsonSerializable()
class DefinitionModel {
  final String definition;
  final List<String> synonyms;
  final List<String> antonyms;

  DefinitionModel({
    required this.definition,
    required this.synonyms,
    required this.antonyms,
  });

  factory DefinitionModel.fromJson(Map<String, dynamic> json) =>
      _$DefinitionModelFromJson(json);

  Map<String, dynamic> toJson() => _$DefinitionModelToJson(this);
}

// ---------------------------
@JsonSerializable()
class LicenseModel {
  final String name;
  final String url;

  LicenseModel({
    required this.name,
    required this.url,
  });

  factory LicenseModel.fromJson(Map<String, dynamic> json) =>
      _$LicenseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LicenseModelToJson(this);
}
