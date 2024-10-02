import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_project/components/alert.dart';
import 'package:group_project/models/data.dart';
import 'package:group_project/models/risk_area_model.dart';
import 'package:group_project/models/userModel.dart';
import 'package:group_project/repositories/riskarea_repo.dart';
import 'package:group_project/repositories/user_repo.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool userLogin = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorUsernameMessage;
  String? _errorPasswordMessage;

  void initState() {
    super.initState();
    print("initState Called");
    // Dispose the controller when the widget is removed from the widget tree
    if (User.userLogin != null) {
      print('....');
      userLogin = true;
      return;
    }
    // loginService();
    print('test2');
  }

  Future<void> loginService() async {
    setState(() {
      _errorPasswordMessage = null; // Reset error message
      _errorUsernameMessage = null;
    });

    bool foundErr = false;

    if (_usernameController.text.isEmpty) {
      setState(() {
        _errorUsernameMessage = 'Please enter username';
      });
      foundErr = true;
    }

    if (_passwordController.text.isEmpty) {
      setState(() {
        _errorPasswordMessage = 'Please enter password';
      });
      foundErr = true;
    }

    if (foundErr) return;

    var x = UserRepository(locate);

    // var url = Uri.http("192.168.0.102:3000", "/users");
    try {
      var resp = await x.getUser();
      // จัดการกับ resp ที่ได้รับที่นี่
      if (resp != null) {
        if (resp.isEmpty) {
          print('user-name or password are invalid');
        } else {
          for (var user in resp) {
            if (user.username == _usernameController.text &&
                user.password == _passwordController.text) {
              User.userLogin = User(
                  username: user.username,
                  fullname: "",
                  password: user.password);
              setState(() {
                userLogin = true;
              });
            }
          }
          print('found: $userLogin');
          if (userLogin) {
            // Navigator.pushNamed(context, '/login');
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/login', // Replace with your login route
              (Route<dynamic> route) =>
                  false, // Remove all routes from the stack
            );
            return;
          } else {
            // display invalid data
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                backgroundColor: Color(0xFF383434),
                title: const Text(
                  'Username or Password is invalid!',
                  style: TextStyle(color: Colors.white),
                ),
                actions: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 8.0), // Margin between buttons
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: () {
                              print("del");
                              Navigator.pop(context, 'Cancel');
                            },
                            child: const Text('Yes'),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
            return;
          }
        }
      }
    } catch (e) {}

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF383434),
          title: const Text(
            'The system is not ready to service!',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 8.0), // Margin between buttons
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: () {
                        print("Cancel pressed");
                        Navigator.pop(context);
                      },
                      child: const Text('Yes'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
    // print("data:${resp}");
    print('test');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: userLogin
            ? createPage()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.person_outline, size: 100), // User Icon
                  SizedBox(height: 20), // Space between icon and title
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 40), // Space between title and form
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: "username",
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      errorText: _errorUsernameMessage,
                    ),
                  ),
                  SizedBox(height: 20), // Space between fields
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: "password",
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      errorText: _errorPasswordMessage,
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 30), // Space before button
                  ElevatedButton.icon(
                    icon: Icon(Icons.arrow_forward),
                    label: Text("Login"),
                    onPressed: () {
                      loginService();
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity,
                            50), // Set the button's width and height
                        backgroundColor: Color(0xFF303C54),
                        foregroundColor: Colors.white),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class createPage extends StatefulWidget {
  @override
  _createPageState createState() => _createPageState();
}

class _createPageState extends State<createPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _describeController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _longController = TextEditingController();
  String? dropdownDangerValue = "Crime"; // Variable to hold the dropdown value
  String? dropdownRiskLevelValue =
      "Moderate"; // Variable to hold the dropdown value

  void _updateDanger(String newSearchWord) {
    setState(() {
      dropdownDangerValue = newSearchWord;
    });
  }

  void _updateRisk(String newSearchWord) {
    setState(() {
      dropdownRiskLevelValue = newSearchWord;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // max index
  }

  Future<String?> findNextId() async {
    var repository = RiskAreaRepository(locate);
    try {
      // Fetch all risk areas
      List<RiskArea>? riskAreas = await repository.getRiskArea();

      // Extract IDs and find the maximum
      int maxIdValue = -1; // Initialize to a value lower than any possible ID

      for (var area in riskAreas!) {
        int currentIdValue =
            int.tryParse(area.id) ?? -1; // Convert ID to integer
        if (currentIdValue > maxIdValue) {
          maxIdValue = currentIdValue; // Update max ID value
        }
      }

      // Increment the maximum ID by 1
      String nextId = (maxIdValue + 1).toString();
      return nextId; // Return the incremented ID
    } catch (e) {
      print("Error fetching risk areas: $e");
      return null; // Handle error appropriately
    }
  }

  void _logout(BuildContext context) {
    // Implement your logout logic here
    // For example, navigate to the login screen or clear authentication tokens
    User.userLogin = null;
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/', // Replace with your login route
      (Route<dynamic> route) => false, // Remove all routes from the stack
    );
  }

  String? _errorTitleMessage;
  String? _errorLocationMessage;
  String? _errorLatMessage;
  String? _errorLongMessage;
  String? _errorDescriptionMessage;

  Future<void> _submit() async {
    if (User.userLogin == null) {
      Navigator.pushNamed(context, "/");
      return;
    }
    setState(() {
      _errorTitleMessage = '';
      _errorLocationMessage = '';
      _errorLatMessage = '';
      _errorLongMessage = '';
      _errorDescriptionMessage = '';
    });
    bool foundErr = false;
    // Perform validation
    if (_titleController.text.isEmpty) {
      setState(() {
        _errorTitleMessage = 'Please enter a title';
      });
      foundErr = true;
    }
    if (_locationController.text.isEmpty) {
      setState(() {
        _errorLocationMessage = 'Please enter a location';
      });
      foundErr = true;
    }
    if (_describeController.text.isEmpty) {
      setState(() {
        _errorDescriptionMessage = 'Please enter a description';
      });
      foundErr = true;
    }
    if (_latController.text.isEmpty ||
        double.tryParse(_latController.text) == null) {
      setState(() {
        _errorLatMessage = 'Please enter a valid latitude';
      });
      foundErr = true;
    }
    if (_longController.text.isEmpty ||
        double.tryParse(_longController.text) == null) {
      setState(() {
        _errorLongMessage = 'Please enter a valid longitude';
      });
      foundErr = true;
    }

    if (foundErr) return;
    // Get the values from the controllers and dropdowns
    String title = _titleController.text;
    String location = _locationController.text;
    String description = _describeController.text;
    double? latitude = double.tryParse(_latController.text);
    double? longitude = double.tryParse(_longController.text);
    String? dangerType = dropdownDangerValue; // Selected danger type
    String? riskLevel = dropdownRiskLevelValue; // Selected risk level

    // Perform your submission logic here (e.g., sending data to an API)
    print('Title: $title');
    print('Location: $location');
    print('Description: $description');
    print('Latitude: $latitude');
    print('Longitude: $longitude');
    print('Risk Level: $riskLevel');
    print('Danger Type: $dangerType');
    String? maxID = await findNextId();

    if (maxID == null) {
      print("Error fetching risk areas");
      return;
    }

    // Create the updated data map
    Map<String, dynamic> updatedData = {
      'id': maxID,
      'name': title,
      'location': location,
      'riskLevel': riskLevel,
      'dangerType': dangerType,
      'description': description,
      'lat': latitude,
      'long': longitude,
    };

    // Call the create method
    var x = RiskAreaRepository(locate);
    bool success = await x.createRiskArea(updatedData);

    if (success) {
      print('already create');
      alertCreateSuccessMessage(context);
    } else {
      print('Error create risk area');
      alertCreateUnSuccessMessage(context);
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/', // The name of the root route
              (Route<dynamic> route) =>
                  false, // Remove all routes from the stack
            );
          },
        ),
        actions: <Widget>[
          // Logout Button
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Implement logout functionality here
              _logout(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  errorText: _errorTitleMessage,
                )),
            SizedBox(height: 10), // Space between fields
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                  labelText: "Location",
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  errorText: _errorLocationMessage),
            ),
            SizedBox(height: 10), // Space before button
            DropdownEdit(
              items: risk_list,
              title: 'RiskLevel',
              onSearchSubmitted: _updateRisk,
            ),
            SizedBox(height: 10),
            DropdownEdit(
              items: danger_list,
              title: 'DangerType',
              onSearchSubmitted: _updateDanger,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _latController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(
                    r'^-?\d*\.?\d*$')) // Restrict to numbers and decimal points
              ],
              decoration: InputDecoration(
                  labelText: "Lat",
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  errorText: _errorLatMessage),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _longController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(
                    r'^-?\d*\.?\d*$')) // Restrict to numbers and decimal points
              ],
              decoration: InputDecoration(
                  labelText: "Long",
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  errorText: _errorLongMessage),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _describeController,
              maxLines: 5, // Allows multiline input
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter the description here',
                  errorText: _errorDescriptionMessage),
            ),
            // Space before button
            SizedBox(height: 20),
            // Submit
            ElevatedButton.icon(
              icon: Icon(Icons.arrow_forward),
              label: Text("Submit"),
              onPressed: () {
                _submit();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF303C54),
                minimumSize: Size(
                    double.infinity, 50), // Set the button's width and height
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _titleController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}

class DropdownEdit extends StatefulWidget {
  final List<String> items;
  final title;
  final ValueChanged<String> onSearchSubmitted;

  const DropdownEdit(
      {super.key,
      required this.items,
      required this.title,
      required this.onSearchSubmitted});

  @override
  State<DropdownEdit> createState() => _DropdownEditState();
}

class _DropdownEditState extends State<DropdownEdit> {
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          "${widget.title} Selection",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
            height: 8), // Add some space between the title and the dropdown

        // Full width dropdown button
        SizedBox(
          width: double.infinity,
          child: DropdownButton<String>(
            value: dropdownValue,
            isExpanded: true, // Makes the dropdown button take full width
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue;
              });
              widget.onSearchSubmitted(newValue!);
            },
            items: widget.items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
