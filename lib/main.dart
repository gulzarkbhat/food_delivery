import 'package:flutter/material.dart';
import 'package:flutter_app/screens/food_list.dart';
import 'package:flutter_app/screens/food_detail.dart';

void main() {
	runApp(MyApp());
}

class MyApp extends StatelessWidget {

	@override
  Widget build(BuildContext context) {

    return MaterialApp(
	    title: 'FoodDonate',
	    debugShowCheckedModeBanner: false,
	    theme: ThemeData(
		    primarySwatch: Colors.deepPurple
	    ),
	    home: NoteList(),
    );
  }
}