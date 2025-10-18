import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:lavender/features/favorites/presenation/screens/favorite_screen.dart';
import 'package:lavender/features/home/presenation/screens/main_view.dart';

class MenuCubit extends Cubit<int> {
  MenuCubit() : super(0);
  final ZoomDrawerController zoomDrawerController = ZoomDrawerController();

  final List<Widget> menuScreens = [
    const MainView(),
    Container(child: Text("Test")),
    FavoritesScreen(),
    Container(child: Text("Test")),
    Container(child: Text("Test")),
  ];

  void selectTile(int newIndex) {
    emit(newIndex);
  }
  void toggleDrawer() {
    zoomDrawerController.toggle?.call();
  }

}
