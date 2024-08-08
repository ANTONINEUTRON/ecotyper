// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map json) => _$UserImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      isVerified: json['isVerified'] as bool? ?? false,
      displayPics: json['displayPics'] as String? ?? "",
      userMeta: json['userMeta'] == null
          ? null
          : UserMeta.fromJson(
              Map<String, dynamic>.from(json['userMeta'] as Map)),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'isVerified': instance.isVerified,
      'displayPics': instance.displayPics,
      'userMeta': instance.userMeta?.toJson(),
    };
