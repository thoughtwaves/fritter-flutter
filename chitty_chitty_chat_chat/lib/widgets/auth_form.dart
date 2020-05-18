import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String password, String username,
      bool isLogin, BuildContext ctx) _submit;
  final bool _isLoading;

  AuthForm(this._submit, this._isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formsKey = GlobalKey<FormState>();
  var isLogin = true;
  String _email = '';
  String _username = '';
  String _password = '';

  void _submit() {
    final isvalid = _formsKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isvalid) _formsKey.currentState.save();
    widget._submit(
        _email.trim(), _password.trim(), _username.trim(), isLogin, context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formsKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    key: ValueKey('email'),
                    onSaved: (value) {
                      _email = value;
                    },
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@'))
                        return 'Please enter a valid email.';
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  if (!isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      onSaved: (value) {
                        _username = value;
                      },
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Please enter a valid username.';
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Username'),
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    onSaved: (value) {
                      _password = value;
                    },
                    validator: (value) {
                      if (value.isEmpty || value.length < 6)
                        return 'Please enter a valid password.';
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'password',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (widget._isLoading) CircularProgressIndicator(),
                  if (!widget._isLoading)
                    RaisedButton(
                      child: isLogin ? Text('Login') : Text('Sign up'),
                      onPressed: _submit,
                    ),
                  if (!widget._isLoading)
                    FlatButton(
                        onPressed: () {
                          setState(() {
                            isLogin = !isLogin;
                          });
                        },
                        child: isLogin
                            ? Text('Create Account')
                            : Text('Already have an account?'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
