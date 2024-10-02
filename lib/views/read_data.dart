import 'package:flutter/material.dart';
import 'package:group_project/models/data.dart';
import 'package:group_project/models/risk_area_model.dart';
import 'package:group_project/repositories/riskarea_repo.dart';
import 'package:group_project/views/data_detail.dart';

class ReadData extends StatefulWidget {
  const ReadData({super.key});

  @override
  State<ReadData> createState() => _ReadDataState();
}

class _ReadDataState extends State<ReadData> {
  late List<RiskArea> data = [];
  late List<RiskArea> dataClone = [];
  String searchWord = "";
  String status = 'Data loading...';

  void _updateSearchWord(String newSearchWord) {
    setState(() {
      searchWord = newSearchWord;
      // Implement your search/filtering logic here
      if (data.isNotEmpty) {
        // Assuming you want to keep the original data intact, create a new filtered list
        data = data
            .where((element) => element.location
                .toLowerCase()
                .contains(newSearchWord.toLowerCase()))
            .toList(); // Ensure to call toList() with parentheses
      } else {
        status = 'Not Found';
      }
    });
    if (newSearchWord == "") {
      setState(() {
        data = dataClone;
        status = 'Data loading...';
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("fetching data...");
    riskareaService();
  }

  void _navigateToAnotherPage(BuildContext context, RiskArea dt) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(data: dt),
      ),
    );
  }

  Future<void> riskareaService() async {
    var x = RiskAreaRepository(locate);

    try {
      var resp = await x.getRiskArea();
      // จัดการกับ resp ที่ได้รับที่นี่
      if (resp != null) {
        if (resp.isEmpty) {
          print('no data');
        } else {
          List<RiskArea>? d = [];
          for (var ra in resp) {
            d.add(RiskArea(
                id: ra.id,
                name: ra.name,
                riskLevel: ra.riskLevel,
                location: ra.location,
                dangerType: ra.dangerType,
                description: ra.description,
                lat: ra.lat,
                long: ra.long));
          }
          setState(() {
            data = d;
            dataClone = data;
            status = 'Data loading...';
          });
        }
      } else {
        setState(() {
          status = 'Fail to Load data\nTry again!';
        });
      }
    } catch (e) {
      // fetch to load data
      print('s2');
    }
  }

  Widget checkType(String dangerType) {
    if (dangerType == 'Crime') {
      return Icon(Icons.warning, color: Colors.red);
    } else if (dangerType == 'Weather') {
      return Icon(Icons.cloud, color: Colors.blue);
    } else if (dangerType == 'Heat') {
      return Icon(Icons.thermostat, color: Colors.orange);
    } else if (dangerType == 'Environmental') {
      return Icon(Icons.nature, color: Colors.green);
    } else if (dangerType == 'Flooding') {
      return Icon(Icons.water_damage, color: Colors.lightBlue);
    } else if (dangerType == 'Economic') {
      return Icon(Icons.money_off, color: Colors.grey);
    } else {
      return Icon(Icons.error, color: Colors.grey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Dangerous Area in America',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF303C54), // สีพื้นหลังของ AppBar
        ),
        backgroundColor: Colors.grey[200], // สีพื้นหลังของ Scaffold
        body: Column(
          children: [
            SearchBox(
              search: searchWord,
              onSearchSubmitted: _updateSearchWord,
            ),
            // show all data
            Expanded(
              child: data.isEmpty
                  ? Container(
                      child: Text(
                      '$status',
                      style: TextStyle(fontSize: 36.0),
                    ))
                  : ListView.builder(
                      itemCount: data.length, // จำนวนรายการใน ListView
                      itemBuilder: (context, index) {
                        RiskArea dataMain = data[index];
                        return Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0), // กำหนด margin
                          decoration: BoxDecoration(
                            color: Color(
                                0xFF303C54), // กำหนดสีพื้นหลังของ ListTile
                            borderRadius: BorderRadius.circular(
                                8.0), // เพิ่มมุมโค้งให้กับ Container
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3), // เปลี่ยนตำแหน่งของเงา
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: checkType(dataMain.dangerType),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${dataMain.name}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  '${dataMain.location}',
                                  style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize:
                                          12.0), // สไตล์สำหรับข้อความที่เพิ่ม
                                ),
                                Text(
                                  '${dataMain.dangerType}', // ข้อความใหม่ที่เพิ่ม
                                  style: TextStyle(
                                      color: Colors.grey[400], fontSize: 14.0),
                                ),
                              ],
                            ),
                            contentPadding: EdgeInsets.all(16.0),
                            onTap: () {
                              // การกระทำเมื่อกดที่รายการ
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   SnackBar(content: Text('Tapped on item ${index + 1}')),
                              // );
                              _navigateToAnotherPage(context, dataMain);
                            },
                          ),
                        );
                      },
                    ),
            )
          ],
        ));
  }
}

class SearchBox extends StatefulWidget {
  final String? search;
  final ValueChanged<String> onSearchSubmitted;

  const SearchBox({super.key, this.search, required this.onSearchSubmitted});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final TextEditingController _searchController = TextEditingController();

  List<RiskArea> filteredLocations = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('www:${widget.search}');
  }

  void _submitSearch() {
    final searchValue = _searchController.text;
    widget.onSearchSubmitted(searchValue);
    print('Submitted: ${_searchController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
          ), // Search icon
          hintText: 'Search...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none, // Remove default border
          ),
          filled: true,
          fillColor: Colors.grey[400], // Background color
        ),
        onChanged: (value) {
          _submitSearch();
        },
      ),
    );
  }
}
