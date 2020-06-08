import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:wacomi/helpers/alert.dart';
import 'package:wacomi/exceptions/http_exception.dart';
import 'package:wacomi/providers/auth.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  bool _loading = false;

  Future<void> _submit() async {
    if (_fbKey.currentState.saveAndValidate()) {
      print('register');
      print(_fbKey.currentState.value);
      setState(() {
        _loading = true;
      });

      try {
        await Provider.of<Auth>(context, listen: false).signup(
          _fbKey.currentState.value['email'],
          _fbKey.currentState.value['password'],
          _fbKey.currentState.value['password_confirmation'],
          _fbKey.currentState.value['name'],
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
                attribute: "name",
                maxLines: 1,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (v) {
                  _emailFocus.requestFocus();
                },
                key: ValueKey('form_name'),
                decoration: InputDecoration(labelText: "表示名"),
                validators: [
                  FormBuilderValidators.max(20),
                  FormBuilderValidators.required(),
                ],
              ),
              FormBuilderTextField(
                attribute: "email",
                maxLines: 1,
                focusNode: _emailFocus,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (v) {
                  _passwordFocus.requestFocus();
                },
                key: ValueKey('form_email'),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "メールアドレス"),
                validators: [
                  FormBuilderValidators.email(),
                  FormBuilderValidators.required(),
                ],
              ),
              FormBuilderTextField(
                attribute: "password",
                focusNode: _passwordFocus,
                key: ValueKey('form_password'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (v) {
                  _confirmPasswordFocus.requestFocus();
                },
                maxLines: 1,
                decoration: InputDecoration(labelText: "パスワード"),
                obscureText: true,
                validators: [
                  FormBuilderValidators.required(),
                  FormBuilderValidators.max(20),
                ],
              ),
              FormBuilderTextField(
                attribute: "password_confirmation",
                focusNode: _confirmPasswordFocus,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (v) => _submit(),
                key: ValueKey('form_password_confirmation'),
                maxLines: 1,
                obscureText: true,
                decoration: InputDecoration(labelText: "パスワード確認"),
                validators: [
                  (val) {
                    if (_fbKey.currentState.value['password'] != val) {
                      return "パスワードが一致しません";
                    }
                  }
                ],
              ),
              _loading
                  ? Center(child: CircularProgressIndicator())
                  : RaisedButton(
                      child: Text(
                        '新規登録',
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
