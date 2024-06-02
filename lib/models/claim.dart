import 'package:fatracker/models/subject.dart';

class Claim {
  String issuer = "";
  String originalIssuer = "";
  Subject subject;
  List<Object> properties = [];

  Claim({
    this.issuer = "",
    this.originalIssuer = "",
    required this.subject,
    required this.properties,
  });

  Claim fromJson(Map<String, dynamic> json) {
    // Claim
    return Claim(
      issuer: json["issuer"],
      originalIssuer: json["originalIssuer"],
      subject: json["subject"],
      properties: json["properties"],
    );
  }

  Map<String, dynamic> toJson(Claim claim) {
    Map<String, dynamic> ticketJson = {};

    ticketJson["issuer"] = claim.issuer;
    ticketJson["originalIssuer"] = claim.originalIssuer;
    ticketJson["subject"] = claim.subject;
    ticketJson["properties"] = claim.properties;

    return ticketJson;
  }

  List<Claim> toList(List<Map<String, dynamic>> claimsJson) {
    List<Claim> claims = [];
    claimsJson.forEach((element) {
      claims.add(fromJson(element));
    });
    return claims;
  }
}
