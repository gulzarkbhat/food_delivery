import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_app/models/foodsource.dart';

class DatabaseHelper {

	static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
	static Database _database;                // Singleton Database

	String foodTable = 'food_table';
	String colId = 'id';
	String colName = 'name';
	String colAddress = 'address';
	String colPriority = 'priority';
	String colDate = 'date';
	String colContact = 'contact';
	String colEmail = 'email';

	DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

	factory DatabaseHelper() {

		if (_databaseHelper == null) {
			_databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
		}
		return _databaseHelper;
	}

	Future<Database> get database async {

		if (_database == null) {
			_database = await initializeDatabase();
		}
		return _database;
	}

	Future<Database> initializeDatabase() async {
		// Get the directory path for both Android and iOS to store database.
		Directory directory = await getApplicationDocumentsDirectory();
		String path = directory.path + 'foods.db';

		// Open/create the database at a given path
		var foodsDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
		return foodsDatabase;
	}

	void _createDb(Database db, int newVersion) async {

		await db.execute('CREATE TABLE $foodTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, '
				'$colAddress TEXT, $colPriority INTEGER, $colDate TEXT, $colContact TEXT, $colEmail TEXT)');
	}

	// Fetch Operation: Get all food objects from database
	Future<List<Map<String, dynamic>>> getFoodMapList() async {
		Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $foodTable order by $colPriority ASC');
		var result = await db.query(foodTable, orderBy: '$colPriority ASC');
		return result;
	}

	// Insert Operation: Insert a Food object to database
	Future<int> insertFood(Food food) async {
		Database db = await this.database;
		var result = await db.insert(foodTable, food.toMap());
		return result;
	}

	// Update Operation: Update a Food object and save it to database
	Future<int> updateFood(Food food) async {
		var db = await this.database;
		var result = await db.update(foodTable, food.toMap(), where: '$colId = ?', whereArgs: [food.id]);
		return result;
	}

	// Delete Operation: Delete a Food object from database
	Future<int> deleteFood(int id) async {
		var db = await this.database;
		int result = await db.rawDelete('DELETE FROM $foodTable WHERE $colId = $id');
		return result;
	}

	// Get number of Food objects in database
	Future<int> getCount() async {
		Database db = await this.database;
		List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $foodTable');
		int result = Sqflite.firstIntValue(x);
		return result;
	}

	// Get the 'Map List' [ List<Map> ] and convert it to 'Food List' [ List<Food> ]
	Future<List<Food>> getFoodList() async {

		var foodMapList = await getFoodMapList(); // Get 'Map List' from database
		int count = foodMapList.length;         // Count the number of map entries in db table

		List<Food> foodList = List<Food>();
		// For loop to create a 'Food List' from a 'Map List'
		for (int i = 0; i < count; i++) {
			foodList.add(Food.fromMapObject(foodMapList[i]));
		}

		return foodList;
	}

}







