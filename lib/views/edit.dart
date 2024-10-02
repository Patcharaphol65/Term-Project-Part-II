import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_project/components/alert.dart';
import 'package:group_project/models/data.dart';
import 'package:group_project/models/risk_area_model.dart';
import 'package:group_project/models/userModel.dart';
import 'package:group_project/repositories/riskarea_repo.dart';

class EditPage extends StatefulWidget {
  final String id;

  EditPage({super.key, required this.id});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late RiskArea? ra;
  bool done_load = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _describeController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _longController = TextEditingController();
  String? dropdownDangerValue; // Variable to hold the dropdown value
  String? dropdownRiskLevelValue; // Variable to hold the dropdown value

  String? _errorTitleMessage;
  String? _errorLocationMessage;
  String? _errorLatMessage;
  String? _errorLongMessage;
  String? _errorDescriptionMessage;

  @override
  void initState() {
    super.initState();
    print('Updating, check-id:${widget.id}');
    riskAreaGetOneService();
  }

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

  Future<void> riskAreaGetOneService() async {
    var x = RiskAreaRepository(locate);
    try {
      var resp = await x.searchRiskAreas(widget.id);
      print('resp:$resp');
      if (resp != null) {
        setState(() {
          for (var item in resp) {
            ra = RiskArea(
                id: item.id,
                name: item.name,
                riskLevel: item.riskLevel,
                location: item.location,
                dangerType: item.dangerType,
                description: item.description,
                lat: item.lat,
                long: item.long);
            _titleController.text = ra?.name ?? '';
            _locationController.text = ra?.location ?? 'Default Location';
            _describeController.text = ra?.description ?? 'Default Description';
            _latController.text = ra?.lat.toString() ?? '0.0';
            _longController.text = ra?.long.toString() ?? '0.0';
            dropdownRiskLevelValue = ra?.riskLevel.toString() ?? 'None';
            dropdownDangerValue = ra?.dangerType.toString() ?? 'None';
          }
          done_load = true;
        });
      } else {
        print('No data found for the given ID.');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

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

    String title = _titleController.text;
    String location = _locationController.text;
    String description = _describeController.text;
    double? latitude = double.tryParse(_latController.text);
    double? longitude = double.tryParse(_longController.text);
    String? dangerType = dropdownDangerValue;
    String? riskLevel = dropdownRiskLevelValue;

    // print('Title: $title');
    // print('Location: $location');
    // print('Description: $description');
    // print('Latitude: $latitude');
    // print('Longitude: $longitude');
    // print('Risk Level: $riskLevel');
    // print('Danger Type: $dangerType');

    Map<String, dynamic> updatedData = {
      'name': title,
      'location': location,
      'riskLevel': riskLevel,
      'dangerType': dangerType,
      'description': description,
      'lat': latitude,
      'long': longitude,
    };

    bool? confirm_result = await alertEditSuccessMessage(context);

    if (confirm_result == null) {
      alertEditUnSuccessMessage(context);
    } else {
      print(confirm_result);
      if (confirm_result) {
        var x = RiskAreaRepository(locate);
        bool success = await x.updateRiskArea(widget.id, updatedData);

        if (success) {
          print('Data updated successfully');
          alertEditOk(context);
        } else {
          // alertEditUnSuccessMessage(context);
          print('Error updating risk area');
          alertEditUnSuccessMessage(context);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Risk Area'),
      ),
      body: done_load
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
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
                          errorText: _errorTitleMessage),
                    ),
                    SizedBox(height: 10),
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
                    SizedBox(height: 10),
                    DropdownEdit(
                      items: risk_list,
                      title: 'Risk Level',
                      onSearchSubmitted: _updateRisk,
                      firstV: dropdownRiskLevelValue.toString(),
                    ),
                    SizedBox(height: 10),
                    DropdownEdit(
                      items: danger_list,
                      title: 'Danger Type',
                      onSearchSubmitted: _updateDanger,
                      firstV: dropdownDangerValue.toString(),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _latController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^-?\d*\.?\d*$'))
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
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^-?\d*\.?\d*$'))
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
                      maxLines: 5,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter the description here',
                          errorText: _errorDescriptionMessage),
                    ),
                    SizedBox(height: 20),
                    // Submit Button
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: ElevatedButton.icon(
                              icon: Icon(
                                Icons.cancel_outlined,
                                color: Colors.black,
                                size: 24.0,
                                semanticLabel:
                                    'Text to announce in accessibility modes',
                              ),
                              label: Text("Cancer"),
                              onPressed: () {
                                Navigator.pop(
                                    context); // Go back to the previous screen
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Color.fromARGB(255, 195, 195,
                                    195), // Change color as needed
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            width:
                                10), // ใช้ width แทน height สำหรับการเว้นระยะ
                        Expanded(
                          child: Container(
                            child: ElevatedButton.icon(
                              icon: Icon(
                                Icons.save_as_outlined,
                                color: Colors.white,
                                size: 24.0,
                                semanticLabel:
                                    'Text to announce in accessibility modes',
                              ),
                              label: Text("Submit"),
                              onPressed: () {
                                _submit();
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Color(0xFF303C54),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          : Center(
              child: Text('Fetching data...'),
            ),
    );
  }
}

class DropdownEdit extends StatelessWidget {
  final List<String> items;
  final String title;
  final String firstV;
  final Function(String) onSearchSubmitted;

  const DropdownEdit({
    Key? key,
    required this.items,
    required this.title,
    required this.firstV,
    required this.onSearchSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: firstV.isNotEmpty ? firstV : null,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        labelText: title,
        border: OutlineInputBorder(),
      ),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          onSearchSubmitted(newValue);
        }
      },
    );
  }
}
