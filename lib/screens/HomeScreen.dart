import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:vault/screens/AccountDetailsScreen.dart';
import 'package:vault/services/db/db.dart';

import '../services/db/Account.dart';
import '../services/db/db.dart';
import '../styles/theme.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseHelper db = DatabaseHelper();
  List<Account> accountList;
  int count = 0;

  void updateListView() {
    final Future<Database> dbFuture = db.initalizeDatabase();
    dbFuture.then((database) {
      Future<List<Account>> accountListFuture = db.getAccountList();
      accountListFuture.then((accountList) {
        setState(() {
          this.accountList = accountList;
          this.count = accountList.length;
        });
      });
    });
  }

  void navigateToDetailScreen(Account account) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AccountDetailsScreen(account);
        },
      ),
    );

    if (result == true) {
      this.updateListView();
    }
  }

  Widget _buildNavBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Vault', style: h2),
        IconButton(
          onPressed: () => print('Menu Button Pressed'),
          icon: Icon(Icons.menu, size: 25.0),
          color: white,
        ),
      ],
    );
  }

  Widget _buildAccountStatus() {
    String text;
    if (this.count == 0) {
      text = 'No accounts stored in your Vault';
    } else if (this.count == 1) {
      text = '$count account stored in your Vault';
    } else {
      text = '$count accounts stored in your Vault';
    }

    return Container(
      child: Text(text, style: h1),
    );
  }

  Widget _buildAccountList() {
    return ListView.builder(
      primary: false,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: count,
      itemBuilder: (context, index) {
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: Duration(milliseconds: 369),
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: Container(
                height: 92.0,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                padding: EdgeInsets.symmetric(vertical: 6.0),
                decoration: boxDecorationStyle,
                child: Center(
                  child: ListTile(
                    title: Hero(
                      tag: this.accountList[index].title,
                      child: SizedBox(
                        height: 40.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                this.accountList[index].title.toString(),
                                style: h3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 5.0),
                        Flexible(
                          child: Text(
                            this.accountList[index].description.toString(),
                            style: h4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    trailing: InkResponse(
                      onTap: () {
                        navigateToDetailScreen(this.accountList[index]);
                      },
                      child: Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: text1,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          size: 25.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (accountList == null) {
      accountList = List<Account>();
      this.updateListView();
    }

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(gradient: gradPrimary),
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
              children: <Widget>[
                this._buildNavBar(),
                Divider(height: 40, color: white),
                this._buildAccountStatus(),
                Divider(height: 40, color: white),
                this._buildAccountList(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          this.navigateToDetailScreen(Account('', '', ''));
        },
        child: Icon(
          Icons.add,
          color: white,
          size: 25.0,
        ),
        backgroundColor: darkBlue,
      ),
    );
  }
}
