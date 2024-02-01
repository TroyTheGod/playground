import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:playground/overlay/custom_popup_overlay.dart';
import 'package:playground/red_packet_rain/red_packet_rain_view.dart';
import 'package:playground/router/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: () => CustomPopUpOverlay().showToast(
                context,
                child: const SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(),
                ),
              ),
              child: const Text('custom widget'),
            ),
            ElevatedButton(
              onPressed: () => CustomPopUpOverlay().showToast(
                context,
                message: 'Message',
              ),
              child: const Text('String'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/scrollView'),
              child: const Text(
                'scroll view',
              ),
            ),
            ElevatedButton(
              onPressed: () => exit(0),
              child: const Text(
                '898',
              ),
            ),
            ElevatedButton(
              onPressed: () => context.go('/eatWhatHo'),
              onLongPress: () => context.go('/eatWhatHo?spinnerType=1'),
              child: const Text(
                'EatWhatHo',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/datePicker');
              },
              child: const Text('Date range picker'),
            ),
            ElevatedButton(
              onPressed: () {
                showGeneralDialog(
                  context: context,
                  transitionDuration: const Duration(milliseconds: 150),
                  barrierDismissible: true,
                  barrierLabel: '',
                  transitionBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return const RedPacketRain(
                      durationTime: 10,
                    );
                  },
                  pageBuilder: (
                    BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                  ) {
                    return const SizedBox();
                  },
                );
              },
              child: const Text('red packet rain'),
            ),
          ],
        ),
      ),
    );
  }
}
