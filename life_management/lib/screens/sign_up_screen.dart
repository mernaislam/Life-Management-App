import 'package:flutter/material.dart';
import 'package:life_management/screens/sign_in_screen.dart';
import 'package:life_management/widgets/sign_up_form.dart';
import 'package:life_management/widgets/wave_clipper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: SizedBox(),
        ),
        iconTheme: IconThemeData(
          size: 28,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        scrolledUnderElevation: 0.0,
        toolbarHeight: 70,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        flexibleSpace: ClipPath(
          clipper: WaveClipper(),
          child: Container(
            alignment: Alignment.centerRight,
            color: Theme.of(context).colorScheme.primary,
            height: 150,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const SignInScreen(),
                  ),
                );
              },
              child: Text(
                'Sign in',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 80),
              child: SignUpForm(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          RotatedBox(
            quarterTurns: -2,
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: 150,
                alignment: Alignment.center,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 40),
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.facebook,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 36,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      'Sign up with Facebook',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
