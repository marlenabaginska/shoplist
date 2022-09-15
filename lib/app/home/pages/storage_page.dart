import 'package:flutter/material.dart';

class StoragePage extends StatelessWidget {
  const StoragePage({
    super.key,
    required this.storageName,
  });
  final String storageName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(storageName),
        ),
      ),
    );
  }
}
