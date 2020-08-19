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

  void _updateTitle() {
    account.title = titleController.text;
  }

  void _updateDescription() {
    account.description = descriptionController.text;
  }

  void _updatePassword() {
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

  String _getnavbarTitle() {
    return this.account.title == '' ? 'Add Account' : 'Edit Account';
  }

  Widget _buildNavBar(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 25.0),
          color: white,
        ),
        Text(title, style: h2),
      ],
    );
  }

  Widget _buildTitleTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Title', style: labelStyle),
        SizedBox(height: 10.0),
        Container(
          decoration: boxDecorationStyle,
          child: TextField(
            keyboardType: TextInputType.text,
            controller: titleController,
            onChanged: (value) => this._updateTitle(),
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.title,
                color: Colors.white,
              ),
              hintText: 'Enter account name',
              hintStyle: hintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Description', style: labelStyle),
        SizedBox(height: 10.0),
        Container(
          decoration: boxDecorationStyle,
          child: TextField(
            maxLines: null,
            keyboardType: TextInputType.multiline,
            controller: descriptionController,
            onChanged: (value) => this._updateDescription(),
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 14.0),
              prefixIcon: Icon(
                Icons.description,
                color: Colors.white,
              ),
              hintText: 'Enter account description',
              hintStyle: hintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Password', style: labelStyle),
        SizedBox(height: 10.0),
        Container(
          decoration: boxDecorationStyle,
          child: TextField(
            keyboardType: TextInputType.text,
            controller: passwordController,
            onChanged: (value) => this._updatePassword(),
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter account password',
              hintStyle: hintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          print('Save Button Clicked');
          this._save();
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Save',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: OutlineButton(
        onPressed: () {
          print('Delete Button Clicked');
          this._delete();
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        borderSide: BorderSide(width: 3.0),
        child: Text(
          'Delete',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    titleController.text = account.title;
    descriptionController.text = account.description;
    passwordController.text = account.password;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: gradPrimary),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
          children: <Widget>[
            this._buildNavBar(this._getnavbarTitle()),
            Divider(height: 40.0, color: white),
            this._buildTitleTF(),
            SizedBox(height: 30.0),
            this._buildDescriptionTF(),
            SizedBox(height: 30.0),
            this._buildPasswordTF(),
            SizedBox(height: 30.0),
            this._buildSaveBtn(),
            this._buildDeleteBtn(),
          ],
        ),
      ),
    );
  }
}
