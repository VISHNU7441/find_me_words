// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordModel _$WordModelFromJson(Map<String, dynamic> json) => WordModel(
  word: json['word'] as String,
  phonetic: json['phonetic'] as String?,
  phonetics: (json['phonetics'] as List<dynamic>)
      .map((e) => PhoneticModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  meanings: (json['meanings'] as List<dynamic>)
      .map((e) => MeaningModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  license: json['license'] == null
      ? null
      : LicenseModel.fromJson(json['license'] as Map<String, dynamic>),
  sourceUrls: (json['sourceUrls'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$WordModelToJson(WordModel instance) => <String, dynamic>{
  'word': instance.word,
  'phonetic': instance.phonetic,
  'phonetics': instance.phonetics,
  'meanings': instance.meanings,
  'license': instance.license,
  'sourceUrls': instance.sourceUrls,
};

PhoneticModel _$PhoneticModelFromJson(Map<String, dynamic> json) =>
    PhoneticModel(
      text: json['text'] as String?,
      audio: json['audio'] as String?,
      sourceUrl: json['sourceUrl'] as String?,
      license: json['license'] == null
          ? null
          : LicenseModel.fromJson(json['license'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PhoneticModelToJson(PhoneticModel instance) =>
    <String, dynamic>{
      'text': instance.text,
      'audio': instance.audio,
      'sourceUrl': instance.sourceUrl,
      'license': instance.license,
    };

MeaningModel _$MeaningModelFromJson(Map<String, dynamic> json) => MeaningModel(
  partOfSpeech: json['partOfSpeech'] as String,
  definitions: (json['definitions'] as List<dynamic>)
      .map((e) => DefinitionModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  synonyms: (json['synonyms'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  antonyms: (json['antonyms'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$MeaningModelToJson(MeaningModel instance) =>
    <String, dynamic>{
      'partOfSpeech': instance.partOfSpeech,
      'definitions': instance.definitions,
      'synonyms': instance.synonyms,
      'antonyms': instance.antonyms,
    };

DefinitionModel _$DefinitionModelFromJson(Map<String, dynamic> json) =>
    DefinitionModel(
      definition: json['definition'] as String,
      synonyms: (json['synonyms'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      antonyms: (json['antonyms'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$DefinitionModelToJson(DefinitionModel instance) =>
    <String, dynamic>{
      'definition': instance.definition,
      'synonyms': instance.synonyms,
      'antonyms': instance.antonyms,
    };

LicenseModel _$LicenseModelFromJson(Map<String, dynamic> json) =>
    LicenseModel(name: json['name'] as String, url: json['url'] as String);

Map<String, dynamic> _$LicenseModelToJson(LicenseModel instance) =>
    <String, dynamic>{'name': instance.name, 'url': instance.url};
