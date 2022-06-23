import 'package:flutter/material.dart';

import 'demo/setting_page.dart';
import 'demo/verify_page.dart';

void main() => runApp(const MainPage());

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  void _routeToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return page;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Gesture Recoginition"),
        ),
        body: Builder(builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                  child: const SizedBox(
                    height: 60,
                    child: Center(
                      child: Text(
                        "Setting Gesture",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                  onPressed: () => _routeToPage(context, const SettingPage())),
              MaterialButton(
                  child: const SizedBox(
                    height: 60,
                    child: Center(
                      child: Text(
                        "Verification Gesture",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                  onPressed: () => _routeToPage(context, const VerifyPage())),
            ],
          );
        }),
      ),
    );
  }
}
