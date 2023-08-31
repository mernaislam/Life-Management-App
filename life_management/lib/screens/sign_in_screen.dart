import 'package:flutter/material.dart';
import 'package:life_management/widgets/bottom_wave_clipper.dart';
import 'package:life_management/widgets/wave_clipper.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ClipPath(
          clipper: WaveClipper(),
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
      ),
      bottomNavigationBar: RotatedBox(
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
    );
  }
}
