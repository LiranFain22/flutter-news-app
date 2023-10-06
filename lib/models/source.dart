
import 'package:hive_flutter/hive_flutter.dart';

part 'source.g.dart';

@HiveType(typeId: 3)
class Source {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? name;

  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}