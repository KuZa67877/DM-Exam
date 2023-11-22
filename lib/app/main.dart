import 'package:flutter/material.dart';

import 'bottom_navigation_bar_widget.dart';

void main() {
  runApp(const MainWidget());
}

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {//TODO бекграунд калор на белый обратно поставить
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigationBarWidget(),
    );
  }
}
