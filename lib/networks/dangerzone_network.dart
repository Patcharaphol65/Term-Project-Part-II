import 'package:http/http.dart' as http;

class DangerZoneNetworkHelper {
  final String baseUrl;

  DangerZoneNetworkHelper(this.baseUrl);

  Future<String?> getRiskAreaNetwork() async {
    try {
      var url = Uri.http(this.baseUrl, "/data");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // print("data:${response.body}");
        return response.body;
      } else {
        return null;
      }
    } catch (e) {
      // จัดการข้อผิดพลาดที่เกิดขึ้นที่นี่
      print('เกิดข้อผิดพลาด: $e');
      return null;
    }
  }

  Future<String?> getOneRiskAreaNetwork(String id) async {
    try {
      // var url = Uri.http(this.baseUrl, "/data/?id=${id}");
      var url = Uri.http(this.baseUrl, "/data/", {"id": id});
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // print("data:${response.body}");
        return response.body;
      } else {
        print('-----');
        return null;
      }
    } catch (e) {
      // จัดการข้อผิดพลาดที่เกิดขึ้นที่นี่
      print('เกิดข้อผิดพลาด: $e');
      return null;
    }
  }
}
