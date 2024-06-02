class Geo {
  double latitude;
  double longitude;
  String sourceTS;
  String userStaffCode;
  String domainUsername;
  String userFullName;
  String deviceId;

  Geo({
    required this.latitude,
    required this.longitude,
    required this.sourceTS,
    required this.userStaffCode,
    required this.domainUsername,
    required this.userFullName,
    required this.deviceId,
  });

  static Geo fromJson(Map<String, dynamic> json) {
    return Geo(
      latitude: json["latitude"],
      longitude: json["longitude"],
      sourceTS: json["sourceTS"],
      userStaffCode: json["userStaffCode"],
      domainUsername: json["domainUsername"],
      userFullName: json["userFullName"],
      deviceId: json["deviceId"],
    );
  }

  Map<String, dynamic> toJson(Geo geo) {
    Map<String, dynamic> geoJson = {};

    geoJson["latitude"] = geo.latitude;
    geoJson["longitude"] = geo.longitude;
    geoJson["sourceTS"] = geo.sourceTS;
    geoJson["userStaffCode"] = geo.userStaffCode;
    geoJson["domainUsername"] = geo.domainUsername;
    geoJson["userFullName"] = geo.userFullName;
    geoJson["deviceId"] = geo.deviceId;

    return geoJson;
  }

  static List<Geo> toList(dynamic geoJson) {
    List<Geo> geoLocs = [];
    geoJson.forEach((element) {
      var solutionEle = fromJson(element);
      geoLocs.add(solutionEle);
    });
    return geoLocs;
  }
}
