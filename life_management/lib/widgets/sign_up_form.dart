import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});
  @override
  State<SignUpForm> createState() {
    return _SignUpFormState();
  }
}

class _SignUpFormState extends State<SignUpForm> {
  FocusNode myNameFocusNode = FocusNode();
  FocusNode myEmailFocusNode = FocusNode();
  FocusNode myPasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    myNameFocusNode.addListener(() {
      setState(() {});
    });
    myEmailFocusNode.addListener(() {
      setState(() {});
    });
    myPasswordFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    myNameFocusNode.dispose();
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
              'sign up',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 50,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              focusNode: myNameFocusNode,
              decoration: InputDecoration(
                labelText: 'name:',
                labelStyle: TextStyle(
                  fontSize: 20,
                  color: myNameFocusNode.hasFocus
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onPrimary,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
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
                  onPressed: () {},
                  child: Text(
                    'sign up',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 35,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
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
