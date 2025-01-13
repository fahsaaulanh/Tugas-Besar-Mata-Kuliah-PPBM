import 'package:flutter/material.dart';

class ConversionPage extends StatefulWidget {
  @override
  _ConversionPageState createState() => _ConversionPageState();
}

class _ConversionPageState extends State<ConversionPage> {
  String selectedConversion = "Temperature";
  String input = "";
  String output = "";
  String unitFrom = "Celsius";
  String unitTo = "Fahrenheit";

  final Map<String, List<String>> conversionOptions = {
    "Temperature": ["Celsius", "Fahrenheit", "Kelvin"],
    "Currency": ["USD", "EUR", "IDR"],
    "Weight": ["Kilograms", "Pounds", "Grams"]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF7893FF),
      appBar: AppBar(
        backgroundColor: Color(0xFF7893FF),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Converter',
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
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Conversion Selection
                    DropdownButton<String>(
                      value: selectedConversion,
                      isExpanded: true,
                      items: conversionOptions.keys
                          .map((key) => DropdownMenuItem(
                                value: key,
                                child: Text(key),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedConversion = value!;
                          unitFrom = conversionOptions[selectedConversion]![0];
                          unitTo = conversionOptions[selectedConversion]![1];
                          input = "";
                          output = "";
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    // Input Field
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Enter value",
                        labelStyle:
                            TextStyle(color: Color(0xFF7893FF)), // Warna label
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF7893FF), // Warna border saat aktif
                            width: 2.0,
                          ),
                          borderRadius:
                              BorderRadius.circular(8), // Radius border
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(
                                0xFF7893FF), // Warna border saat tidak aktif
                            width: 1.5,
                          ),
                          borderRadius:
                              BorderRadius.circular(8), // Radius border
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          input = value;
                          output = _convert();
                        });
                      },
                    ),

                    SizedBox(height: 16),
                    // Unit Selection
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButton<String>(
                            value: unitFrom,
                            isExpanded: true,
                            items: conversionOptions[selectedConversion]!
                                .map((unit) => DropdownMenuItem(
                                      value: unit,
                                      child: Text(unit),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                unitFrom = value!;
                                output = _convert();
                              });
                            },
                          ),
                        ),
                        Icon(Icons.arrow_forward),
                        Expanded(
                          child: DropdownButton<String>(
                            value: unitTo,
                            isExpanded: true,
                            items: conversionOptions[selectedConversion]!
                                .map((unit) => DropdownMenuItem(
                                      value: unit,
                                      child: Text(unit),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                unitTo = value!;
                                output = _convert();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    // Output Display
                    Text(
                      "Result:",
                      style: TextStyle(
                          color: Color(0xFFF84669),
                          fontSize: 27,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      " $output",
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 350),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _convert() {
    if (input.isEmpty) return "";
    double inputValue = double.tryParse(input) ?? 0;
    double convertedValue = 0;

    switch (selectedConversion) {
      case "Temperature":
        if (unitFrom == "Celsius" && unitTo == "Fahrenheit") {
          convertedValue = (inputValue * 9 / 5) + 32;
        } else if (unitFrom == "Fahrenheit" && unitTo == "Celsius") {
          convertedValue = (inputValue - 32) * 5 / 9;
        } else if (unitFrom == "Celsius" && unitTo == "Kelvin") {
          convertedValue = inputValue + 273.15;
        }
        break;
      case "Currency":
        if (unitFrom == "USD" && unitTo == "EUR") {
          convertedValue = inputValue * 0.85;
        } else if (unitFrom == "USD" && unitTo == "IDR") {
          convertedValue = inputValue * 14000;
        }
        break;
      case "Weight":
        if (unitFrom == "Kilograms" && unitTo == "Pounds") {
          convertedValue = inputValue * 2.20462;
        } else if (unitFrom == "Pounds" && unitTo == "Kilograms") {
          convertedValue = inputValue / 2.20462;
        }
        break;
    }

    return convertedValue.toStringAsFixed(2);
  }
}
