import 'package:flutter/material.dart';

import './routes.dart';
import './screens/screens.dart';
import './services/db/Account.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vault',
      debugShowCheckedModeBanner: false,
      home: LoadingScreen(),
      routes: <String, WidgetBuilder>{
        home: (BuildContext context) => HomeScreen(),
        accountDetails: (BuildContext context) =>
            AccountDetailsScreen(Account('', '', '')),
      },
    );
  }
}
