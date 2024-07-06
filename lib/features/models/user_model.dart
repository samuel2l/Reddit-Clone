// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  final String name;
  final String dp;
  final String banner;
  final String uId;
  final bool isUser;
  final int karma;
  final List<String> awards;
  UserModel({
    required this.name,
    required this.dp,
    required this.banner,
    required this.uId,
    required this.isUser,
    required this.karma,
    required this.awards,
  });
  

  UserModel copyWith({
    String? name,
    String? dp,
    String? banner,
    String? uId,
    bool? isUser,
    int? karma,
    List<String>? awards,
  }) {
    return UserModel(
      name: name ?? this.name,
      dp: dp ?? this.dp,
      banner: banner ?? this.banner,
      uId: uId ?? this.uId,
      isUser: isUser ?? this.isUser,
      karma: karma ?? this.karma,
      awards: awards ?? this.awards,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'dp': dp,
      'banner': banner,
      'uId': uId,
      'isUser': isUser,
      'karma': karma,
      'awards': awards,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      dp: map['dp'] as String,
      banner: map['banner'] as String,
      uId: map['uId'] as String,
      isUser: map['isUser'] as bool,
      karma: map['karma'] as int,
      awards: List<String>.from((map['awards'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, dp: $dp, banner: $banner, uId: $uId, isUser: $isUser, karma: $karma, awards: $awards)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.dp == dp &&
      other.banner == banner &&
      other.uId == uId &&
      other.isUser == isUser &&
      other.karma == karma &&
      listEquals(other.awards, awards);
  }

  @override
  int get hashCode {
    return name.hashCode ^
      dp.hashCode ^
      banner.hashCode ^
      uId.hashCode ^
      isUser.hashCode ^
      karma.hashCode ^
      awards.hashCode;
  }
}
