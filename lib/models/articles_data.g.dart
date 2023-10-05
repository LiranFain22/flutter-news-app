// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArticlesDataAdapter extends TypeAdapter<ArticlesData> {
  @override
  final int typeId = 2;

  @override
  ArticlesData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArticlesData(
      status: fields[0] as String,
      totalResults: fields[1] as int,
      articles: (fields[2] as List).cast<Article>(),
    );
  }

  @override
  void write(BinaryWriter writer, ArticlesData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.totalResults)
      ..writeByte(2)
      ..write(obj.articles);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArticlesDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
