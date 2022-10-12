import 'package:flutter/material.dart';
import 'package:noise_level/screens/home.dart';
import 'package:noise_level/screens/info.dart';
import 'package:noise_level/screens/saves.dart';
import 'package:noise_level/screens/settings.dart';
import 'package:noise_level/services/all_routes.dart';
import 'package:noise_level/services/inform_to_screens.dart';

void main() {
  runApp(
    const NoiseLevel(),
  );
}

class NoiseLevel extends StatefulWidget {
  const NoiseLevel({
    Key? key,
  }) : super(key: key);

  @override
  State<NoiseLevel> createState() => _NoiseLevelState();
}

class _NoiseLevelState extends State<NoiseLevel> {
  String thisRoute = AllRoutes.home;
  bool is404 = false;

  void goToRoute(String route) {
    setState(() {
      thisRoute = route;
    });
  }

  @override
  Widget build(BuildContext context) {
    InformToScreens informToScreens = InformToScreens(thisRoute, goToRoute);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Navigator(
        pages: [
          MaterialPage(
            child: Home(informToScreens),
          ),
          if (thisRoute == AllRoutes.saves)
            MaterialPage(
              child: Saves(informToScreens),
            ),
          if (thisRoute == AllRoutes.info)
            MaterialPage(
              child: Info(informToScreens),
            ),
          if (thisRoute == AllRoutes.settings)
            MaterialPage(
              child: Settings(informToScreens),
            ),
          if (is404 == true)
            if (thisRoute == AllRoutes.saves)
              const MaterialPage(
                child: Scaffold(
                  body: Center(child: Text('Ошибка! Перезагрузите приложение')),
                ),
              ),
        ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            return false;
          }

          return true;
        },
      ),
    );
  }
}
