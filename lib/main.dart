import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _seconds = 0.0;
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      prefs.clear();
    });
  }

  void _saveData() {
    // reset shared preferences
    SharedPreferences.getInstance().then((prefs) {
      prefs.clear();
    });

    print('Execution started');
    double currentTime = DateTime.now().millisecondsSinceEpoch / 1000;
    print('Current time: $currentTime');

    for (var element in numbers) {
      print(element);
      SharedPreferences.getInstance().then((prefs) {
        prefs.setInt('$element', element);
      });
    }

    double endTime = DateTime.now().millisecondsSinceEpoch / 1000;
    print('End time: $endTime');

    print('Execution time: ${endTime - currentTime}');
    setState(() {
      _seconds = ((endTime - currentTime) * 1000).roundToDouble();
    });

    SharedPreferences.getInstance().then((prefs) {
      prefs.clear();
    });
  }

  void _storeDataOnLocal(key, val) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('$key', val.toString());
    print(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Press button to start execution.',
            ),
            Text(
              'Your last execution took $_seconds ms.',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveData,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
