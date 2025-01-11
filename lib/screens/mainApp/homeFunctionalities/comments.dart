import 'package:flutter/material.dart';
import 'package:rate_it/styles/style.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppTheme.gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Comments'),
          backgroundColor: Colors.transparent,
        ),
        body: const Center(
          child: Text('Comments Screen'),
        ),
      ),
    );
  }
}
