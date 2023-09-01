import 'package:flutter/material.dart';
import 'package:life_management/widgets/sign_in_form.dart';
import 'package:life_management/widgets/wave_clipper.dart';
import 'package:life_management/widgets/wave_clipper_second.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: WaveClipperSecond(),
              child: Container(
                alignment: Alignment.centerLeft,
                color: Theme.of(context).colorScheme.primary,
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.undo_sharp,
                      size: 32,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 70),
              child: SignInForm(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: RotatedBox(
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
    );
  }
}
