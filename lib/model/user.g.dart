// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      json['firstName'] as String,
      json['lastName'] as String,
      json['email'] as String,
      json['password'] as String,
      json['enabled'] as bool,
      json['age'] as int)
    ..id = json['id'] as int;
}

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['firstName'] = instance.firstName;
  val['lastName'] = instance.lastName;
  val['email'] = instance.email;
  val['password'] = instance.password;
  val['enabled'] = instance.enabled;
  val['age'] = instance.age;
  return val;
}
