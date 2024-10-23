// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      displayName: fields[0] as String,
      username: fields[1] as String,
      institute: fields[2] as String,
      profile: fields[3] as String,
      followers: fields[5] as int,
      following: fields[4] as int,
      documents: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.displayName)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.institute)
      ..writeByte(3)
      ..write(obj.profile)
      ..writeByte(4)
      ..write(obj.following)
      ..writeByte(5)
      ..write(obj.followers)
      ..writeByte(6)
      ..write(obj.documents);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
