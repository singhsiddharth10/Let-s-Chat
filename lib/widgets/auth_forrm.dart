import 'dart:io';

import 'package:flutter/material.dart';
import 'package:letschat/widgets/picker/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);
  final bool isLoading;
  final void Function(String email, String password, String userName,
      File image, bool isLogin, BuildContext ctx) submitFn;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  File _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick an image'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    if (isValid) {
      _formKey.currentState.save();
    }
    widget.submitFn(_userEmail.trim(), _userPassword.trim(), _userName.trim(),
        _userImageFile, _isLogin, context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!_isLogin) UserImagePicker(_pickedImage),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Please enter valid email address';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide: BorderSide(color: Colors.green)),
                      ),
                      onSaved: (value) {
                        _userEmail = value;
                      },
                    ),
                  ),
                  if (!_isLogin)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        key: ValueKey('userName'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please entera valid username';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                              borderSide: BorderSide(color: Colors.green)),
                        ),
                        onSaved: (value) {
                          _userName = value;
                        },
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      key: ValueKey('password'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 7) {
                          return 'Password must be atleast 7 characters long';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide: BorderSide(color: Colors.green)),
                      ),
                      obscureText: true,
                      onSaved: (value) {
                        _userPassword = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                        child: Text(_isLogin ? 'Login' : 'Sign up'),
                        onPressed: _trySubmit),
                  if (!widget.isLoading)
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? 'Create new Account'
                          : 'I already have an account'),
                      textColor: Theme.of(context).primaryColor,
                    )
                ],
              )),
        )),
      ),
    );
  }
}
