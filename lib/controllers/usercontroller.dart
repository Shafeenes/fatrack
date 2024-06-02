import "dart:convert";

import "package:fatracker/constant/api_consts.dart";
import "package:fatracker/models/user.dart";
import "package:http/http.dart" as http;

class UserController {
  String jwtKey;

  UserController({required this.jwtKey});

  Future<List<User>> searchUsers(String searchKey) async {
    List<User> users = <User>[];
    // var headersList = {'Authorization': 'Bearer $jwtKey'};
    var headersList = {
      'Authorization': 'Bearer $jwtKey',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse(
        '$API_URL/api/Employees/searchemployee?FilterText=$searchKey');

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
      users.addAll(User.toList(json.decode(resBody)));
    } else {
      print(res.reasonPhrase);
    }
    return users;
  }
}
