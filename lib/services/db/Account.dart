class Account {
  int _id;
  String _title;
  String _description;
  String _password;

  // Constructors
  Account(this._title, this._description, this._password);
  Account.withId(this._id, this._title, this._description, this._password);

  // Getters
  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get password => _password;

  // Setters
  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }

  set password(String newPassword) {
    if (newPassword.length <= 255) {
      this._password = newPassword;
    }
  }

  /// Used to save and retrive from database
  /// *** Convert Account object to Map object ***
  /// This method is used when we directly create an object and
  /// the other time is when we are editing that
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      /// To check if id is not null i.e. the object is already present
      /// in the database i.e. the object was already created  in the database
      /// in that case set the id field to that value otherwise we will manually
      /// setting all of them.
      map['id'] = _id;
    }

    map['title'] = _title;
    map['description'] = _description;
    map['password'] = _password;

    return map;
  }

  /// Convert Map object to Account object
  Account.fromMapToObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._password = map['password'];
  }
}
