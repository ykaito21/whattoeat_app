// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_service.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Meal extends DataClass implements Insertable<Meal> {
  final int id;
  final String name;
  final String note;
  Meal({@required this.id, @required this.name, this.note});
  factory Meal.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Meal(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      note: stringType.mapFromDatabaseResponse(data['${effectivePrefix}note']),
    );
  }
  factory Meal.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Meal(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      note: serializer.fromJson<String>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'note': serializer.toJson<String>(note),
    };
  }

  @override
  MealsCompanion createCompanion(bool nullToAbsent) {
    return MealsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  Meal copyWith({int id, String name, String note}) => Meal(
        id: id ?? this.id,
        name: name ?? this.name,
        note: note ?? this.note,
      );
  @override
  String toString() {
    return (StringBuffer('Meal(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(name.hashCode, note.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Meal &&
          other.id == this.id &&
          other.name == this.name &&
          other.note == this.note);
}

class MealsCompanion extends UpdateCompanion<Meal> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> note;
  const MealsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.note = const Value.absent(),
  });
  MealsCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    this.note = const Value.absent(),
  }) : name = Value(name);
  MealsCompanion copyWith(
      {Value<int> id, Value<String> name, Value<String> note}) {
    return MealsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      note: note ?? this.note,
    );
  }
}

class $MealsTable extends Meals with TableInfo<$MealsTable, Meal> {
  final GeneratedDatabase _db;
  final String _alias;
  $MealsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _noteMeta = const VerificationMeta('note');
  GeneratedTextColumn _note;
  @override
  GeneratedTextColumn get note => _note ??= _constructNote();
  GeneratedTextColumn _constructNote() {
    return GeneratedTextColumn(
      'note',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, note];
  @override
  $MealsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'meals';
  @override
  final String actualTableName = 'meals';
  @override
  VerificationContext validateIntegrity(MealsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (d.note.present) {
      context.handle(
          _noteMeta, note.isAcceptableValue(d.note.value, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Meal map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Meal.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(MealsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.note.present) {
      map['note'] = Variable<String, StringType>(d.note.value);
    }
    return map;
  }

  @override
  $MealsTable createAlias(String alias) {
    return $MealsTable(_db, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final int id;
  final String name;
  Tag({@required this.id, @required this.name});
  factory Tag.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Tag(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  factory Tag.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Tag(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  @override
  TagsCompanion createCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  Tag copyWith({int id, String name}) => Tag(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, name.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Tag && other.id == this.id && other.name == this.name);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<int> id;
  final Value<String> name;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  TagsCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
  }) : name = Value(name);
  TagsCompanion copyWith({Value<int> id, Value<String> name}) {
    return TagsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  final GeneratedDatabase _db;
  final String _alias;
  $TagsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 20);
  }

  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  $TagsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tags';
  @override
  final String actualTableName = 'tags';
  @override
  VerificationContext validateIntegrity(TagsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tag map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Tag.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TagsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    return map;
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(_db, alias);
  }
}

class Tagging extends DataClass implements Insertable<Tagging> {
  final int mealId;
  final int tagId;
  Tagging({@required this.mealId, @required this.tagId});
  factory Tagging.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    return Tagging(
      mealId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}meal_id']),
      tagId: intType.mapFromDatabaseResponse(data['${effectivePrefix}tag_id']),
    );
  }
  factory Tagging.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Tagging(
      mealId: serializer.fromJson<int>(json['mealId']),
      tagId: serializer.fromJson<int>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'mealId': serializer.toJson<int>(mealId),
      'tagId': serializer.toJson<int>(tagId),
    };
  }

  @override
  TaggingsCompanion createCompanion(bool nullToAbsent) {
    return TaggingsCompanion(
      mealId:
          mealId == null && nullToAbsent ? const Value.absent() : Value(mealId),
      tagId:
          tagId == null && nullToAbsent ? const Value.absent() : Value(tagId),
    );
  }

  Tagging copyWith({int mealId, int tagId}) => Tagging(
        mealId: mealId ?? this.mealId,
        tagId: tagId ?? this.tagId,
      );
  @override
  String toString() {
    return (StringBuffer('Tagging(')
          ..write('mealId: $mealId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(mealId.hashCode, tagId.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Tagging &&
          other.mealId == this.mealId &&
          other.tagId == this.tagId);
}

class TaggingsCompanion extends UpdateCompanion<Tagging> {
  final Value<int> mealId;
  final Value<int> tagId;
  const TaggingsCompanion({
    this.mealId = const Value.absent(),
    this.tagId = const Value.absent(),
  });
  TaggingsCompanion.insert({
    @required int mealId,
    @required int tagId,
  })  : mealId = Value(mealId),
        tagId = Value(tagId);
  TaggingsCompanion copyWith({Value<int> mealId, Value<int> tagId}) {
    return TaggingsCompanion(
      mealId: mealId ?? this.mealId,
      tagId: tagId ?? this.tagId,
    );
  }
}

class $TaggingsTable extends Taggings with TableInfo<$TaggingsTable, Tagging> {
  final GeneratedDatabase _db;
  final String _alias;
  $TaggingsTable(this._db, [this._alias]);
  final VerificationMeta _mealIdMeta = const VerificationMeta('mealId');
  GeneratedIntColumn _mealId;
  @override
  GeneratedIntColumn get mealId => _mealId ??= _constructMealId();
  GeneratedIntColumn _constructMealId() {
    return GeneratedIntColumn('meal_id', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES meals(id)');
  }

  final VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  GeneratedIntColumn _tagId;
  @override
  GeneratedIntColumn get tagId => _tagId ??= _constructTagId();
  GeneratedIntColumn _constructTagId() {
    return GeneratedIntColumn('tag_id', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES tags(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [mealId, tagId];
  @override
  $TaggingsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'taggings';
  @override
  final String actualTableName = 'taggings';
  @override
  VerificationContext validateIntegrity(TaggingsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.mealId.present) {
      context.handle(
          _mealIdMeta, mealId.isAcceptableValue(d.mealId.value, _mealIdMeta));
    } else if (isInserting) {
      context.missing(_mealIdMeta);
    }
    if (d.tagId.present) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableValue(d.tagId.value, _tagIdMeta));
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {mealId, tagId};
  @override
  Tagging map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Tagging.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TaggingsCompanion d) {
    final map = <String, Variable>{};
    if (d.mealId.present) {
      map['meal_id'] = Variable<int, IntType>(d.mealId.value);
    }
    if (d.tagId.present) {
      map['tag_id'] = Variable<int, IntType>(d.tagId.value);
    }
    return map;
  }

  @override
  $TaggingsTable createAlias(String alias) {
    return $TaggingsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $MealsTable _meals;
  $MealsTable get meals => _meals ??= $MealsTable(this);
  $TagsTable _tags;
  $TagsTable get tags => _tags ??= $TagsTable(this);
  $TaggingsTable _taggings;
  $TaggingsTable get taggings => _taggings ??= $TaggingsTable(this);
  MealDao _mealDao;
  MealDao get mealDao => _mealDao ??= MealDao(this as AppDatabase);
  TagDao _tagDao;
  TagDao get tagDao => _tagDao ??= TagDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [meals, tags, taggings];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$MealDaoMixin on DatabaseAccessor<AppDatabase> {
  $MealsTable get meals => db.meals;
}
mixin _$TagDaoMixin on DatabaseAccessor<AppDatabase> {
  $TagsTable get tags => db.tags;
}
