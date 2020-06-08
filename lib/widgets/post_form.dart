import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class PostForm extends StatefulWidget {
  final bool editMode;
  final Function handleSubmit;

  PostForm({this.handleSubmit, this.editMode = false});

  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final FocusNode _contentFocus = FocusNode();

  Future<void> _submit() async {
    if (_fbKey.currentState.saveAndValidate()) {
      widget.handleSubmit(_fbKey.currentState.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _fbKey,
      // autovalidate: true,
      child: Container(
        child: Column(
          children: <Widget>[
            FormBuilderTextField(
              attribute: "title",
              maxLines: 1,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (v) {
                _contentFocus.requestFocus();
              },
              decoration: InputDecoration(labelText: "タイトル"),
              validators: [
                FormBuilderValidators.max(100),
                FormBuilderValidators.required(),
              ],
            ),
            FormBuilderTextField(
              attribute: "content",
              focusNode: _contentFocus,
              // textInputAction: TextInputAction.next,
              // onFieldSubmitted: (v) {
              //   _passwordFocus.requestFocus();
              // },
              maxLines: 10,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(labelText: "投稿内容"),
              validators: [
                FormBuilderValidators.max(5000),
                FormBuilderValidators.required(),
              ],
            ),
            RaisedButton(
              child: Text(
                widget.editMode ? '編集する' : '投稿する',
              ),
              onPressed: _submit,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).primaryTextTheme.button.color,
            ),
          ],
        ),
      ),
    );
  }
}
