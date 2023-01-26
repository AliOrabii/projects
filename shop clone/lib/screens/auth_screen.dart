import 'package:flutter/material.dart';
import 'package:shop_clone/widgets/forms/login_form.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Color.fromARGB(255, 157, 142, 9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [
                  0.2,
                  0.8,
                ],
              ),
            ),
          ),
          AnimatedOpacity(
            duration: Duration(milliseconds: 600),
            opacity: 0.8,
            child: LoginForm(),
          ),
        ],
      ),
    );
  }
}
