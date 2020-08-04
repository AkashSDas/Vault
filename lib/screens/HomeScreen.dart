import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:vault/screens/AccountDetailsScreen.dart';
import 'package:vault/services/db/db.dart';
import 'package:vault/shared/AppBar.dart';

import '../services/db/Account.dart';
import '../services/db/db.dart';
import '../styles/global.dart';

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
                    borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                  ),
                  color: getRandomColor(),
                  elevation: 4.0,
                  child: ListTile(
                    title: Text(
                      this.accountList[index].title.toString(),
                      style: CardText,
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
        appBar: getAppBar('Vault', true),
        body: Container(
          color: homeScrenBg,
          child: Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: this.getAccountListView(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            this.navigateToDetailScreen(Account('', '', ''));
          },
          child: Icon(Icons.add),
          backgroundColor: navBar,
        ),
      ),
    );
  }
}
