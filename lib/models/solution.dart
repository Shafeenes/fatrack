class Solution {
  int id;
  String solutionName;
  String solutionOwner;

  Solution({
    this.id = 0,
    required this.solutionName,
    required this.solutionOwner,
  });

  static Solution fromJson(Map<String, dynamic> json) {
    return Solution(
      id: json["id"],
      solutionName: json["solutionName"],
      solutionOwner: json["solutionOwner"],
    );
  }

  Map<String, dynamic> toJson(Solution solution) {
    Map<String, dynamic> solutionJson = {};

    solutionJson["id"] = solution.id;
    solutionJson["solutionName"] = solution.solutionName;
    solutionJson["solutionUrl"] = solution.solutionOwner;

    return solutionJson;
  }

  static List<Solution> toList(dynamic solutionsJson) {
    List<Solution> solutions = [];
    solutionsJson.forEach((element) {
      var solutionEle = fromJson(element);
      solutions.add(solutionEle);
    });
    return solutions;
  }
}
