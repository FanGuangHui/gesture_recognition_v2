import 'package:flutter/material.dart';
import 'package:gesture_recognition_v2/gesture_view.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VerifyState();
  }
}

class _VerifyState extends State<VerifyPage> {
  List<int> curResult = [];
  List<int> correctResult = [0, 1, 2, 5, 8, 7, 6];
  int status = 0; // 0: NONE,1: SUCCESS,2: ERROR
  late List<int> onlyShowItems;
  GlobalKey<GestureState> gestureStateKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop()),
        title: const Text("Practical"),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 60,
            child: Center(
              child: Text(
                "Current: ${correctResult.toString()}",
                style: const TextStyle(fontSize: 24, color: Colors.blue),
              ),
            ),
          ),
          SizedBox(
            height: 60,
            child: Center(
              child: Text(
                "Current: ${curResult.toString()}",
                style: const TextStyle(fontSize: 24, color: Colors.blue),
              ),
            ),
          ),
          SizedBox(
            height: 60,
            child: Center(
              child: Text(
                status == 0 ? "" : (status == 1 ? "Success" : "Error"),
                style: TextStyle(
                    fontSize: 24,
                    color: status == 1 ? Colors.blue : Colors.red),
              ),
            ),
          ),
          Center(
            child: GestureView(
              key: gestureStateKey,
              size: 300,
              selectColor: Colors.blue,
              onPanUp: (List<int> items) {
                analysisGesture(items);
              },
              onPanDown: () {
                setState(() {
                  status = 0;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  analysisGesture(List<int> items) {
    bool isCorrect = true;
    if (items.length == correctResult.length) {
      for (int i = 0; i < items.length; i++) {
        if (items[i] != correctResult[i]) {
          isCorrect = false;
          break;
        }
      }
    } else {
      isCorrect = false;
    }
    setState(() {
      status = isCorrect ? 1 : 2;
      curResult = items;
    });
  }
}
