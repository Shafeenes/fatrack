import 'package:fatracker/controllers/authcontroller.dart';
import 'package:fatracker/controllers/solutioncontroller.dart';
import 'package:fatracker/controllers/ticketcontroller.dart';
import 'package:fatracker/controllers/usercontroller.dart';
import 'package:fatracker/models/solution.dart';
import 'package:fatracker/models/ticket.dart';
import 'package:fatracker/models/user.dart';
import 'package:fatracker/widgets/editsolutioncard.dart';
import 'package:fatracker/widgets/editticketcard.dart';
import 'package:fatracker/widgets/fadropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class SolutionCard extends StatefulWidget {
  int id = 0;
  String solutionName = "";
  String solutionOwner = "";

  SolutionCard(
      {key,
      required this.id,
      required this.solutionName,
      required this.solutionOwner});

  @override
  _SolutionCardState createState() => _SolutionCardState(); //need to add
}

class _SolutionCardState extends State<SolutionCard> {
  // MovieQuery query = MovieQuery.year;

  int _selectedOwner = 0;
  int solutionId = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllSolutions();
  }

  // List<DropdownMenuItem> _statuses = [
  //   DropdownMenuItem(value: 1, child: Text("Open")),
  //   DropdownMenuItem(value: 2, child: Text("Assigned")),
  //   DropdownMenuItem(value: 3, child: Text("WaitingYourReply")),
  //   DropdownMenuItem(value: 4, child: Text("Solved")),
  //   DropdownMenuItem(value: 5, child: Text("Closed"))
  // ];

  // List<Map<String,dynamic>> _statuses = [{"Open":1},{"Assigned":2},{"WaitingYourReply":3},{"Solved":4},{"Closed":}];

  List<Solution> getAllSolutions() {
    List<Solution> solutions = [];
    AuthController().getAccessKey().then((value) => {
          SolutionController(jwtKey: value as String)
              .getAllSolutions()
              .then((value) => {
                    solutions.addAll(value),
                  }),
          // UserController(jwtKey: value as String)
          //     .searchUsers(searchKey)
          //     .then((value) => {
          //           value.forEach((element) {
          //             users.add(element.name);
          //           }),
          //         }),
        });

    return solutions;
  }

  List<User> getAllUsers(String searchKey) {
    List<User> users = [];
    AuthController().getAccessKey().then((value) => {
          UserController(jwtKey: value as String)
              .searchUsers(searchKey)
              .then((value) => {
                    value.forEach((element) {
                      users.add(element);
                    }),
                  }),
        });

    return users;
  }

  viewSolution(
    int id,
    String solutionName,
    String solutionOwner,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditSolutionPage(
                // id:widget.ti
                id: id.toString(),
                solutionName: solutionName,
                solutionOwner: solutionOwner,
                title: "Edit",
              )),
    );
  }

  int _getWidgetStatusVal(String status) {
    int _ticketStatus = 1;
    switch (status) {
      case "Open":
        _ticketStatus = 1;
        break;
      case "Assigned":
        _ticketStatus = 2;
        break;
      case "WaitingYourReply":
        _ticketStatus = 3;
        break;
      case "Solved":
        _ticketStatus = 4;
        break;
      case "Closed":
        _ticketStatus = 5;
        break;
      default:
        _ticketStatus = 1;
        break;
    }
    return _ticketStatus;
  }

  _getWidgetStatusValKey(int status) {
    String _ticketStatusVal = "Open";

    switch (status) {
      case 1:
        _ticketStatusVal = "Open";
        break;
      case 2:
        _ticketStatusVal = "Assigned";
        break;
      case 3:
        _ticketStatusVal = "WaitingYourReply";
        break;
      case 4:
        _ticketStatusVal = "Solved";
        break;
      case 5:
        _ticketStatusVal = "Closed";
        break;
      default:
        _ticketStatusVal = "Open";
        break;
    }
    return _ticketStatusVal;
  }

  saveTicketStatus(int status) {}

  @override
  Widget build(BuildContext context) {
    solutionId = widget.id;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var icon = null;
    // _selectedStatus = _getWidgetStatusVal(widget.status);
    final ValueNotifier<List<Map<String, dynamic>>> _statusListNotifier =
        ValueNotifier<List<Map<String, dynamic>>>([
      {"Open": 1},
      {"Assigned": 2},
      {"WaitingYourReply": 3},
      {"Solved": 4},
      {"Closed": 5},
    ]);

    return GestureDetector(
      onTap: () => {
        viewSolution(
          solutionId,
          widget.solutionName,
          widget.solutionOwner,
        ),
      },
      child: SizedBox(
        // width: width - 8,
        height: height * 0.135,
        child: Card(
          color: const Color.fromRGBO(99, 102, 241, 0.55),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          shadowColor: Colors.blueGrey,
          clipBehavior: Clip.hardEdge,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                alignment: Alignment.centerLeft,
                width: width * 0.57,
                padding: EdgeInsets.only(left: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.solutionName,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w600,
                          fontSize: height * 0.0185,
                          color: Colors.black,
                        )),
                    Text(widget.solutionOwner,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.fade,
                        maxLines: 2,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontStyle: FontStyle.italic,
                          fontSize: height * 0.0155,
                          color: Colors.black,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
