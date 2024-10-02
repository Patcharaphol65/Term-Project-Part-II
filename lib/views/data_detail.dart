import 'package:flutter/material.dart';
import 'package:group_project/components/alert.dart';
import 'package:group_project/models/data.dart';
import 'package:group_project/models/risk_area_model.dart';
import 'package:group_project/repositories/riskarea_repo.dart';
import 'package:group_project/services/display_location_service.dart';
import 'package:group_project/views/edit.dart';
import 'package:group_project/models/userModel.dart';

class DetailPage extends StatefulWidget {
  final RiskArea data;
  const DetailPage({super.key, required this.data});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool display = false;
  bool _isExpanded = false; // สำหรับการเปลี่ยนแปลงแบบ animated

  @override
  void initState() {
    super.initState();
    if (User.userLogin != null) {
      display = true;
    }
  }

  Widget checkType(String dangerType) {
    Color color;
    switch (dangerType) {
      case 'Crime':
        color = Colors.red;
        break;
      case 'Weather':
        color = Colors.blue;
        break;
      case 'Heat':
        color = Colors.orange;
        break;
      case 'Environmental':
        color = Colors.green;
        break;
      case 'Flooding':
        color = Colors.lightBlue;
        break;
      case 'Economic':
        color = Colors.grey;
        break;
      default:
        color = Colors.grey;
    }
    return AnimatedContainer(
      duration: const Duration(seconds: 1), // เพิ่ม Animation
      height: 15,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Future<void> _delRiskArea() async {
    var x = RiskAreaRepository(locate);
    bool success = await x.deleteRiskArea(widget.data.id);
    print('del:$success');
    success
        ? alertDeleteSuccessMessage(context)
        : alertDeleteUnSuccessMessage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Hero(
          tag: 'title-${widget.data.name}', // ใช้ Hero Animation
          child: Material(
            color: Colors.transparent,
            child: Text(
              '${widget.data.name}',
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ),
        backgroundColor: const Color(0xFF303C54),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded =
                        !_isExpanded; // เปลี่ยนแปลงสถานะเพื่อขยายหรือลดขนาด
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut, // เพิ่ม Animation เวลาเปิด-ปิด
                  height: _isExpanded ? 360 : 360, // เปลี่ยนขนาดแบบไดนามิก
                  child: MapWithMarker(
                      lat: widget.data.lat, long: widget.data.long),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF303C54),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${widget.data.name}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Risk Level: ${widget.data.riskLevel}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Danger Type: ${widget.data.dangerType}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Description: ${widget.data.description}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                    checkType(widget.data.dangerType),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              display
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: const Color(0xFFc8e7f9),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditPage(id: widget.data.id),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text('Edit'),
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: const Color(0xFFf29f9f),
                          ),
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              backgroundColor: const Color(0xFF383434),
                              title: const Text(
                                'Are you sure you want to delete?',
                                style: TextStyle(color: Colors.white),
                              ),
                              actions: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.red),
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
                                        ),
                                        onPressed: () {
                                          _delRiskArea();
                                          Navigator.pop(context, 'Cancel');
                                        },
                                        child: const Text('Yes'),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.green),
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
                                        ),
                                        onPressed: () {
                                          print(widget.data.id);
                                          Navigator.pop(context, 'OK');
                                        },
                                        child: const Text('No'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          icon: const Icon(Icons.delete),
                          label: const Text('Remove'),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
