import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
    WidgetsFlutterBinding.ensureInitialized();

SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
  SystemUiOverlay.top]);  
runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme
        ),
      ),

      debugShowCheckedModeBanner: false,
      home: const Calc(),
    );
  }
}

class Calc extends StatefulWidget {
  const Calc({Key? key}) : super(key: key);

  @override
  _CalcState createState() => _CalcState();
}

class _CalcState extends State<Calc> {
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(vertical: 26.0, horizontal: 12.0),
              child:  Text(
                output,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 72.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button("AC", Colors.grey, Colors.black),
                button("+/-", Colors.grey, Colors.black),
                button("%", Colors.grey, Colors.black),
                button("÷", const Color(0xffFF9500), Colors.white)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button("7", const Color(0xff505050), const Color(0xffffffff)),
                button("8", const Color(0xff505050), const Color(0xffffffff)),
                button("9", const Color(0xff505050), const Color(0xffffffff)),
                button("×", const Color(0xffFF9500), const Color(0xffffffff)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button("4", const Color(0xff505050), const Color(0xffffffff)),
                button("5", const Color(0xff505050), const Color(0xffffffff)),
                button("6", const Color(0xff505050), const Color(0xffffffff)),
                button("−", const Color(0xffFF9500), const Color(0xffffffff)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button("1", const Color(0xff505050), const Color(0xffffffff)),
                button("2", const Color(0xff505050), const Color(0xffffffff)),
                button("3", const Color(0xff505050), const Color(0xffffffff)),
                button("+", const Color(0xffFF9500), const Color(0xffffffff)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButtonZero("0", const Color(0xff505050), const Color(0xffffffff)),
                button(".", const Color(0xff505050), const Color(0xffffffff)),
                button("=", const Color(0xffFF9500), const Color(0xffffffff)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget button(String text, Color color, Color textColor) {
    return Container(
        padding: const EdgeInsets.only(bottom: 12),
        child: MaterialButton(
          onPressed: () => buttonPressed(text),
          padding: const EdgeInsets.all(18),
          color: color,
          textColor: textColor,
          shape: const CircleBorder(),
          child: Text(
            text,
            style: TextStyle(
                color: textColor,
                fontSize: 36,
                fontWeight: FontWeight.w500
                ),
          ),
          )
            );
  }

  Widget buildButtonZero(String text, Color color, Color textColor) {
    return Container(
        margin: const EdgeInsets.only(left: 8, right: 8),
        padding: const EdgeInsets.only(bottom: 12),
        child: MaterialButton(
          padding: const EdgeInsets.only(left: 78, top: 20, right: 78, bottom: 20),
          shape: const StadiumBorder(),
          child: Text(
            text,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.normal,
            ),
          ),
          onPressed: () => buttonPressed(text),
          color: color,
          textColor: textColor,
        )
        );
  }
  String output = "0";
  String clearText = "AC";

  String _output = "0";
  String _clearText = "AC";
  double _num1 = 0.0;
  double _num2 = 0.0;
  String _operand = "";

  buttonPressed(String button) {
    switch (button) {
      case "AC":
        _output = "0";
        _num1 = 0.0;
        _num2 = 0.0;
        _operand = "";
        break;

      case "C":
        _clearText = "AC";
        _output = "0";
        if (_operand == "") {
          _num1 = 0.0;
        } else {
          _num2 = 0.0;
        }
        break;

      case "+":
      case "−":
      case "*":
      case "×":
      case "÷":
        _num1 = double.parse(output);
        _operand = button;
        _output = "0";
        break;

      case ".":
        if (_output.contains(button)) {
          return;
        }
        _output += button;
        break;

      case "+/-":
        _output = (double.parse(output) * -1).toString();
        break;

      case "%":
        _num1 = double.parse(output) / 100;
        _num2 = 0.0;
        _output = _num1.toString();
        _operand = "";
        break;

      case "=":
        _num2 = double.parse(output);

        if (_operand == "+") {
          _output = (_num1 + _num2).toString();
        } else if (_operand == "−") {
          _output = (_num1 - _num2).toString();
        } else if (_operand == "×") {
          _output = (_num1 * _num2).toString();
        } else if (_operand == "÷") {
          _output = (_num1 / _num2).toString();
        }

        _num1 = 0.0;
        _num2 = 0.0;
        _operand = "";
        break;

      default:
        _clearText = "C";
        if (output == "0") {
          _output = button;
        } else {
          _output = _output + button;
        }
        break;
    }

    setState(() {
      clearText = _clearText;
      if (double.parse(_output).round() == double.parse(_output)) {
        output = double.parse(_output).round().toString();
      } else {
        output = _output;
      }
    });
  }
}
