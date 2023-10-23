import 'package:flutter/material.dart';
import 'package:life_management/screens/home_screen.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});
  @override
  State<SignInForm> createState() {
    return _SignInFormState();
  }
}

class _SignInFormState extends State<SignInForm> {
  FocusNode myEmailFocusNode = FocusNode();
  FocusNode myPasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    myEmailFocusNode.addListener(() {
      setState(() {});
    });
    myPasswordFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    myEmailFocusNode.dispose();
    myPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 40,
              ),
            ),
            Text(
              ' we\'re glad you\'re here',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 23,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary, fontSize: 20),
              focusNode: myEmailFocusNode,
              decoration: InputDecoration(
                labelText: 'email:',
                labelStyle: TextStyle(
                  fontSize: 20,
                  color: myEmailFocusNode.hasFocus
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onPrimary,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ),
            TextFormField(
              obscureText: true,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary, fontSize: 20),
              focusNode: myPasswordFocusNode,
              decoration: InputDecoration(
                labelText: 'password:',
                labelStyle: TextStyle(
                  fontSize: 20,
                  color: myPasswordFocusNode.hasFocus
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onPrimary,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const HomeScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 35,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const HomeScreen(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.arrow_circle_right_outlined,
                    size: 50,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
