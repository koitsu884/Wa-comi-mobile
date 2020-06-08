import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wacomi/providers/auth.dart';
import 'package:wacomi/screens/auth_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        Consumer<Auth>(
            builder: (ctx, auth, _) => SliverAppBar(
                expandedHeight: 30.0,
                // pinned: true,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'Wa-コミ',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                actions: auth.isAuth
                    ? <Widget>[
                        FlatButton(
                          child: Text(
                            'Log out',
                          ),
                          onPressed: () {},
                        )
                      ]
                    : <Widget>[
                        FlatButton(
                          child: Text('ログイン'),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (ctx) => AuthScreen(),
                            ));
                          },
                        ),
                      ])),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Text(
                'ホーム！！',
                style: Theme.of(context).textTheme.headline1,
              ),
              Container(
                height: 300,
                child: Text('Hoge'),
              ),
              SizedBox(
                height: 10,
              ),
              Text('投稿のあれこれ'),
              Container(
                height: 300,
                child: Text('Hoge'),
              ),
              SizedBox(
                height: 10,
              ),
              Text('イベントのあれこれ'),
              Container(
                height: 300,
                child: Text('Hoge'),
              ),
            ],
          ),
        ),
      ],
    );

    // return Container(
    //     padding: EdgeInsets.all(10),
    //     child: ListView(
    //       children: <Widget>[
    //         Container(
    //           child: Column(
    //             children: <Widget>[
    //               Text('グループのあれこれ'),
    //               Card(
    //                 child: Text('Hoge'),
    //               ),
    //               SizedBox(
    //                 height: 10,
    //               ),
    //               Text('投稿のあれこれ'),
    //               Card(
    //                 child: Text('Hoge'),
    //               ),
    //               SizedBox(
    //                 height: 10,
    //               ),
    //               Text('イベントのあれこれ'),
    //               Card(
    //                 child: Text('Hoge'),
    //               ),
    //             ],
    //           ),
    //         )
    //       ],
    //     ));
  }
}
