import 'package:http/http.dart' as http;

class UserNetworkHelper {
  final String baseUrl;

  UserNetworkHelper(this.baseUrl);

  Future<String?> getUser() async {
    try {
      var url = Uri.http(this.baseUrl, "/users");
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
}
