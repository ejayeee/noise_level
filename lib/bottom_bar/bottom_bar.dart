import 'package:flutter/material.dart';
import 'package:noise_level/screens/home.dart';
import 'package:noise_level/services/all_routes.dart';
import 'package:noise_level/services/inform_to_screens.dart';
import 'package:permission_handler/permission_handler.dart';

class BottomBar extends StatefulWidget {
  final InformToScreens informToScreens;
  const BottomBar(this.informToScreens, {Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  activeButtonColor(String route) {
    if (route == widget.informToScreens.thisRoute) {
      return const Color.fromARGB(255, 207, 210, 228);
    } else {
      return Colors.transparent;
    }
  }

  getIsRecording() {
    setState(() {});
    return context.findAncestorStateOfType<HomeState>()?.isRecording ?? false;
  }

  void getOnStart() => context.findAncestorStateOfType<HomeState>()?.start();

  void getOnStop() => context.findAncestorStateOfType<HomeState>()?.stop();

  @override
  Widget build(BuildContext context) {
    // var itRoute = ModalRoute.of(context)?.settings.name;
    // ifActiveSavesButton() {
    //   if (itRoute == '/saves') {
    //     return const Color.fromARGB(255, 207, 210, 228);
    //   } else {
    //     return Colors.transparent;
    //   }
    // }

    // ifActiveMicButton() {
    //   if (itRoute == '/') {
    //     return const Color.fromARGB(255, 207, 210, 228);
    //   } else {
    //     return Colors.transparent;
    //   }
    // }

    return Row(
      children: [
        // кнопка 'СОХРАНИТЬ'
        Material(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: InkWell(
            onTap: () {},
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              height: 85,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Image.asset('assets/images/save.png'),
              ),
            ),
          ),
        ),

        // кнопка 'МИКРОФОН'
        Material(
          color: activeButtonColor(AllRoutes.home),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: InkWell(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            onTap: () async {
              widget.informToScreens.goToRoute(AllRoutes.home);

              if (widget.informToScreens.thisRoute == AllRoutes.home &&
                  await Permission.microphone.status.isDenied) {
                await Permission.microphone.request();
              } else {
                // print(await Permission.microphone.status);
              }

              // print(getIsRecording);

              if (getIsRecording == false) {
                getOnStart();
              } else if (getIsRecording == true) {
                getOnStop();
              }
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              height: 85,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: getIsRecording()
                    ? const Icon(Icons.pages_rounded)
                    : Image.asset('assets/images/mic_red.png'),
              ),
            ),
          ),
        ),

        // кнопка 'СОХРАНЁННЫЕ (SAVES)'
        Material(
          color: activeButtonColor(AllRoutes.saves),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: InkWell(
            onTap: () {
              widget.informToScreens.goToRoute(AllRoutes.saves);
            },
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              height: 85,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Image.asset('assets/images/list.png'),
              ),
            ),
          ),
        ),

        // кнопка 'ТАЙМЕР'
        Material(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: InkWell(
            onTap: () {},
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              height: 85,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Image.asset('assets/images/timer.png'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
