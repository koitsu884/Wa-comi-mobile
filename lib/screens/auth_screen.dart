import 'package:flutter/material.dart';
import 'package:wacomi/widgets/login_form.dart';
import 'package:wacomi/widgets/register_form.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 9.4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).primaryColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    color: Colors.black26,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Text(
                'Wa-コミ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'MPLUSRounded1c',
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Expanded(
              child: Container(
                // height: deviceSize.height,
                width: deviceSize.width,
                child: Center(
                  child: AuthCard(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  AuthMode _authMode = AuthMode.Login;

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5.0,
      child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
          width: deviceSize.width * 0.80,
          height: _authMode == AuthMode.Signup ? 380 : 260,
          constraints: BoxConstraints(
              minHeight: _authMode == AuthMode.Signup ? 380 : 260),
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _authMode == AuthMode.Signup ? RegisterForm() : LoginForm(),
                Divider(),
                FlatButton(
                  child: Text(
                    _authMode == AuthMode.Login ? '新規登録' : 'ログイン',
                  ),
                  onPressed: _switchAuthMode,
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          )),
    );
  }
}
