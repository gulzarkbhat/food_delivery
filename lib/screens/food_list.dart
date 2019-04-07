import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/foodsource.dart';
import 'package:flutter_app/utils/database_helper.dart';
import 'package:flutter_app/screens/food_detail.dart';
import 'package:sqflite/sqflite.dart';


class FoodStatusList extends StatefulWidget {

	@override
  State<StatefulWidget> createState() {

    return FoodStatusListState();
  }
}

class FoodStatusListState extends State<FoodStatusList> {

	DatabaseHelper databaseHelper = DatabaseHelper();
	List<Food> foodStatusList;
	int count = 0;

	@override
  Widget build(BuildContext context) {

		if (foodStatusList == null) {
			foodStatusList = List<Food>();
			updateListView();
		}

    return Scaffold(

	    appBar: AppBar(
		    title: Text('Food'),
	    ),

	    body: getFoodListView(),

	    floatingActionButton: FloatingActionButton(
		    onPressed: () {
		      debugPrint('FAB clicked');
		      navigateToDetail(Food('', '', 2,'',''), 'Add Food');
		    },

		    tooltip: 'Add Food',

		    child: Icon(Icons.add),

	    ),
    );
  }

  ListView getFoodListView() {

		TextStyle titleStyle = Theme.of(context).textTheme.subhead;

		return ListView.builder(
			itemCount: count,
			itemBuilder: (BuildContext context, int position) {
				return Card(
					color: Colors.white,
					elevation: 2.0,
					child: ListTile(

						leading: CircleAvatar(
							backgroundColor: getFoodAvailibilityColor(this.foodStatusList[position].foodstate),
							child: getPriorityIcon(this.foodStatusList[position].foodstate),
						),

						title: Text(this.foodStatusList[position].name, style: titleStyle,),

						subtitle: Text(this.foodStatusList[position].date),

						trailing: GestureDetector(
							child: Icon(Icons.delete, color: Colors.red,),
							onTap: () {
								_delete(context, foodStatusList[position]);
							},
						),


						onTap: () {
							debugPrint("ListTile Tapped");
							navigateToDetail(this.foodStatusList[position],'Edit Food');
						},

					),
				);
			},
		);
  }

  // Returns the priority color
	Color getFoodAvailibilityColor(int priority) {
		switch (priority) {
			case 1:
				return Colors.green;
				break;
			case 2:
				return Colors.yellow;
				break;

			default:
				return Colors.yellow;
		}
	}

	// Returns the priority icon
	Icon getPriorityIcon(int priority) {
		switch (priority) {
			case 1:
				return Icon(Icons.restaurant);
				break;
			case 2:
				return Icon(Icons.keyboard_arrow_right);
				break;

			default:
				return Icon(Icons.keyboard_arrow_right);
		}
	}

	void _delete(BuildContext context, Food note) async {

		int result = await databaseHelper.deleteNote(note.id);
		if (result != 0) {
			_showSnackBar(context, 'Food Deleted Successfully');
			updateListView();
		}
	}

	void _showSnackBar(BuildContext context, String message) {

		final snackBar = SnackBar(content: Text(message));
		Scaffold.of(context).showSnackBar(snackBar);
	}

  void navigateToDetail(Food food, String title) async {
	  bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
		  return NoteDetail(food, title);
	  }));

	  if (result == true) {
	  	updateListView();
	  }
  }

  void updateListView() {

		final Future<Database> dbFuture = databaseHelper.initializeDatabase();
		dbFuture.then((database) {

			Future<List<Food>> noteListFuture = databaseHelper.getNoteList();
			noteListFuture.then((noteList) {
				setState(() {
				  this.foodStatusList = noteList;
				  this.count = noteList.length;
				});
			});
		});
  }
}







