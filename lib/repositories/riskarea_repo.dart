import 'package:group_project/models/risk_area_model.dart';
import 'package:group_project/networks/dangerzone_network.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RiskAreaRepository {
  final String apiUrl;
  RiskAreaRepository(this.apiUrl);

  Future<List<RiskArea>?> getRiskArea() async {
    try {
      // Initialize NetworkHelper with apiUrl
      final networkHelper = DangerZoneNetworkHelper(apiUrl);

      // Use the NetworkHelper to get data
      var data = await networkHelper.getRiskAreaNetwork();
      if (data == null) {
        return null;
      }

      final List<dynamic> jsonList =
          jsonDecode(data) ?? []; // ข้อมูลที่ได้มาเป็นลิสต์

      List<RiskArea> riskarea = [];

      for (var u in jsonList) {
        riskarea.add(RiskArea.fromJson(u));
      }

      // print(riskarea);

      return riskarea;
    } catch (e) {
      // Handle any errors
      print('Error fetching risk area: $e');
      return null;
    }
  }

  // CREATE:
  Future<bool> createRiskArea(Map<String, dynamic> updatedData) async {
    var url1 = Uri.http(this.apiUrl, "/data");
    final response = await http.post(
      url1,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(updatedData),
    );

    print("resp:${response.body}");

    if (response.statusCode == 201) {
      return true; // Update successful
    } else {
      return false; // Update failed
    }
  }

  // UPDATE: Update risk area details
  Future<bool> updateRiskArea(
      String id, Map<String, dynamic> updatedData) async {
    var url1 = Uri.http(this.apiUrl, "/data/$id");
    final response = await http.put(
      url1,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(updatedData),
    );

    print("resp:${response.body}");

    if (response.statusCode == 200) {
      return true; // Update successful
    } else {
      return false; // Update failed
    }
  }

  // SEARCH:
  Future<List<RiskArea>?> searchRiskAreas(String id) async {
    try {
      // Initialize NetworkHelper with apiUrl
      final networkHelper = DangerZoneNetworkHelper(apiUrl);

      // Use the NetworkHelper to get data
      var data = await networkHelper.getOneRiskAreaNetwork(id);
      if (data == null) {
        return null;
      }
      final List<dynamic> jsonList =
          jsonDecode(data) ?? []; // ข้อมูลที่ได้มาเป็นลิสต์

      List<RiskArea> riskarea = [];

      for (var u in jsonList) {
        riskarea.add(RiskArea.fromJson(u));
      }

      // print(riskarea);

      return riskarea;
    } catch (e) {
      // Handle any errors
      print('Error fetching risk area: $e');
      return null;
    }
  }

  // DELETE: Remove risk area by ID
  Future<bool> deleteRiskArea(String id) async {
    print(id);
    var url1 = Uri.http(apiUrl, "/data/$id");
    final response = await http.delete(
      url1,
      headers: {"Content-Type": "application/json"},
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true; // Deletion successful
    } else {
      return false; // Deletion failed
    }
  }
}
