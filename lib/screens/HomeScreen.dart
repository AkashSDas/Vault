import 'package:flutter/material.dart';
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

  ListView getAccountListView() {
    return ListView.builder(
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
                height: 80.0,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: bgSecondary,
                  elevation: 4.0,
                  child: ListTile(
                    title: Text(
                      this.accountList[index].title.toString(),
                      style: h2,
                    ),
                    trailing: GestureDetector(
                      child: Icon(
                        Icons.open_in_new,
                        color: Colors.white,
                      ),
                      onTap: () {
                        navigateToDetailScreen(this.accountList[index]);
                      },
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

  @override
  Widget build(BuildContext context) {
    if (accountList == null) {
      accountList = List<Account>();
      this.updateListView();
    }

    return Container(
      color: Colors.yellow,
      child: Scaffold(
        body: Container(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                // *** Navbar ***
                SizedBox(
                  height: MediaQuery.of(context).size.height - 700,
                  child: Container(
                    color: bgPrimary,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Container(
                            child: Text(
                              'Vault',
                              style: navBarTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                // *** Number of accounts info ***
                Container(
                  height: 32,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        color: purple,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '$count.toString() Accounts',
                        style: h2,
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 10.0,
                ),

                // *** Acount List ***
                Container(
                  child: this.getAccountListView(),
                )
              ],
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
          ),
          backgroundColor: purple,
        ),
      ),
    );
  }
}
