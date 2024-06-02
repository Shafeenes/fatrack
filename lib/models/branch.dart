class Branch {
  int id;
  String branchName;
  int clientId;

  Branch({this.id = 0, required this.branchName, required this.clientId});

  static Branch fromJson(Map<String, dynamic> json) {
    return Branch(
        id: json["id"],
        branchName: json["branchName"],
        clientId: json["clientId"]);
  }

  Map<String, dynamic> toJson(Branch branch) {
    Map<String, dynamic> branchJson = {};

    branchJson["id"] = branch.id;
    branchJson["clientName"] = branch.branchName;
    branchJson["clientId"] = branch.clientId;

    return branchJson;
  }
}
