import 'package:fatracker/controllers/authcontroller.dart';
import 'package:fatracker/controllers/solutioncontroller.dart';
import 'package:fatracker/controllers/ticketcontroller.dart';
import 'package:fatracker/models/solution.dart';
import 'package:fatracker/models/ticket.dart';
import 'package:fatracker/widgets/solutioncard.dart';
import 'package:fatracker/widgets/ticketcard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class SolutionCardsList extends StatefulWidget {
  SolutionCardsList({key});

  @override
  _SolutionCardsListState createState() =>
      _SolutionCardsListState(); //need to add
}

class _SolutionCardsListState extends State<SolutionCardsList> {
  List<Solution> solutions = [];
  String _jwtKey = "";

  initIssueData() {
    AuthController().getAccessKey().then((value) => {
          _jwtKey = value as String,
          SolutionController(jwtKey: _jwtKey)
              .getAllSolutions()
              .then((value) => {
                    solutions.addAll(value),
                  }),
        });

    return solutions;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initIssueData();
  }

  @override
  Widget build(BuildContext context) {
    // initIssueData();
    // TicketCardsList().initIssueData();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // var icon = null;
    // Widget ui;
    // bool isLoadedWithNoErrs = falseRR;
    List<SolutionCard> solutionCards = [];

    solutions.forEach(
      (element) {
        solutionCards.add(SolutionCard(
          id: element.id,
          solutionName: element.solutionName,
          solutionOwner: element.solutionOwner,
        ));
      },
    );

    // return Column(
    //   children: ticketCards,
    // );
    return Container(
        height: height * 0.735,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.875, 1),
            colors: <Color>[
              Color.fromRGBO(128, 0, 128, 1),
              Color.fromRGBO(149, 53, 83, 0.85),
              Color.fromRGBO(248, 200, 220, 0.5),
              Color.fromRGBO(216, 191, 216, 0.675),
              Color.fromRGBO(255, 245, 238, 0.7),
            ], // Gradient from https://learnui.design/tools/gradient-generator.html
            tileMode: TileMode.mirror,
          ),
        ),
        child: FutureBuilder<List<Ticket>>(
          future: TicketController(jwtKey: _jwtKey).getAllTickets(),
          builder: (context, snapshot) {
            dynamic ui = CircularProgressIndicator();
            List<Widget> cardsList = [];
            if (snapshot.hasError || !snapshot.hasData) {
              ui = Center(
                child: (snapshot.hasError)
                    ? Text("Aw snap Erred on : " + snapshot.error.toString())
                    : Column(children: [
                        Text("No tickets found!, create one instead?"),
                        TextButton.icon(
                          onPressed: () => {},
                          label: Text("Add ticket"),
                          icon: Icon(Icons.add),
                        )
                      ]),
              );
            } else if (!snapshot.hasError || snapshot.data!.isNotEmpty) {
              for (var i = 0; i < snapshot.data!.length; i++) {
                cardsList.add(TicketCard(
                  id: snapshot.data![i].id,
                  subject: snapshot.data![i].subject,
                  description: snapshot.data![i].description,
                  assigner: snapshot.data![i].contactPerName,
                  assignee: snapshot.data![i].currentAssignee.assigneeName,
                  project: snapshot.data![i].solution.solutionName,
                  status: snapshot.data![i].status,
                  conrtactPerName: snapshot.data![i].contactPerName,
                  conrtactPerEmail: snapshot.data![i].supporteeEmail,
                  conrtactPerMob: snapshot.data![i].contactPerMobile,
                  conrtactPerTel: snapshot.data![i].contactPerPhone,
                ));
              }
              ui = cardsList;
            }
            if (snapshot.connectionState == ConnectionState.done) {
              if (cardsList.isEmpty) {
                ui = Text("No tickets found!");
              } else if (cardsList.isNotEmpty) {
                ui = Column(children: cardsList);
              }
            }

            return ui;
          },
        ));
  }
}
