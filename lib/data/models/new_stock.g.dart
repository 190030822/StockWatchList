// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_stock.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewStockAdapter extends TypeAdapter<NewStock> {
  @override
  final int typeId = 2;

  @override
  NewStock read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewStock(
      fields[1] as String,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NewStock obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.companyName)
      ..writeByte(2)
      ..write(obj.symbol);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewStockAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
