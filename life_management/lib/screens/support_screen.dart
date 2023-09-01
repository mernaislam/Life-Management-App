import 'package:flutter/material.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() {
    return _CommunityScreenState();
  }
}

class _CommunityScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Support'),
      ),
    );
  }
}
