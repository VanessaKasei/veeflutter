import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DonatePage extends StatelessWidget {
  final home;

  const DonatePage({super.key, required this.home});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donate to ${home['name']}'),
      ),
    );
  }
}
