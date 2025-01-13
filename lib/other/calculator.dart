import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String currentInput = "";
  double result = 0;
  String lastOperator = ' ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF7893FF),
      appBar: AppBar(
        backgroundColor: Color(0xFF7893FF),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Calculator',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          // Display Area
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFE9E6F7),
                      Color(0xFFE9E6F7),
                    ], // Warna gradient
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30), // Radius atas kiri
                    topRight: Radius.circular(30), // Radius atas kanan
                  ),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      currentInput,
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.end,
                    ),
                    SizedBox(height: 10),
                    Text(
                      _getDisplayResult(),
                      style:
                          TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Buttons Area
          Container(
            color: Color(0xFFE9E6F7),
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton("C",
                        onPressed: clearOnClick, color: Colors.grey),
                    _buildButton("AC",
                        onPressed: acOnClick, color: Colors.grey),
                    _buildButton("⌫",
                        onPressed: deleteOnClick, color: Colors.grey),
                    _buildButton("÷",
                        onPressed: () => handleOperator('÷'),
                        color: Colors.blue[100]!),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton("7", onPressed: () => appendInput("7")),
                    _buildButton("8", onPressed: () => appendInput("8")),
                    _buildButton("9", onPressed: () => appendInput("9")),
                    _buildButton("×",
                        onPressed: () => handleOperator('×'),
                        color: Colors.blue[100]!),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton("4", onPressed: () => appendInput("4")),
                    _buildButton("5", onPressed: () => appendInput("5")),
                    _buildButton("6", onPressed: () => appendInput("6")),
                    _buildButton("-",
                        onPressed: () => handleOperator('-'),
                        color: Colors.blue[100]!),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton("1", onPressed: () => appendInput("1")),
                    _buildButton("2", onPressed: () => appendInput("2")),
                    _buildButton("3", onPressed: () => appendInput("3")),
                    _buildButton("+",
                        onPressed: () => handleOperator('+'),
                        color: Colors.blue[100]!),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton("0", onPressed: () => appendInput("0")),
                    _buildButton(".", onPressed: () => appendInput(".")),
                    _buildButton("=",
                        onPressed: calculateResult,
                        color: const Color(0xFFA4B4F6),
                        flex: 2),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text,
      {required VoidCallback onPressed,
      Color color = Colors.white,
      int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: EdgeInsets.all(4),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.black87,
            padding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  void clearOnClick() {
    setState(() {
      currentInput = "";
      result = 0;
      lastOperator = ' ';
    });
  }

  void acOnClick() {
    setState(() {
      currentInput = "";
    });
  }

  void deleteOnClick() {
    if (currentInput.isNotEmpty) {
      setState(() {
        currentInput = currentInput.substring(0, currentInput.length - 1);
      });
    }
  }

  void appendInput(String input) {
    setState(() {
      currentInput += input;
    });
  }

  void handleOperator(String operator) {
    if (currentInput.isNotEmpty) {
      setState(() {
        lastOperator = operator;
        currentInput += " $operator ";
      });
    }
  }

  void calculateResult() {
    List<String> parts = currentInput.split(" ");
    if (parts.length == 3) {
      double num1 = double.parse(parts[0]);
      String operator = parts[1];
      double num2 = double.parse(parts[2]);

      setState(() {
        switch (operator) {
          case '+':
            result = num1 + num2;
            break;
          case '-':
            result = num1 - num2;
            break;
          case '×':
            result = num1 * num2;
            break;
          case '÷':
            if (num2 != 0) {
              result = num1 / num2;
            } else {
              result = double.nan;
            }
            break;
        }

        currentInput = "";
        lastOperator = ' ';
      });
    }
  }

  String _getDisplayResult() {
    if (result.isNaN) {
      return "Error";
    } else {
      if (lastOperator == '÷' || result % 1 != 0) {
        return result.toString();
      } else {
        return result.toStringAsFixed(0);
      }
    }
  }
}
