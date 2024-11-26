// Suggested code may be subject to a license. Learn more: ~LicenseLog:1896164575.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3584010107.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3779175563.
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Form Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
            title: Text('Confirm Submission'),
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
        title: Text('Flutter Form Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Last Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                  onSaved: (value) => _lastName = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'First Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                  onSaved: (value) => _firstName = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Middle Initial'),
                  onSaved: (value) => _middleInitial = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Address'),
                  onSaved: (value) => _address = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Age'),
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
                Row(
                  children: <Widget>[
                    Radio<String>(
                      value: 'Male',
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = value!;
                        });
                      },
                    ),
                    Text('Male'),
                    Radio<String>(
                      value: 'Female',
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = value!;
                        });
                      },
                    ),
                    Text('Female'),
                  ],
                ),
                Column(
                  children: _hobbies.map((hobby) {
                    return CheckboxListTile(
                      title: Text(hobby),
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
                ),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
