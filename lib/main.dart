import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fishing_app/app/app.dart';

void main() {
  runApp(ProviderScope(child: const FishingManagerApp()));
}
