import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  StopWatchTimer _stopWatchTimer = StopWatchTimer();
  StopWatchRecord record=StopWatchRecord();
  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose(); // Need to call dispose function.
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
          backgroundColor: Colors.orange[50],
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Flutter StopWatch Timer Demo"),
          ),
          body: Column(
            children: [
              StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: 0,
                builder: (context, snap) {
                  final value = snap.data;
                  final displayTime = StopWatchTimer.getDisplayTime(value!);
                  return Expanded(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            displayTime,
                            style: TextStyle(
                                fontSize: 40,
                                fontFamily: 'Helvetica',
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            value.toString(),
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Helvetica',
                                fontWeight: FontWeight.w400
                            ),
                          ),
                        ),
                        ElevatedButton(onPressed: () {
                          _stopWatchTimer.onStartTimer();
                        }, child: Text("Start")),
                        ElevatedButton(onPressed: () {
                          _stopWatchTimer.onAddLap();
                          // _stopWatchTimer.onStopTimer();
                        }, child: Text("Stop"))
                      ],
                    ),
                  );
                },
              ),
              StreamBuilder<List<StopWatchRecord>>(
                stream: _stopWatchTimer.records,
                initialData: const [],
                builder: (context, snap) {
                  final value = snap.data;
                  return Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        final data = value[index];
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                '${index + 1} ${data.rawValue}',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            const Divider(height: 1,)
                          ],
                        );
                      },
                      itemCount: value!.length,
                    ),
                  );
                },
              ),
            ],
          ),

      );

}

/*
StreamBuilder<int>(
            stream: _stopWatchTimer.rawTime,
            initialData: 0,
            builder: (context, snap) {
              final value = snap.data;
              final displayTime = StopWatchTimer.getDisplayTime(value!);
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      displayTime,
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      value.toString(),
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                  ElevatedButton(onPressed: () {
                    _stopWatchTimer.onStartTimer();
                  }, child: Text("Start")),
                  ElevatedButton(onPressed: () {
                    _stopWatchTimer.onStopTimer();
                  }, child: Text("Stop"))
                ],
              );
            },
          )
 */