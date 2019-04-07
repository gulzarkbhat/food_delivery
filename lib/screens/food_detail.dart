import 'package:flutter/material.dart';
import 'package:flutter_app/models/foodsource.dart';
import 'package:flutter_app/screens/Constants.dart';
import 'package:flutter_app/utils/database_helper.dart';
import 'package:intl/intl.dart';

class FoodDetail extends StatefulWidget {
  final String appBarTitle;
  final Food food;

  FoodDetail(this.food, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return FoodDetailState(this.food, this.appBarTitle);
  }
}

class FoodDetailState extends State<FoodDetail> {
  static var _foodavailibility = ['Yes', 'No'];

  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Food food;

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  FoodDetailState(this.food, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    nameController.text = food.name;
    addressController.text = food.address;
    phoneController.text = food.phone;
    emailController.text = food.email;

    return WillPopScope(
        onWillPop: () {
          // Write some code to control things, when user press Back navigation button in device navigationBar
          moveToLastScreen();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(appBarTitle),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  // Write some code to control things, when user press back button in AppBar
                  moveToLastScreen();
                }),
//            actions: <Widget>[
//              PopupMenuButton<String>(
//                onSelected: choiceSelection,
//                itemBuilder: (BuildContext context) {
//                  return Constants.choices.map((String choice) {
//                    return PopupMenuItem<String>(
//                      value: choice,
//                      child: Text(choice),
//                    );
//                  }).toList();
//
//                },
//              ),
//            ],
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                // First element

//                Padding(
//                  padding: const EdgeInsets.only(left: 100.0),
//                  child: CheckboxListTile(
//                    title: const Text(
//                      'Food Available',
//
//                      style: TextStyle(fontSize: 18.0, color: Colors.blue),
//                    ),
//                    value: true,
//                    onChanged: (bool value) {
//                      setState(() {
//                        if()
//                        updatePriorityAsInt(value);
//
//                      });
//                    },
//                    secondary: const Icon(Icons.restaurant,color: Colors.deepOrange,),
//                  ),
//                ),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.end,
//                  children: <Widget>[
//                    Text(
//                      'Food Available',
//                      style: textStyle,
//                    ),
//                    Checkbox(
//                        value: true,
//                        onChanged: (bool value) {
//                          setState(() {});
//                        }),

//                    CheckboxListTile(
//                      title: const Text('Animate Slowly'),
//                      value: true,
//                      onChanged: (bool value) {
//                        setState(() { !value; });
//                      },
//                      secondary: const Icon(Icons.hourglass_empty),
//                    )
//                  ],
//                ),

                Padding(
                  padding: const EdgeInsets.only(left:92.0),
                  child: ListTile(
                    leading: Text("Food Available",style: textStyle,),
                    title: DropdownButton(
                        items: _foodavailibility.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        style: textStyle,
                        value: getPriorityAsString(food.foodstate),
                        onChanged: (valueSelectedByUser) {
                          setState(() {
                            debugPrint('User selected $valueSelectedByUser');
                            updatePriorityAsInt(valueSelectedByUser);
                          });
                        }),
                    trailing: const Icon(Icons.restaurant,color: Colors.deepOrange,),
                  ),

                ),

                // Second Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: nameController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Title Text Field');
                      updateTitle();
                    },
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.contacts,
                          color: Colors.green,
                        ),
                        labelText: 'Name',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),

                // Third Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: addressController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Description Text Field');
                      updateDescription();
                    },
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.my_location,
                          color: Colors.green,
                        ),
                        labelText: 'Address',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: phoneController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in phone Text field');
                      updateContact();
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.phone,
                          color: Colors.green,
                        ),
                        labelText: 'Phone',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: emailController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in email Text field');
                      updateEmail();
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: Colors.blue,
                        ),
                        labelText: 'E-Mail',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                // Fourth Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Save',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Save button clicked");
                              _save();
                            });
                          },
                        ),
                      ),
                      Container(
                        width: 5.0,
                      ),
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Delete',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Delete button clicked");
                              _delete();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  // Convert the String priority in the form of integer before saving it to Database
  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'Yes':
        food.foodstate = 1;
        break;
      case 'No':
        food.foodstate = 2;
        break;
    }
  }

  // Convert int priority to String priority and display it to user in DropDown
  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _foodavailibility[0]; // 'High'
        break;
      case 2:
        priority = _foodavailibility[1]; // 'Low'
        break;
    }
    return priority;
  }

  // Update the title of Food object
  void updateTitle() {
    food.name = nameController.text;
  }

  // Update the description of Food object
  void updateDescription() {
    food.address = addressController.text;
  }

  void updateContact() {
    food.phone = phoneController.text;
  }

  void updateEmail() {
    food.email = emailController.text;
  }

  // Save data to database
  void _save() async {
    moveToLastScreen();

    food.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (food.id != null) {
      // Case 1: Update operation
      result = await helper.updateFood(food);
    } else {
      // Case 2: Insert Operation
      result = await helper.insertFood(food);
    }

    if (result != 0) {
      // Success
      _showAlertDialog('Status', 'Food Saved Successfully');
    } else {
      // Failure
      _showAlertDialog('Status', 'Problem Saving Food');
    }
  }

  void _delete() async {
    moveToLastScreen();

    // Case 1: If user is trying to delete the NEW Food i.e. he has come to
    // the detail page by pressing the FAB of FoodList page.
    if (food.id == null) {
      _showAlertDialog('Status', 'No Food was deleted');
      return;
    }

    // Case 2: User is trying to delete the old food that already has a valid ID.
    int result = await helper.deleteFood(food.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Food Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Food');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void choiceSelection(String choice) {
    if (choice == Constants.Settings)
      print("Settings");
    else if (choice == Constants.SignOut)
      print("Sign Out");
    else if (choice == Constants.Subsribe) print("Subsribe");
  }
}
