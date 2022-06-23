import 'package:flutter/material.dart';
import 'package:gesture_recognition_v2/gesture_view.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SettingState();
  }
}

class _SettingState extends State<SettingPage> {
  List<int> result = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop()),
        title: const Text("Setting Gesture"),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 120,
            child: Center(
              child: Text(
                "result: ${result.toString()}",
                style: const TextStyle(
                    fontSize: 24,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Center(
            child: GestureView(
              immediatelyClear: true,
              size: 300,
              ringRadius: 20,
              ringWidth: 1,
              circleRadius: 10,
              onPanUp: (List<int> items) {
                setState(() {
                  result = items;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
