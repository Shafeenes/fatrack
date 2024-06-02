import 'package:http/http.dart';

class Client {
  int id;
  String clientName;

  Client({this.id = 0, required this.clientName});

  static Client fromJson(Map<String, dynamic> json) {
    return Client(
      id: json["id"],
      clientName: json["clientName"],
    );
  }

  Map<String, dynamic> toJson(Client client) {
    Map<String, dynamic> clientJson = {};

    clientJson["id"] = client.id;
    clientJson["clientName"] = client.clientName;

    return clientJson;
  }
}
