import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wacomi/providers/auth.dart';
import 'package:wacomi/providers/post_list.dart';
import 'package:wacomi/screens/app.dart';
import 'package:wacomi/screens/auth_screen.dart';

void main() => runApp(WacomiApp());

class WacomiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, PostList>(
          update: (ctx, auth, _) => PostList(auth.token,
              auth.currentUser != null ? auth.currentUser.id : null),
        ),
      ],
      child: MaterialApp(
        title: 'Wa-コミ',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          primaryColor: Colors.teal[300],
          accentColor: Colors.amber,
          fontFamily: 'MPLUSRounded1c',
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'MPLUSRounded1c',
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                button: TextStyle(
                  color: Colors.white,
                ),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: 'MPLUSRounded1c',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          ),
        ),
        initialRoute: '/',
        routes: {
          AuthScreen.routeName: (context) => AuthScreen(),
          '/': (context) => App(),
        },
      ),
    );
  }
}
