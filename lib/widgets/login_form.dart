import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:wacomi/helpers/alert.dart';
import 'package:wacomi/exceptions/http_exception.dart';
import 'package:wacomi/providers/auth.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _loading = false;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final FocusNode _passwordFocus = FocusNode();

  Future<void> _submit() async {
    if (_fbKey.currentState.saveAndValidate()) {
      print('login');
      print(_fbKey.currentState.value);
      setState(() {
        _loading = true;
      });

      try {
        await Provider.of<Auth>(context, listen: false).login(
          _fbKey.currentState.value['email'],
          _fbKey.currentState.value['password'],
        );
        // Navigator.pushReplacementNamed(context, '/');
        Navigator.pop(context);
      } on HttpException catch (error) {
        var errorMessage = 'Authentication failed';
        //TODO: show error from server
        Alert.showError(context, errorMessage);
      } catch (error) {
        print(error);
        const errorMessage =
            'Could not authenticate you. Please try again later.';
        Alert.showError(context, errorMessage);
      }

      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _fbKey,
      // autovalidate: true,
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              FormBuilderTextField(
                attribute: "email",
                textInputAction: TextInputAction.next,
                key: ValueKey('form_email'),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "メールアドレス"),
                validators: [
                  FormBuilderValidators.email(),
                  FormBuilderValidators.required(),
                ],
                onFieldSubmitted: (v) {
                  _passwordFocus.requestFocus();
                },
              ),
              FormBuilderTextField(
                attribute: "password",
                key: ValueKey('form_password'),
                focusNode: _passwordFocus,
                maxLines: 1,
                decoration: InputDecoration(labelText: "パスワード"),
                obscureText: true,
                validators: [
                  FormBuilderValidators.required(),
                  FormBuilderValidators.max(20),
                ],
                onFieldSubmitted: (_) => _submit(),
              ),
              _loading
                  ? Center(child: CircularProgressIndicator())
                  : RaisedButton(
                      child: Text(
                        'ログイン',
                      ),
                      onPressed: _submit,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                      color: Theme.of(context).primaryColor,
                      textColor:
                          Theme.of(context).primaryTextTheme.button.color,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
