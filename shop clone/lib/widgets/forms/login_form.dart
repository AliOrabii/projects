import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_clone/providers/auth.dart';

enum AuthMode { Signup, Login }

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  AuthMode authMode = AuthMode.Login;
  bool _showpass = true;

  final _form = GlobalKey<FormState>();
  final _UserNamenode = FocusNode();
  final _Passwordnode = FocusNode();
  final _ConfirmPasswordnode = FocusNode();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _ConfirmpassController = TextEditingController();
  String? _UserName;
  String? _Password;
  String? _ConfirmPassword;

  Widget logo() {
    return FadeInImage(
      height: 50,
      fit: BoxFit.fitHeight,
      placeholder: AssetImage('assets/images/logo3.png'),
      image: AssetImage('assets/images/logo3.png'),
    );
  }

  void clear() {
    _usernameController.clear();
    _ConfirmpassController.clear();
    _passwordController.clear();
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) {
      return;
    }
    _form.currentState!.save();
    try {
      if (authMode == AuthMode.Signup) {
        await Provider.of<Auth>(context, listen: false)
            .SignUp(_UserName, _Password);
      } else if (authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false)
            .Login(_UserName, _Password);
      }
    } on Exception catch (error) {
      var message = error.toString();
      if (error.toString().contains('EMAIL_EXISTS')) {
        message = 'This email is already in use';
      }
      if (error.toString().contains('EMAIL_NOT_FOUND')) {
        message = 'This is not a valid email';
      }
      if (error.toString().contains('INVALID_PASSWORD')) {
        message = 'Invalid password';
      }
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).viewInsets.bottom;
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          _UserNamenode.unfocus();
          _Passwordnode.unfocus();
          _ConfirmPasswordnode.unfocus();
        },
        child: AnimatedContainer(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12)),
          duration: Duration(milliseconds: 400),
          curve: Curves.easeIn,
          height: authMode == AuthMode.Login ? 320 : 410,
          width: MediaQuery.of(context).size.width * 0.75,
          child: Align(
            alignment: Alignment.center,
            child: Form(
              key: _form,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 2, left: 10, right: 10, bottom: 2),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      logo(),
                      TextFormField(
                        focusNode: _UserNamenode,
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Invalid email!';
                          }
                          return null;
                        },
                        cursorColor: Colors.black,
                        controller: _usernameController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          _UserName = value;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_Passwordnode);
                        },
                        decoration: const InputDecoration(
                          label: Text(
                            'E-Mail',
                            style: TextStyle(
                                color: Color.fromARGB(255, 81, 45, 168),
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                      ),
                      TextFormField(
                        focusNode: _Passwordnode,
                        cursorColor: Colors.black,
                        controller: _passwordController,
                        obscureText: _showpass,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 5) {
                            return 'Password is too short!';
                          }
                        },
                        onChanged: (value) {
                          _Password = value;
                        },
                        onFieldSubmitted: (_) {
                          if (authMode == AuthMode.Login) {
                            FocusScope.of(context).dispose();
                          }
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            alignment: Alignment.bottomCenter,
                            iconSize: 26,
                            icon: Icon(
                              _showpass
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _showpass = !_showpass;
                              });
                            },
                          ),
                          label: const Text(
                            'Password',
                            style: TextStyle(
                                color: Color.fromARGB(255, 81, 45, 168),
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        height: authMode == AuthMode.Login ? 0 : 75,
                        curve: Curves.easeIn,
                        child: TextFormField(
                          obscureText: _showpass,
                          validator: authMode == AuthMode.Signup
                              ? (value) {
                                  if (value != _passwordController.text) {
                                    return 'Password do not match';
                                  }
                                }
                              : null,
                          controller: _ConfirmpassController,
                          focusNode: _ConfirmPasswordnode,
                          textInputAction: TextInputAction.next,
                          cursorColor: Colors.black,
                          onChanged: (value) {
                            _Password = value;
                          },
                          decoration: const InputDecoration(
                            label: Text(
                              'Confirm Password',
                              style: TextStyle(
                                color: Color.fromARGB(255, 81, 45, 168),
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepPurple.shade700),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        onPressed: _submit,
                        child: Text(
                          authMode == AuthMode.Login ? 'LogIn' : 'SignUp',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            if (authMode == AuthMode.Login) {
                              authMode = AuthMode.Signup;
                            } else {
                              authMode = AuthMode.Login;
                              clear();
                            }
                          });
                        },
                        child: Text(
                          authMode == AuthMode.Login ? 'SignUp' : 'LogIn',
                          style: TextStyle(
                              color: Colors.deepPurple.shade700,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
