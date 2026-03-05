import 'dart:io';
import 'package:rive/rive.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final data = await rootBundle.load('assets/animated_login_character.riv');
  final file = RiveFile.import(data);
  final artboard = file.mainArtboard;
  print('Artboard: ${artboard.name}');
  for (var sm in artboard.stateMachines) {
    print('State Machine: ${sm.name}');
    for (var input in sm.inputs) {
      print(' - Input: ${input.name} (${input.runtimeType})');
    }
  }
}
