import "dart:convert";

import "package:fatracker/constant/api_consts.dart";
import "package:fatracker/models/client_alt.dart";
import "package:fatracker/models/solution.dart";
import "package:http/http.dart" as http;

class SolutionController {
  String jwtKey;

  SolutionController({required this.jwtKey});

  Future<List<Solution>> getAllSolutions() async {
    List<Solution> solutions = <Solution>[];
    //var headersList = {'Authorization': 'Bearer $jwtKey'};
    var headersList = {
      'Authorization': 'Bearer ${this.jwtKey}',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$API_URL/api/Solution');

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
      solutions.addAll(Solution.toList(json.decode(resBody) as List));
    } else {
      print(res.reasonPhrase);
    }
    return solutions;
  }

  Future<String> createSolution(
      String solutionName, String solutionOwner) async {
    String msg = '';
    var headersList = {
      'Authorization': 'Bearer ${this.jwtKey}',
      // 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InJhc21peWEudGVjaCIsIk5hbWUiOiJSYXNtaXlhIE5hamVlbSIsIlVzZXJuYW1lIjoicmFzbWl5YS50ZWNoIiwiVXNlcklkIjoicmFzbWl5YS50ZWNoQGZsb3JhZ3JvdXAubmV0IiwiTWVtYmVyT2YiOiJDTj1Qcm9qZWN0IERlcGFydG1lbnQsREM9ZmxvcmFncm91cCxEQz1uZXQiLCJqdGkiOiIzOWE2MTVkNC05ODdiLTRkYjAtOGM0OC1jMDFjYzU2NjkxZDgiLCJuYmYiOjE3MTM2ODUzMDcsImV4cCI6MTcxMzY5MjUwNywiaWF0IjoxNzEzNjg1MzA3fQ.sYKCiZRDEZakyZcqd4AsvZr0y_xkWl1qEevPGk9WQi0',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$API_URL/api/Tickets');

    var body = {
      "createDto": {
        "solutionName": solutionName,
        "solutionOwner": solutionOwner
      }
    };

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      if (resBody.isNotEmpty) {
        msg = resBody;
      }
      print(resBody);
    } else {
      print(res.reasonPhrase);
    }

    return msg;
  }

  Future<String> deleteSolution(int solutionId) async {
    String msg = "";
    var headersList = {
      'Authorization': 'Bearer ${this.jwtKey}',
      // 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InJhc21peWEudGVjaCIsIk5hbWUiOiJSYXNtaXlhIE5hamVlbSIsIlVzZXJuYW1lIjoicmFzbWl5YS50ZWNoIiwiVXNlcklkIjoicmFzbWl5YS50ZWNoQGZsb3JhZ3JvdXAubmV0IiwiTWVtYmVyT2YiOiJDTj1Qcm9qZWN0IERlcGFydG1lbnQsREM9ZmxvcmFncm91cCxEQz1uZXQiLCJqdGkiOiIzOWE2MTVkNC05ODdiLTRkYjAtOGM0OC1jMDFjYzU2NjkxZDgiLCJuYmYiOjE3MTM2ODUzMDcsImV4cCI6MTcxMzY5MjUwNywiaWF0IjoxNzEzNjg1MzA3fQ.sYKCiZRDEZakyZcqd4AsvZr0y_xkWl1qEevPGk9WQi0',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$API_URL/api/Solution/$solutionId');

    var req = http.Request('DELETE', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      if (resBody.isNotEmpty) {
        msg = resBody;
      }
      print(resBody);
    } else {
      print(res.reasonPhrase);
    }

    return msg;
  }

  Future<String> updateSolution(Solution solution) async {
    String msg = "";
    var headersList = {
      'Authorization': 'Bearer ${this.jwtKey}',
      // 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InJhc21peWEudGVjaCIsIk5hbWUiOiJSYXNtaXlhIE5hamVlbSIsIlVzZXJuYW1lIjoicmFzbWl5YS50ZWNoIiwiVXNlcklkIjoicmFzbWl5YS50ZWNoQGZsb3JhZ3JvdXAubmV0IiwiTWVtYmVyT2YiOiJDTj1Qcm9qZWN0IERlcGFydG1lbnQsREM9ZmxvcmFncm91cCxEQz1uZXQiLCJqdGkiOiIzOWE2MTVkNC05ODdiLTRkYjAtOGM0OC1jMDFjYzU2NjkxZDgiLCJuYmYiOjE3MTM2ODUzMDcsImV4cCI6MTcxMzY5MjUwNywiaWF0IjoxNzEzNjg1MzA3fQ.sYKCiZRDEZakyZcqd4AsvZr0y_xkWl1qEevPGk9WQi0',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$API_URL/api/Solution');

    var req = http.Request('PUT', url);
    req.headers.addAll(headersList);
    req.body = json.encode({
      "updateDto": {
        "solutionName": solution.solutionName,
        "solutionOwner": solution.solutionOwner,
        "id": solution.id
      }
    });

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      if (resBody.isNotEmpty) {
        msg = resBody;
      }
      print(resBody);
    } else {
      print(res.reasonPhrase);
    }

    return msg;
  }
}
