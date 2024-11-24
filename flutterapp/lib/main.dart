import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(PredictionApp());

class PredictionApp extends StatefulWidget {
  @override
  _PredictionAppState createState() => _PredictionAppState();
}

class _PredictionAppState extends State<PredictionApp> {
  // To keep track of Dark Mode toggle state
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PREDIKTA', // Set the app's title
      theme: ThemeData.light(), // Light theme by default
      darkTheme: ThemeData.dark(), // Dark theme
      themeMode: _isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light, // Dynamically set the themeMode based on the toggle
      debugShowCheckedModeBanner: false, // Removes the debug banner
      home: PredictionScreen(
        isDarkMode: _isDarkMode,
        toggleDarkMode: _toggleDarkMode,
      ),
    );
  }

  // Function to toggle Dark Mode
  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }
}

class PredictionScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) toggleDarkMode;

  PredictionScreen({required this.isDarkMode, required this.toggleDarkMode});

  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  // Text controllers for each input field
  final TextEditingController _creditScoreController = TextEditingController();
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _yearsInOperationController =
      TextEditingController();

  String _predictionResult = '';

  // Dropdown value for Business Type
  int _selectedBusinessType = 0; // Default to Agriculture (0)

  // Function to send the inputs to the FastAPI backend and fetch predictions
  Future<void> fetchPrediction(double creditScore, double loanAmount,
      int businessType, int yearsInOperation) async {
    try {
      final url =
          Uri.parse('http://127.0.0.1:8000/predict'); // Your FastAPI URL
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'credit_score': creditScore,
          'loan_amount': loanAmount,
          'business_type': businessType,
          'years_in_operation': yearsInOperation,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          _predictionResult =
              'Predicted Growth Rate: ${responseData['predicted_annual_revenue_growth_rate']}%';
        });
      } else {
        setState(() {
          _predictionResult = 'Error: ${response.statusCode}';
        });
      }
    } catch (error) {
      setState(() {
        _predictionResult = 'Error: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PREDIKTA', // Updated app name
          style: TextStyle(
            fontSize: 30, // Larger font size
            fontWeight: FontWeight.bold, // Bold text for emphasis
            letterSpacing: 3, // Slight letter spacing for modern look
            color: widget.isDarkMode
                ? Colors.white
                : Colors.blue.shade800, // Set the title color dynamically
          ),
        ),
        actions: [
          // Dark Mode toggle switch
          Switch(
            value: widget.isDarkMode,
            onChanged: widget.toggleDarkMode,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromRGBO(187, 222, 251, 1),
              Colors.blue.shade400
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 50),
                Text(
                  'REVENUE GROWTH RATE PREDICTOR',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'This app predicts the potential annual revenue growth rate of your business based on key factors like credit score, loan amount, years in operation, and business type.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _creditScoreController,
                          decoration: InputDecoration(
                            labelText: 'Credit Score',
                            hintText: 'Enter your credit score (e.g., 750)',
                            hintStyle: TextStyle(
                              color: Colors.grey, // Light gray text
                              fontWeight: FontWeight.w400, // Less bold
                            ),
                            prefixIcon: Icon(Icons.credit_score,
                                color: Colors.blue), // Blue icon
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _loanAmountController,
                          decoration: InputDecoration(
                            labelText: 'Loan Amount',
                            hintText: 'Enter loan amount in USD (e.g., 5000)',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                            prefixIcon: Icon(Icons.monetization_on,
                                color: Colors.blue), // Blue icon
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 10),
                        // Label and Dropdown for selecting business type with icon
                        Row(
                          children: [
                            Icon(Icons.business,
                                color:
                                    Colors.blue), // Blue icon for business type
                            SizedBox(
                                width: 10), // Space between the icon and text
                            Text(
                              'Business Type',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                                width:
                                    20), // Add some space between the label and dropdown
                            DropdownButton<int>(
                              value: _selectedBusinessType,
                              items: [
                                DropdownMenuItem(
                                    value: 0, child: Text('Agriculture')),
                                DropdownMenuItem(
                                    value: 1, child: Text('Manufacturing')),
                                DropdownMenuItem(value: 2, child: Text('Retail')),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedBusinessType = value!;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _yearsInOperationController,
                          decoration: InputDecoration(
                            labelText: 'Years in Operation',
                            hintText: 'Enter years in operation (e.g., 5)',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                            prefixIcon: Icon(Icons.timelapse,
                                color: Colors.blue), // Blue icon
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final creditScore =
                        double.tryParse(_creditScoreController.text);
                    final loanAmount =
                        double.tryParse(_loanAmountController.text);
                    final yearsInOperation =
                        int.tryParse(_yearsInOperationController.text);

                    if (creditScore != null &&
                        loanAmount != null &&
                        yearsInOperation != null) {
                      fetchPrediction(creditScore, loanAmount,
                          _selectedBusinessType, yearsInOperation);
                    } else {
                      setState(() {
                        _predictionResult = 'Please enter valid inputs.';
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: Colors.blue.shade600,
                  ),
                  child: Text(
                    'Predict',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 20),
                if (_predictionResult.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Text(
                      _predictionResult,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
