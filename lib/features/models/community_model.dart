
import 'package:flutter/foundation.dart';

class Community {

  final String id;
  final String name;
  final String banner;
  final String dp;
  List<String> members;
  List<String> mods;
  Community({
    required this.id,
    required this.name,
    required this.banner,
    required this.dp,
    required this.members,
    required this.mods,
  });
  

  Community copyWith({
    String? id,
    String? name,
    String? banner,
    String? dp,
    List<String>? members,
    List<String>? mods,
  }) {
    return Community(
      id: id ?? this.id,
      name: name ?? this.name,
      banner: banner ?? this.banner,
      dp: dp ?? this.dp,
      members: members ?? this.members,
      mods: mods ?? this.mods,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'banner': banner,
      'dp': dp,
      'members': members,
      'mods': mods,
    };
  }

factory Community.fromMap(Map<String, dynamic> map) {
    return Community(
      id: map['id'] as String,
      name: map['name'] as String,
      banner: map['banner'] as String,
      dp: map['dp'] as String,
      members: List<String>.from(map['members']),
      mods: List<String>.from(map['mods']),
    );
  }

  @override
  String toString() {
    return 'Community(id: $id, name: $name, banner: $banner, dp: $dp, members: $members, mods: $mods)';
  }

  @override
  bool operator ==(covariant Community other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.banner == banner &&
      other.dp == dp &&
      listEquals(other.members, members) &&
      listEquals(other.mods, mods);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      banner.hashCode ^
      dp.hashCode ^
      members.hashCode ^
      mods.hashCode;
  }
}
