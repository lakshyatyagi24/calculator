import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primaryColor: Colors.black,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = '0';
  String _currentNumber = '';
  double _num1 = 0;
  double _num2 = 0;
  String _operator = '';

 double performMath(num1, num2, operator) {
    double finalNum = 0;
    switch (operator) {
      case '+':
        finalNum = (num1 + num2);
        break;
      case '-':
        finalNum = (num1 - num2);
        break;
      case 'x':
        finalNum = (num1 * num2);
        break;
      case '/':
        finalNum = (num1 / num2);
        break;
    }
    return finalNum;
  }

  void _buttonPressed(String buttonText) {
    setState(() {
      switch (buttonText) {
        case 'C':
          _output = '0';
          _currentNumber = '0';
          _num1 = 0;
          _num2 = 0;
          _operator = '';
          break;
        case '+' || '-' || 'x' || '/':
          if (_num1 != 0) {
            _num2 = double.parse(_currentNumber);
            _num1 = performMath(_num1, _num2, _operator);
            _num2 = 0;
            _operator = '';
          } else {
            _num1 = double.parse(_currentNumber);
            _operator = buttonText;
            _currentNumber = '';
          }
          break;
        case '.':
          if (!_currentNumber.contains('.')) {
            _currentNumber += buttonText;
          }
          break;
        case '=':
          _num2 = double.parse(_currentNumber);
          _currentNumber = performMath(_num1, _num2, _operator).toString();
          _num1 = 0;
          _num2 = 0;
          _operator = '';
          break;
        default:
          if (!(buttonText[0] == '0' && _currentNumber[0] == '0')) {
            if (_currentNumber == '0') {
              _currentNumber = '';
            }
            _currentNumber += buttonText;
          }
          break;
      }

      _output = _currentNumber;
    });
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
            onPrimary: Colors.white,
            textStyle: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.all(16.0),
        ),
        onPressed: () => _buttonPressed(buttonText),
        child: Text(
          buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3C3C3C), Color(0xFF000000)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: Text('Calculator', style: TextStyle(color: Colors.white, fontSize: 20),),
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
                child: Text(
                  _output,
                  style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.black,
              thickness: 2.0,
            ),
            Expanded(
              flex: 3,
              child: ListView(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      _buildButton('7'),
                      _buildButton('8'),
                      _buildButton('9'),
                      _buildButton('/'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      _buildButton('4'),
                      _buildButton('5'),
                      _buildButton('6'),
                      _buildButton('x'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      _buildButton('1'),
                      _buildButton('2'),
                      _buildButton('3'),
                      _buildButton('-'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      _buildButton('.'),
                      _buildButton('0'),
                      _buildButton('00'),
                      _buildButton('+'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      _buildButton('C'),
                      _buildButton('='),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}