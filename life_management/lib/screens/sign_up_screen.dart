import 'package:flutter/material.dart';
import 'package:life_management/screens/sign_in_screen.dart';
import 'package:life_management/widgets/bottom_wave_clipper.dart';
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                alignment: Alignment.centerRight,
                color: Theme.of(context).colorScheme.primary,
                height: 150,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const SignInScreen()));
                  },
                  child: Text(
                    'sign in',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 70),
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
                    clipper: BottomWaveClipper(),
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
                            'sign up with facebook',
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
