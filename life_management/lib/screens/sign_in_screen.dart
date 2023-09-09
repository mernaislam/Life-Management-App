import 'package:flutter/material.dart';
import 'package:life_management/widgets/sign_in_form.dart';
import 'package:life_management/widgets/wave_clipper.dart';
import 'package:life_management/widgets/wave_clipper_second.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: SizedBox(),
        ),
        scrolledUnderElevation: 0.0,
        toolbarHeight: 80,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        iconTheme: IconThemeData(
          size: 28,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        backgroundColor: Colors.transparent,
        flexibleSpace: ClipPath(
          clipper: WaveClipperSecond(),
          child: Container(
            color: Theme.of(context).colorScheme.primary,
            height: 200,
          ),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Padding(
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
