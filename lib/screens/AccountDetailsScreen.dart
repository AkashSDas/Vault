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

  Widget _buildTitleTF(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Title', style: labelStyle),
        SizedBox(height: 10.0),
        Container(
          decoration: boxDecorationStyle,
          child: TextField(
            keyboardType: TextInputType.text,
            controller: controller,
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

  Widget _buildDescriptionTF(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Description', style: labelStyle),
        SizedBox(height: 10.0),
        Container(
          decoration: boxDecorationStyle,
          child: TextField(
            keyboardType: TextInputType.multiline,
            controller: controller,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
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

  Widget _buildPasswordTF(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Password', style: labelStyle),
        SizedBox(height: 10.0),
        Container(
          decoration: boxDecorationStyle,
          child: TextField(
            keyboardType: TextInputType.text,
            controller: controller,
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
            this._buildTitleTF(titleController),
            SizedBox(height: 30.0),
            this._buildDescriptionTF(descriptionController),
            SizedBox(height: 30.0),
            this._buildPasswordTF(passwordController),
            SizedBox(height: 30.0),
            this._buildSaveBtn(),
            this._buildDeleteBtn(),
          ],
        ),
      ),
    );

    // return WillPopScope(
    //   onWillPop: () => this.navigateToLastScreen(),
    //   child: Scaffold(
    //     backgroundColor: bgPrimary,
    //     body: SingleChildScrollView(
    //       child: Container(
    //         color: bgPrimary,
    //         child: SafeArea(
    //           child: Column(
    //             children: <Widget>[
    //               // *** NavBar ***
    //               SizedBox(
    //                 height: 92,
    //                 child: Container(
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.start,
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: <Widget>[
    //                       Padding(padding: EdgeInsets.only(left: 32.0)),
    //                       GestureDetector(
    //                         child: Icon(
    //                           Icons.arrow_back_ios,
    //                           color: white,
    //                         ),
    //                         onTap: () {
    //                           Navigator.pop(context);
    //                         },
    //                       ),
    //                       Padding(padding: EdgeInsets.only(left: 32.0)),
    //                       Center(
    //                         child: Container(
    //                           child: Text(
    //                             this.navbarTitle(),
    //                             style: navBarTextStyle,
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),

    //               SizedBox(height: 10),

    //               Container(
    //                 child: Padding(
    //                   padding: EdgeInsets.all(10.0),
    //                   child: Card(
    //                     elevation: 10.0,
    //                     color: bgPrimary,
    //                     shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(10.0),
    //                     ),
    //                     child: ListView(
    //                       scrollDirection: Axis.vertical,
    //                       shrinkWrap: true,
    //                       children: <Widget>[
    //                         // * Title *
    //                         Container(
    //                           decoration: BoxDecoration(
    //                             color: bgSecondary,
    //                             borderRadius: BorderRadius.circular(10.0),
    //                           ),
    //                           child: Padding(
    //                             padding: EdgeInsets.all(10.0),
    //                             child: TextField(
    //                               controller: titleController,
    //                               style: h4,
    //                               onChanged: (value) => this.updateTitle(),
    //                               decoration: InputDecoration(
    //                                 border: InputBorder.none,
    //                                 hintText: 'Title',
    //                                 hintStyle: h4,
    //                                 icon: Icon(
    //                                   Icons.star,
    //                                   color: yellow,
    //                                   size: 32,
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                         ),

    //                         // * Description *
    //                         Container(
    //                           margin: EdgeInsets.only(top: 18.0),
    //                           decoration: BoxDecoration(
    //                             color: bgSecondary,
    //                             borderRadius: BorderRadius.circular(10.0),
    //                           ),
    //                           child: Padding(
    //                             padding: EdgeInsets.all(10.0),
    //                             child: TextField(
    //                               maxLines: null,
    //                               keyboardType: TextInputType.multiline,
    //                               controller: descriptionController,
    //                               style: h4,
    //                               onChanged: (value) =>
    //                                   this.updateDescription(),
    //                               decoration: InputDecoration(
    //                                 border: InputBorder.none,
    //                                 hintText: 'Description',
    //                                 hintStyle: h4,
    //                                 icon: Icon(
    //                                   Icons.description,
    //                                   color: green,
    //                                   size: 32,
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                         ),

    //                         // * Password *
    //                         Container(
    //                           margin: EdgeInsets.only(top: 18.0),
    //                           decoration: BoxDecoration(
    //                             color: bgSecondary,
    //                             borderRadius: BorderRadius.circular(10.0),
    //                           ),
    //                           child: Padding(
    //                             padding: EdgeInsets.all(10.0),
    //                             child: TextField(
    //                               controller: passwordController,
    //                               style: h4,
    //                               onChanged: (value) => this.updatePassword(),
    //                               decoration: InputDecoration(
    //                                 border: InputBorder.none,
    //                                 hintText: 'Password',
    //                                 hintStyle: h4,
    //                                 icon: Icon(
    //                                   Icons.lock,
    //                                   color: orange,
    //                                   size: 32,
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                         ),

    //                         // * Save & Delete Buttons *
    //                         Container(
    //                           height: 64.0,
    //                           margin: EdgeInsets.only(top: 32.0),
    //                           child: MaterialButton(
    //                             height: 28.0,
    //                             shape: RoundedRectangleBorder(
    //                               borderRadius: BorderRadius.circular(10.0),
    //                             ),
    //                             color: green,
    //                             child: Center(
    //                               child: Row(
    //                                 mainAxisAlignment: MainAxisAlignment.center,
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.center,
    //                                 children: <Widget>[
    //                                   Icon(Icons.save, color: white, size: 32),
    //                                   SizedBox(width: 12.0),
    //                                   Text('Save', style: h2),
    //                                 ],
    //                               ),
    //                             ),
    //                             elevation: 5.0,
    //                             onPressed: () {
    //                               setState(() {
    //                                 debugPrint('Save buttom clicked');
    //                                 this._save();
    //                               });
    //                             },
    //                           ),
    //                         ),

    //                         Container(
    //                           height: 64.0,
    //                           margin: EdgeInsets.only(top: 32.0),
    //                           child: MaterialButton(
    //                             height: 28.0,
    //                             shape: RoundedRectangleBorder(
    //                               borderRadius: BorderRadius.circular(10.0),
    //                             ),
    //                             color: red,
    //                             child: Center(
    //                               child: Row(
    //                                 mainAxisAlignment: MainAxisAlignment.center,
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.center,
    //                                 children: <Widget>[
    //                                   Icon(Icons.delete_outline,
    //                                       color: white, size: 32),
    //                                   SizedBox(width: 12.0),
    //                                   Text('Delete', style: h2),
    //                                 ],
    //                               ),
    //                             ),
    //                             elevation: 5.0,
    //                             onPressed: () {
    //                               setState(() {
    //                                 debugPrint('Delete buttom clicked');
    //                                 this._delete();
    //                               });
    //                             },
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
