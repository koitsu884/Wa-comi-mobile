import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wacomi/providers/auth.dart';
import 'package:wacomi/screens/auth_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => Column(
          children: <Widget>[
            AppBar(
              title: Text('メニュー'),
              automaticallyImplyLeading: false,
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('アカウント設定'),
            ),
            Divider(),
            !auth.isAuth
                ? ListTile(
                    leading: Icon(Icons.perm_identity),
                    title: Text('ログイン'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (ctx) => AuthScreen(),
                      ));
                    },
                  )
                : ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('ログアウト'),
                    onTap: () {
                      auth.logout();
                      Navigator.of(context).pushNamed('/');
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
