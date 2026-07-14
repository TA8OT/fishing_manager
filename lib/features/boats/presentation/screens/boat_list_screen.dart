import 'package:fishing_app/features/boats/presentation/providers/boat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoatListScreen extends ConsumerWidget {
  const BoatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(boatProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Boats')),
      body: state.isLoading
          ? Center(child: CircularProgressIndicator())
          : state.errorMessage != null
          ? Center(child: Text(state.errorMessage.toString()))
          : state.boats.isEmpty
          ? Center(child: Text('no boats data is found'))
          : ListView.builder(
              itemCount: state.boats.length,
              itemBuilder: (context, index) {
                return Text(state.boats[index].name);
              },
            ),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }
}
