class Food {
  int _id;
  String _name;
  String _address;
  String _phone;
  String _email;
  String _date;
  int _priority;

  Food(this._name, this._date, this._priority, this._phone, this._email,
      [this._address]);

  Food.withId(this._id, this._name, this._date, this._priority, this._phone,
      this._email,
      [this._address]);

  int get id => _id;

  String get name => _name;

  String get address => _address;

  int get priority => _priority;

  String get date => _date;

  String get phone => _phone;

  String get email => _email;

  set name(String newTitle) {
    if (newTitle.length <= 255) {
      this._name = newTitle;
    }
  }

  set address(String newDescription) {
    if (newDescription.length <= 255) {
      this._address = newDescription;
    }
  }

  set priority(int newPriority) {
    if (newPriority >= 1 && newPriority <= 2) {
      this._priority = newPriority;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  set phone(String contact) {
    if (contact.length <= 287) this._phone = contact;
  }

  set email(String email) {
    if (validateEmail(email)) this._email = email;
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['address'] = _address;
    map['priority'] = _priority;
    map['date'] = _date;
    map['contact'] = _phone;
    map['email'] = _email;

    return map;
  }

  // Extract a Note object from a Map object
  Food.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._address = map['address'];
    this._priority = map['priority'];
    this._date = map['date'];
    this._phone = map['contact'];
    this._email = map['email'];
  }
}
