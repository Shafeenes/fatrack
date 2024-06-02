import 'dart:convert';

import 'package:fatracker/models/domainevent.dart';
import 'package:http/http.dart';

class ClientAlt {
  int id;
  List<DomainEvent>? domainEvents;
  String created;
  String createdBy;
  String lastModified;
  String lastModifiedBy;
  String clientName;

  ClientAlt(
      {this.id = 0,
      this.domainEvents,
      required this.created,
      required this.createdBy,
      required this.lastModified,
      required this.lastModifiedBy,
      required this.clientName});

  static ClientAlt fromJson(Map<String, dynamic> json) {
    if (json["lastModified"] == null) {
      json["lastModified"] = "";
    }
    if (json["lastModifiedBy"] == null) {
      json["lastModifiedBy"] = "";
    }
    return ClientAlt(
      id: json["id"],
      domainEvents: json[""],
      created: json["created"],
      createdBy: json["createdBy"],
      lastModified: json["lastModified"],
      lastModifiedBy: json["lastModifiedBy"],
      clientName: json["clientName"],
    );
  }

  Map<String, dynamic> toJson(ClientAlt clientAlt) {
    Map<String, dynamic> clientAltJson = {};

    clientAltJson["id"] = clientAlt.id;
    clientAltJson["domainEvents"] = json.encode(clientAlt.domainEvents);
    clientAltJson["created"] = clientAlt.created;
    clientAltJson["createdBy"] = clientAlt.createdBy;
    clientAltJson["lastModified"] = clientAlt.lastModified;
    clientAltJson["lastModifiedBy"] = clientAlt.lastModifiedBy;
    clientAltJson["clientName"] = clientAlt.clientName;

    return clientAltJson;
  }

  static List<ClientAlt> toList(dynamic clientsJson) {
    List<ClientAlt> clients = [];
    clientsJson.forEach((element) {
      var clientEle = fromJson(element);
      clients.add(clientEle);
    });
    return clients;
  }
}
