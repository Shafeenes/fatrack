class Subject {
  String auithenticationType = "";
  bool isAuthenticated = false;
  String actor = "";
  String bootstrapContext = "";
  String label = "";
  String name = "";
  String nameClaimType = "";
  String roleClaimType = "";

  Subject({
    required this.auithenticationType,
    required this.isAuthenticated,
    required this.actor,
    required this.bootstrapContext,
    required this.label,
    required this.name,
    required this.nameClaimType,
    required this.roleClaimType,
  });

  static Subject fromJson(Map<String, dynamic> json) {
    return Subject(
      auithenticationType: json["auithenticationType"],
      isAuthenticated: json["isAuthenticated"],
      actor: json["actor"],
      bootstrapContext: json["bootstrapContext"],
      label: json["label"],
      name: json["name"],
      nameClaimType: json["nameClaimType"],
      roleClaimType: json["roleClaimType"],
    );
  }

  Map<String, dynamic> toJson(Subject subject) {
    Map<String, dynamic> subjectJson = {};

    subjectJson["auithenticationType"] = subject.auithenticationType;
    subjectJson["isAuthenticated"] = subject.isAuthenticated;
    subjectJson["actor"] = subject.actor;
    subjectJson["bootstrapContext"] = subject.bootstrapContext;
    subjectJson["label"] = subject.label;
    subjectJson["name"] = subject..name;
    subjectJson["nameClaimType"] = subject.nameClaimType;
    subjectJson["roleClaimType"] = subject.roleClaimType;

    return subjectJson;
  }
}
