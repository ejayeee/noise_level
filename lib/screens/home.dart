import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:noise_level/bottom_bar/bottom_bar.dart';
import 'package:noise_level/services/all_routes.dart';
import 'package:noise_level/services/inform_to_screens.dart';
import 'package:noise_meter/noise_meter.dart';

class Home extends StatefulWidget {
  final InformToScreens informToScreens;
  const Home(this.informToScreens, {Key? key}) : super(key: key);

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  bool isRecording = false;
  StreamSubscription<NoiseReading>? noiseSubscription;
  late NoiseMeter noiseMeter;
  double thisActualNoise = 0.0;
  List<double> listActualNoise = [0];

  @override
  void initState() {
    super.initState();
    noiseMeter = NoiseMeter(onError);
  }

  @override
  void dispose() {
    noiseSubscription?.cancel();
    super.dispose();
  }

  void onData(NoiseReading noiseReading) {
    setState(() {
      if (!isRecording) {
        isRecording = true;
      }
    });
    print(noiseReading.toString());
    thisActualNoise = noiseReading.maxDecibel;

    listActualNoise.add(thisActualNoise);
    if (listActualNoise.contains(0)) {
      listActualNoise.removeAt(0);
    }
  }

  void onError(Object error) {
    print(error.toString());
    isRecording = false;
  }

// Start/Stop

  void start() async {
    try {
      noiseSubscription = noiseMeter.noiseStream.listen(onData);
      setState(() {
        isRecording = true;
      });
      listActualNoise.removeAt(0);
    } catch (err) {
      print(err);
    }
  }

  void stop() async {
    try {
      if (noiseSubscription != null) {
        noiseSubscription!.cancel();
        noiseSubscription = null;
      }
      setState(() {
        isRecording = false;
      });
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      widget.informToScreens.goToRoute(AllRoutes.info);
                      Navigator.of(context).pushNamed('/info');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset('assets/images/info.png'),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      widget.informToScreens.goToRoute(AllRoutes.settings);
                      Navigator.of(context).pushNamed('/settings');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset('assets/images/setting.png'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Column(
                children: [
                  Container(
                    width: 400,
                    height: 150,
                    color: Colors.blue,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        thisActualNoise.toStringAsFixed(1),
                        style: const TextStyle(
                          fontFamily: 'Ggnuolane',
                          fontWeight: FontWeight.bold,
                          fontSize: 80,
                          //color: Color.fromARGB(1, 167, 44, 44)
                        ),
                      ),
                      Container(width: 1, height: 50, color: Colors.grey),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'min ${listActualNoise.reduce(min).toStringAsFixed(1)}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'max ${listActualNoise.reduce(max).toStringAsFixed(1)}',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(widget.informToScreens),
    );
  }
}
