import 'package:flutter/material.dart';
import 'package:vault/services/db/db.dart';
import 'package:vault/shared/AppBar.dart';

import '../services/db/Account.dart';
import '../shared/AlertDialog.dart';
import '../styles/global.dart';

class AccountDetailsScreen extends StatefulWidget {
  final Account account;

  AccountDetailsScreen(this.account);

  @override
  _AccountDetailsScreenState createState() =>
      _AccountDetailsScreenState(this.account);
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  Account account;
  DatabaseHelper db = DatabaseHelper();

  _AccountDetailsScreenState(this.account);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  navigateToLastScreen() {
    Navigator.pop(context, true);
  }

  void updateTitle() {
    account.title = titleController.text;
  }

  void updateDescription() {
    account.description = descriptionController.text;
  }

  void updatePassword() {
    account.password = passwordController.text;
  }

  void _save() async {
    this.navigateToLastScreen();

    int result;
    if (account.id != null) {
      result = await db.updateAccount(account);
    } else {
      result = await db.insertAccount(account);
    }

    if (result != 0) {
      showAlertDialog(context, 'Status', 'Account Saved Successfully');
    } else {
      showAlertDialog(context, 'Status', 'Problem Saving Account, Try Again');
    }
  }

  void _delete() async {
    this.navigateToLastScreen();
    if (account.id == null) {
      showAlertDialog(context, 'Status', 'First add new account');
      return;
    }
    int result = await db.deleteAccount(account.id);
    if (result != 0) {
      showAlertDialog(context, 'Status', 'Account deleted successfully');
    } else {
      showAlertDialog(context, 'Status', 'Problem Deleting Account, Try Again');
    }
  }

  String navbarTitle() {
    if (this.account.title == '') {
      return 'Add Account';
    } else {
      return 'Edit Account';
    }
  }

  @override
  Widget build(BuildContext context) {
    titleController.text = account.title;
    descriptionController.text = account.description;
    passwordController.text = account.password;

    return WillPopScope(
      onWillPop: () => this.navigateToLastScreen(),
      child: Scaffold(
        appBar: getAppBar(this.navbarTitle(), false),
        body: Container(
          color: detailScreenBg,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Card(
              elevation: 5.0,
              color: detailCardBg,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(30, 40))),
              child: ListView(
                children: <Widget>[
                  // Title
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: TextField(
                      controller: titleController,
                      style: FormText,
                      onChanged: (value) => this.updateTitle(),
                      decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: Label,
                        icon: Icon(Icons.title),
                      ),
                    ),
                  ),

                  // Description
                  Padding(
                    // padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    padding: EdgeInsets.all(15.0),
                    child: TextField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      controller: descriptionController,
                      style: FormText,
                      onChanged: (value) => this.updateDescription(),
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: Label,
                        icon: Icon(Icons.description),
                        // contentPadding: EdgeInsets.only(bottom: 80.0),
                      ),
                    ),
                  ),

                  // Password
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: TextField(
                      controller: passwordController,
                      style: FormText,
                      onChanged: (value) => this.updatePassword(),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: Label,
                        icon: Icon(Icons.lock),
                      ),
                    ),
                  ),

                  // Save & Delete Buttons
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: MaterialButton(
                            height: 15.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            onPressed: () {
                              setState(() {
                                debugPrint('Save buttom clicked');
                                this._save();
                              });
                            },
                            color: lightGreen,
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.save, color: formBtnIconColor),
                                Text(
                                  'Save',
                                  textScaleFactor: 1.8,
                                  style: FormBtn,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 5.0,
                        ),
                        Expanded(
                          child: MaterialButton(
                            height: 15.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            onPressed: () {
                              setState(() {
                                debugPrint('Delete buttom clicked');
                                this._delete();
                              });
                            },
                            color: lightRed,
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.delete, color: formBtnIconColor),
                                Text(
                                  'Delete',
                                  textScaleFactor: 1.8,
                                  style: FormBtn,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
