import 'package:flutter/material.dart';
import 'package:vault/services/db/db.dart';

import '../services/db/Account.dart';
import '../shared/AlertDialog.dart';
import '../styles/theme.dart';

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
        backgroundColor: bgPrimary,
        body: SingleChildScrollView(
          child: Container(
            color: bgPrimary,
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  // *** NavBar ***
                  SizedBox(
                    height: 92,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(left: 32.0)),
                          GestureDetector(
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: white,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          Padding(padding: EdgeInsets.only(left: 32.0)),
                          Center(
                            child: Container(
                              child: Text(
                                this.navbarTitle(),
                                style: navBarTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Card(
                        elevation: 10.0,
                        color: bgPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: <Widget>[
                            // * Title *
                            Container(
                              decoration: BoxDecoration(
                                color: bgSecondary,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: TextField(
                                  controller: titleController,
                                  style: h4,
                                  onChanged: (value) => this.updateTitle(),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Title',
                                    hintStyle: h4,
                                    icon: Icon(
                                      Icons.star,
                                      color: yellow,
                                      size: 32,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // * Description *
                            Container(
                              margin: EdgeInsets.only(top: 18.0),
                              decoration: BoxDecoration(
                                color: bgSecondary,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: TextField(
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  controller: descriptionController,
                                  style: h4,
                                  onChanged: (value) =>
                                      this.updateDescription(),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Description',
                                    hintStyle: h4,
                                    icon: Icon(
                                      Icons.description,
                                      color: green,
                                      size: 32,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // * Password *
                            Container(
                              margin: EdgeInsets.only(top: 18.0),
                              decoration: BoxDecoration(
                                color: bgSecondary,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: TextField(
                                  controller: passwordController,
                                  style: h4,
                                  onChanged: (value) => this.updatePassword(),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Password',
                                    hintStyle: h4,
                                    icon: Icon(
                                      Icons.lock,
                                      color: orange,
                                      size: 32,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // * Save & Delete Buttons *
                            Container(
                              height: 64.0,
                              margin: EdgeInsets.only(top: 32.0),
                              child: MaterialButton(
                                height: 28.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: green,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.save, color: white, size: 32),
                                      SizedBox(width: 12.0),
                                      Text('Save', style: h2),
                                    ],
                                  ),
                                ),
                                elevation: 5.0,
                                onPressed: () {
                                  setState(() {
                                    debugPrint('Save buttom clicked');
                                    this._save();
                                  });
                                },
                              ),
                            ),

                            Container(
                              height: 64.0,
                              margin: EdgeInsets.only(top: 32.0),
                              child: MaterialButton(
                                height: 28.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: red,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.delete_outline,
                                          color: white, size: 32),
                                      SizedBox(width: 12.0),
                                      Text('Delete', style: h2),
                                    ],
                                  ),
                                ),
                                elevation: 5.0,
                                onPressed: () {
                                  setState(() {
                                    debugPrint('Delete buttom clicked');
                                    this._delete();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
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
