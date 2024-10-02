import 'dart:convert';
import 'package:group_project/models/userModel.dart';
import 'package:group_project/networks/user_network.dart';

class UserRepository {
  final String apiUrl;

  UserRepository(this.apiUrl);

  Future<List<User>?> getUser() async {
    try {
      // Initialize NetworkHelper with apiUrl
      final networkHelper = UserNetworkHelper(apiUrl);

      // Use the NetworkHelper to get data
      final data = await networkHelper.getUser();
      if(data == null){
        return null;
      }

      final List<dynamic> jsonList = jsonDecode(data) ?? []; // ข้อมูลที่ได้มาเป็นลิสต์

      List<User> user = [];

      for (var u in jsonList) {
        user.add(User.fromJson(u));
      }
      return user;
    } catch (e) {
      // Handle any errors
      print('Error fetching risk area: $e');
      return null;
    }
  }
}