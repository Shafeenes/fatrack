import 'dart:convert';

import 'package:fatracker/models/client_alt.dart';
import 'package:fatracker/models/domainevent.dart';

class BranchAlt {
  int id;
  List<DomainEvent>? domainEvents;
  String created;
  String createdBy;
  String lastModified;
  String lastModifiedBy;
  String branchName;
  int clientId;
  String client;

  BranchAlt(
      {this.id = 0,
      this.domainEvents,
      required this.created,
      required this.createdBy,
      required this.lastModified,
      required this.lastModifiedBy,
      required this.branchName,
      required this.clientId,
      required this.client});

  static BranchAlt fromJson(Map<String, dynamic> json) {
    if (json["lastModified"] == null) {
      json["lastModified"] = "";
    }
    if (json["lastModifiedBy"] == null) {
      json["lastModifiedBy"] = "";
    }
    if (json["client"] == null) {
      json["client"] = "";
    }
    return BranchAlt(
        id: json["id"],
        domainEvents: DomainEvent.toList(json["domainEvents"]),
        created: json["created"],
        createdBy: json["createdBy"],
        lastModified: json["lastModified"],
        lastModifiedBy: json["lastModifiedBy"],
        branchName: json["branchName"],
        clientId: json["clientId"],
        client: json["client"]);
  }

  static Map<String, dynamic> toJson(BranchAlt branchAlt) {
    Map<String, dynamic> branchAltJson = {};

    branchAltJson["id"] = branchAlt.id;
    branchAltJson["domainEvents"] = json.encode(branchAlt.domainEvents);
    branchAltJson["created"] = branchAlt.created;
    branchAltJson["createdBy"] = branchAlt.createdBy;
    branchAltJson["lastModified"] = branchAlt.lastModified;
    branchAltJson["lastModifiedBy"] = branchAlt.lastModifiedBy;
    branchAltJson["branchName"] = branchAlt.branchName;
    branchAltJson["clientId"] = branchAlt.clientId;
    branchAltJson["client"] = json.encode(branchAlt.client);

    return branchAltJson;
  }

  static List<BranchAlt> toList(dynamic branchesJson) {
    List<BranchAlt> branches = [];
    branchesJson.forEach((element) {
      branches.add(fromJson(element));
    });
    return branches;
  }
}
