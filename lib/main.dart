// Suggested code may be subject to a license. Learn more: ~LicenseLog:1352796691.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3184945934.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2987123369.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:408146483.
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Form Demonstration',
      theme: ThemeData(
        fontFamily: 'Inter', // Use the Inter font
        primarySwatch: Colors.blue, 
        inputDecorationTheme:
            InputDecorationTheme(border: OutlineInputBorder()),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  String _lastName = '';
  String _firstName = '';
  String _middleInitial = '';
  String _address = '';
  int _age = 0;
  String _gender = 'Male';
  List<String> _selectedHobbies = [];

  final List<String> _hobbies = [
    'Reading',
    'Hiking',
    'Gaming',
    'Coding',
    'Traveling'
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Create a string to display user input in the dialog
      String userInput = '''
    Last Name: $_lastName
    First Name: $_firstName
    Middle Initial: $_middleInitial
    Address: $_address
    Age: $_age
    Gender: $_gender
    Hobbies: ${_selectedHobbies.join(', ')}
    ''';

      // Show confirmation dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm Submission',
                style: TextStyle(fontWeight: FontWeight.bold)),
            content: Text(userInput),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // If accepted, print the values and close the dialog
                  print('Last Name: $_lastName');
                  print('First Name: $_firstName');
                  print('Middle Initial: $_middleInitial');
                  print('Address: $_address');
                  print('Age: $_age');
                  print('Gender: $_gender');
                  print('Hobbies: $_selectedHobbies');
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Accept'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Form Demo',
            style: TextStyle(color: Colors.black)), // Black text on app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.7, // 70% of screen width
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Last Name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                          onSaved: (value) => _lastName = value!,
                        ),
                        SizedBox(height: 12), // Add spacing
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'First Name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                          onSaved: (value) => _firstName = value!,
                        ),
                        SizedBox(height: 12), // Add spacing
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Middle Initial',
                          ),
                          onSaved: (value) => _middleInitial = value!,
                        ),
                        SizedBox(height: 12), // Add spacing
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Address',
                          ),
                          onSaved: (value) => _address = value!,
                        ),
                        SizedBox(height: 12), // Add spacing
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Age',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your age';
                            }
                            final age = int.tryParse(value);
                            if (age == null || age <= 0) {
                              return 'Please enter a valid age';
                            }
                            return null;
                          },
                          onSaved: (value) => _age = int.parse(value!),
                        ),
                        SizedBox(height: 12), // Add spacing
                        // Gender selection with label
                        Align(
                          alignment: Alignment.centerLeft, // Align label to the left
                          child: Text('Gender:',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        // Group the radio buttons
                        Column(
                          children: [
                            ListTile(
                              title: const Text('Male'),
                              leading: Radio<String>(
                              value: 'Male',
                              groupValue: _gender,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value!;
                                });
                              },
                            ),
                            ),
                            ListTile(
                              title: const Text('Female'),
                              leading: Radio<String>(
                              value: 'Female',
                              groupValue: _gender,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value!;
                                });
                              },
                            ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12), // Add spacing
                        ..._hobbies.map((hobby) {
                          return CheckboxListTile(
                            title: Text(hobby),
                            activeColor: Theme.of(context).primaryColor,
                            checkColor: Colors.white, 

                            value: _selectedHobbies.contains(hobby),
                            onChanged: (value) {
                              setState(() {
                                if (value!) {
                                  _selectedHobbies.add(hobby);
                                } else {
                                  _selectedHobbies.remove(hobby);
                                }
                              });
                            },
                          );
                        }).toList(),
                        SizedBox(height: 24), // Add spacing before the button
                        ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 24), 
                            textStyle: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          child: Text('Submit'), 
                        ),
                      ],
                    ),
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
