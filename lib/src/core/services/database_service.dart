import 'dart:io';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
// import 'package:moor_flutter/moor_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:rxdart/rxdart.dart';

part 'database_service.g.dart';

class Meals extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get note => text().nullable()();
}

class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 20)();
}

class Taggings extends Table {
  IntColumn get mealId =>
      integer().customConstraint('NOT NULL REFERENCES meals(id)')();
  IntColumn get tagId =>
      integer().customConstraint('NOT NULL REFERENCES tags(id)')();
  @override
  Set<Column> get primaryKey => {mealId, tagId};
}

class MealWithTags {
  final Meal meal;
  final List<Tag> tags;

  MealWithTags(this.meal, this.tags);
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final Directory dbFolder = await getApplicationDocumentsDirectory();
    final File file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Meals, Tags, Taggings], daos: [MealDao, TagDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  // AppDatabase()
  //     : super((FlutterQueryExecutor.inDatabaseFolder(
  //         path: 'db.sqlite',
  //         logStatements: true,
  //       )));

  @override
  int get schemaVersion => 1;

  Stream<List<MealWithTags>> streamAllMealWithTags() {
    final Stream<List<Meal>> mealStream = select(meals).watch();
    return mealStream.switchMap(
      (meals) {
        final Map<int, Meal> idToMeal = {for (var meal in meals) meal.id: meal};
        final Iterable<int> ids = idToMeal.keys;

        final entryQuery = select(taggings).join(
          [
            innerJoin(
              tags,
              tags.id.equalsExp(taggings.tagId),
            )
          ],
        )..where(taggings.mealId.isIn(ids));

        return entryQuery.watch().map(
          (rows) {
            final idToTags = <int, List<Tag>>{};

            for (var row in rows) {
              final Tag tag = row.readTable(tags);
              final int id = row.readTable(taggings).mealId;

              idToTags.putIfAbsent(id, () => []).add(tag);
            }

            return [
              for (var id in ids)
                MealWithTags(idToMeal[id], idToTags[id] ?? []),
            ];
          },
        );
      },
    );
  }

  void insertMealWithTags(MealWithTags mealWithTags) {
    transaction(
      () async {
        final Insertable<Meal> meal = mealWithTags.meal;
        final int mealId = await into(meals).insert(meal, orReplace: true);

        // deltet all previous taggings
        await (delete(taggings)
              ..where((tagging) => tagging.mealId.equals(mealId)))
            .go();
        //add all new taggings
        await batch(
          (batch) {
            batch.insertAll(
              taggings,
              [
                for (var tag in mealWithTags.tags)
                  Tagging(mealId: mealId, tagId: tag.id)
              ],
            );
          },
        );
      },
    );
  }

  void deleteMealWithTags(MealWithTags mealWithTags) {
    transaction(
      () async {
        final Meal meal = mealWithTags.meal;
        await delete(meals).delete(meal);
        // deltet all taggings
        await (delete(taggings)
              ..where((tagging) => tagging.mealId.equals(meal.id)))
            .go();
      },
    );
  }

  void deleteTag(Tag tag) {
    transaction(
      () async {
        await delete(tags).delete(tag);
        // deltet all taggings
        await (delete(taggings)
              ..where((tagging) => tagging.tagId.equals(tag.id)))
            .go();
      },
    );
  }
}

@UseDao(tables: [Meals])
class MealDao extends DatabaseAccessor<AppDatabase> with _$MealDaoMixin {
  final AppDatabase db;
  MealDao(this.db) : super(db);
}

@UseDao(tables: [Tags])
class TagDao extends DatabaseAccessor<AppDatabase> with _$TagDaoMixin {
  final AppDatabase db;
  TagDao(this.db) : super(db);

  Stream<List<Tag>> streamAllTags() => select(tags).watch();
  void insertTag(Insertable<Tag> tag) => into(tags).insert(tag);
}
