// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Collection _$CollectionFromJson(Map<String, dynamic> json) {
  return Collection(
    uuid: json['uuid'] as String,
    name: json['name'] as String,
    isTabu: json['isTabu'] as bool,
    questions: (json['questions'] as List<dynamic>)
        .map((e) => Question.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CollectionToJson(Collection instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'isTabu': instance.isTabu,
      'questions': instance.questions.map((e) => e.toJson()).toList(),
    };
