import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      theme: ThemeData(
        // This is the theme of your application.

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Unit Converter Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _celsiusController = TextEditingController();
  double? _fahrenheitResult;
  String _displayText = "Fahrenheit: ";
  @override
  Widget build(BuildContext context) {
    // This method is called whenever the state changes 
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temp Converter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _celsiusController,
                keyboardType: TextInputType.number,
              ),

            ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    double? celsius = double.tryParse(_celsiusController.text);
                    if (celsius != null) {
                      double fahrenheit = celsius * 9 / 5 + 32;
                      //Update the Text display
                      setState(() {
                        _fahrenheitResult = fahrenheit;
                        _displayText = "Fahrenheit: ${_fahrenheitResult!.toStringAsFixed(2)}";
                      });
                    } else {
                      // Show an error message if the input is not a valid number
                      setState(() {
                        _fahrenheitResult = null;
                        _displayText = "Fahrenheit: ";
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a valid number!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text('Convert'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _displayText,

                ),
              ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
