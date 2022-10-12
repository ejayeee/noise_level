import 'package:flutter/material.dart';
import 'package:noise_level/bottom_bar/bottom_bar.dart';
import 'package:noise_level/services/inform_to_screens.dart';

class Saves extends StatelessWidget {
  final InformToScreens informToScreens;
  const Saves(this.informToScreens, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Text('Сохраненные'),
      ),
      bottomNavigationBar: BottomBar(informToScreens),
    );
  }
}
