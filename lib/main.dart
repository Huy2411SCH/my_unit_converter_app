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
  double? _feetResult;
  String _displayText = "Fahrenheit: ";
  String _selectedConversion = 'Celsius to Fahrenheit';
  String _buttonText = "Convert to Fahrenheit";
  final List<String> _conversionTypes = ['Celsius to Fahrenheit', 'Meters to Feet'];
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
            DropdownButton(
          // Initial Value
          value: _selectedConversion,
          // Down Arrow Icon
          icon: const Icon(Icons.keyboard_arrow_down),    

          items: _conversionTypes.map((String conversionType) {
            return DropdownMenuItem<String>(
              value: conversionType,
              child: Text(conversionType),
            );
          }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value    
          onChanged: (String? newValue) {
            setState(() {
              _selectedConversion = newValue!;
              
              if (_selectedConversion == 'Celsius to Fahrenheit') {
                _buttonText = "Convert to Fahrenheit";
                _displayText = "Fahrenheit: ";
              } else if (_selectedConversion == 'Meters to Feet') {
                _buttonText = "Convert to Feet";
                _displayText = "Feet: ";
              }
            });
          },
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row (
                children: [
                  if (_selectedConversion == 'Celsius to Fahrenheit')
                    const Text("Celsius: ")
                  else
                    const Text("Meters: "),

                  Expanded(
                    child: TextField(
                      controller: _celsiusController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    double? input = double.tryParse(_celsiusController.text);
                    if (input != null) {
                      double? fahrenheitResult;
                      double? feetResult;
                      if (_selectedConversion == 'Celsius to Fahrenheit') {
                        fahrenheitResult = input * 9 / 5 + 32;
                      } else if (_selectedConversion == 'Meters to Feet') {
                        feetResult = input * 3.28084;
                      }
                      // Update the Text display
                      setState(() {
                        _fahrenheitResult = fahrenheitResult;
                        _feetResult = feetResult;
                        _displayText = _selectedConversion == 'Celsius to Fahrenheit'
                            ? "Fahrenheit: ${_fahrenheitResult!.toStringAsFixed(2)}"
                            : "Feet: ${_feetResult!.toStringAsFixed(2)}";
                      });
                    } 
                    else {
                      //Update/reset the Text display when wrong input
                      setState(() {
                        _fahrenheitResult = null;
                        _feetResult = null;
                        _displayText = _selectedConversion == 'Celsius to Fahrenheit'
                            ? "Fahrenheit: "
                            : "Feet: ";
                      });
                      // Show an error message if the input is not a valid number
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a valid number!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(_buttonText),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _displayText,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
