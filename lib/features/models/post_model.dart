// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Post {
  final String id;
  final String title;
  final String? link;
  final String? description;
  final String communityName;
  final String communityDp;
  final List<String> upvotes;
  final List<String> downvotes;
  final int commentCount;
  final String username;
  final String uId;
  final String type;
  final DateTime createdAt;
  final List<String> awards;
  Post({
    required this.id,
    required this.title,
    this.link,
    this.description,
    required this.communityName,
    required this.communityDp,
    required this.upvotes,
    required this.downvotes,
    required this.commentCount,
    required this.username,
    required this.uId,
    required this.type,
    required this.createdAt,
    required this.awards,
  });
  

  Post copyWith({
    String? id,
    String? title,
    String? link,
    String? description,
    String? communityName,
    String? communityDp,
    List<String>? upvotes,
    List<String>? downvotes,
    int? commentCount,
    String? username,
    String? uId,
    String? type,
    DateTime? createdAt,
    List<String>? awards,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      link: link ?? this.link,
      description: description ?? this.description,
      communityName: communityName ?? this.communityName,
      communityDp: communityDp ?? this.communityDp,
      upvotes: upvotes ?? this.upvotes,
      downvotes: downvotes ?? this.downvotes,
      commentCount: commentCount ?? this.commentCount,
      username: username ?? this.username,
      uId: uId ?? this.uId,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      awards: awards ?? this.awards,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'link': link,
      'description': description,
      'communityName': communityName,
      'communityDp': communityDp,
      'upvotes': upvotes,
      'downvotes': downvotes,
      'commentCount': commentCount,
      'username': username,
      'uId': uId,
      'type': type,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'awards': awards,
    };
  }

factory Post.fromMap(Map<String, dynamic> map) {
  return Post(
    id: map['id'] as String,
    title: map['title'] as String,
    link: map['link'] != null ? map['link'] as String : null,
    description: map['description'] != null ? map['description'] as String : null,
    communityName: map['communityName'] as String,
    communityDp: map['communityDp'] as String,
    upvotes: List<String>.from(map['upvotes'] as List),
    downvotes: List<String>.from(map['downvotes'] as List),
    commentCount: map['commentCount'] as int,
    username: map['username'] as String,
    uId: map['uId'] as String,
    type: map['type'] as String,
    createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    awards: List<String>.from(map['awards'] as List),
  );
}

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Post(id: $id, title: $title, link: $link, description: $description, communityName: $communityName, communityDp: $communityDp, upvotes: $upvotes, downvotes: $downvotes, commentCount: $commentCount, username: $username, uId: $uId, type: $type, createdAt: $createdAt, awards: $awards)';
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.link == link &&
      other.description == description &&
      other.communityName == communityName &&
      other.communityDp == communityDp &&
      listEquals(other.upvotes, upvotes) &&
      listEquals(other.downvotes, downvotes) &&
      other.commentCount == commentCount &&
      other.username == username &&
      other.uId == uId &&
      other.type == type &&
      other.createdAt == createdAt &&
      listEquals(other.awards, awards);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      link.hashCode ^
      description.hashCode ^
      communityName.hashCode ^
      communityDp.hashCode ^
      upvotes.hashCode ^
      downvotes.hashCode ^
      commentCount.hashCode ^
      username.hashCode ^
      uId.hashCode ^
      type.hashCode ^
      createdAt.hashCode ^
      awards.hashCode;
  }
}
