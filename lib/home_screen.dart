import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _onPressed,
            icon: const Icon(Icons.login),
          )
        ],
      ),
      body: const SafeArea(
        child: Column(
          children: [],
        ),
      ),
    );
  }

  void _onPressed() {}
}
