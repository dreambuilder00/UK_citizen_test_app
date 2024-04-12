import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
// import 'package:red_squirrel/utils/constants/classes.dart';

class QuizDao {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'red_squirrel.db');

    // Pass the existing database instance if it is already open
    final database = await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE IF NOT EXISTS results (id INTEGER PRIMARY KEY AUTOINCREMENT, chapter INTEGER, correct INTEGER, total INTEGER)',
        );
      },
      version: 1,
    );

    return database;
  }

  // // A method that inserts quiz into the database
  // static Future<void> insert(Quiz quiz) async {
  //   final db = await database();

  //   await db.insert(
  //     'quizzes',
  //     quiz.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }

  // // A method that retrieves quiz list from the quizzes table.
  // static Future<List<Quiz>> getQuiz(List<int> chapter, int count) async {
  //   // Get a reference to the database.
  //   final db = await database();
  //   final List<Map<String, dynamic>> maps;
  //   if (chapter[0] == 1) {
  //     maps = await db.query(
  //       'quizzes',
  //       orderBy: 'RANDOM()',
  //       limit: count,
  //     );
  //   } else {
  //     // Query the table for all The Quizzes.
  //     maps = await db.query(
  //       'quizzes',
  //       where: 'chapter = ? OR chapter = ?',
  //       whereArgs: chapter,
  //       orderBy: 'RANDOM()',
  //       limit: count,
  //     );
  //   }

  //   // Convert the List<Map<String, dynamic> into a List<Quiz>.
  //   return List.generate(maps.length, (i) {
  //     return Quiz(
  //       id: maps[i]['id'],
  //       question: maps[i]['question'],
  //       optionA: maps[i]['option_a'],
  //       optionB: maps[i]['option_b'],
  //       optionC: maps[i]['option_c'],
  //       optionD: maps[i]['option_d'],
  //       answerA: maps[i]['answer_a'],
  //       answerB: maps[i]['answer_b'],
  //       chapter: maps[i]['chapter'],
  //       type: maps[i]['type'],
  //     );
  //   });
  // }

  // // A method that update specfic quiz
  // static Future<void> updateQuiz(Quiz quiz) async {
  //   // Get a reference to the database.
  //   final db = await database();

  //   // Update the given quiz.
  //   await db.update(
  //     'quizzes',
  //     quiz.toMap(),
  //     // Ensure that the quiz has a matching id.
  //     where: 'id = ?',
  //     // Pass the quiz's id as a whereArg to prevent SQL injection.
  //     whereArgs: [quiz.id],
  //   );
  // }

  // // A method that remove specific quiz
  // static Future<void> deleteQuiz(int id) async {
  //   // Get a reference to the database.
  //   final db = await database();

  //   // Remove the quiz from the database.
  //   await db.delete(
  //     'quizzes',
  //     // Use a `where` clause to delete a specific quiz.
  //     where: 'id = ?',
  //     // Pass the quiz's id as a whereArg to prevent SQL injection.
  //     whereArgs: [id],
  //   );
  // }
}
