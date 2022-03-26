import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:towers_desktop/screens/game/cubit.dart';
import 'package:towers_desktop/screens/game/game_page.dart';

void main() {
  final cubit = GameCubit();
  runApp(MaterialApp(
    home: MultiBlocProvider(
      providers: cubit.providers,
      child: const GamePage(),
    ),
  ));
}