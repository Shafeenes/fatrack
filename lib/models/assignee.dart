class Assignee {
  int ticketId;
  String assignee;
  String assigneeName;
  String assigneeEmail;
  bool isCurrent;

  Assignee(
      {this.ticketId = 0,
      required this.assignee,
      required this.assigneeName,
      required this.assigneeEmail,
      required this.isCurrent});

  static Assignee fromJson(dynamic json) {
    if (json["ticketId"] == null ||
        json["assigneee"] == null ||
        json["assigneeName"] == null ||
        json["assigneeEmail"] == null ||
        json["isCurrent"] == null) {
      json["ticketId"] = 0;
      json["assigneee"] = "";
      json["assigneeName"] = "";
      json["assigneeEmail"] = "";
    }
    return Assignee(
        ticketId: json["ticketId"],
        assignee: json["assigneee"],
        assigneeName: json["assigneeName"],
        assigneeEmail: json["assigneeEmail"],
        isCurrent: json["isCurrent"]);
  }

  Map<String, dynamic> toJson(Assignee assignee) {
    Map<String, dynamic> assigneeJson = {};

    assigneeJson["ticketId"] = assignee.ticketId;
    assigneeJson["assigneee"] = assignee.assignee;
    assigneeJson["assigneeName"] = assignee.assigneeName;
    assigneeJson["assigneeEmail"] = assignee.assigneeEmail;
    assigneeJson["isCurrent"] = assignee.isCurrent;

    return assigneeJson;
  }

  static List<Assignee> toList(dynamic assigneesJson) {
    List<Assignee> assignees = [];
    if (assigneesJson.length > 0) {
      assigneesJson.forEach((element) {
        assignees.add(fromJson(element));
      });
    }

    return assignees;
  }
}
