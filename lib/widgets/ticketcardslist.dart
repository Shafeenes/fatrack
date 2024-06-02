import 'dart:async';

import 'package:fatracker/controllers/authcontroller.dart';
import 'package:fatracker/controllers/geocontroller.dart';
import 'package:fatracker/controllers/ticketcontroller.dart';
import 'package:fatracker/main.dart';
import 'package:fatracker/models/geo.dart';
import 'package:fatracker/models/ticket.dart';
import 'package:fatracker/security/ipverify.dart';
import 'package:fatracker/security/macverify.dart';
import 'package:fatracker/widgets/ticketcard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:geolocator_android/geolocator_android.dart';
import 'package:permission_handler/permission_handler.dart';

class TicketCardsList extends StatefulWidget {
  int filteredStatusParam;
  TicketCardsList({key, required this.filteredStatusParam});

  @override
  _TicketCardsListState createState() => _TicketCardsListState(); //need to add
}

class _TicketCardsListState extends State<TicketCardsList> {
  List<Ticket> tickets = [];
  List<TicketCard> ticketCards = [];
  String _jwtKey = "";

  List<Ticket> initIssueData() {
    getTickets_cb().then((ticketdata) => {
          tickets.addAll(ticketdata),
        });
    return tickets;
  }

  Future<List<Ticket>> getTickets_cb() async {
    List<Ticket> data = [];
    AuthController().getAccessKey().then((keyVal) => {
          _jwtKey = keyVal as String,
          TicketController(jwtKey: keyVal).getAllTickets().then((value) => {
                data.clear(),
                data.addAll(value),
              }),
        });
    return data;
  }

  List<TicketCard> getAllTicketCards() {
    tickets.forEach(
      (element) {
        if (widget.filteredStatusParam == element.status ||
            widget.filteredStatusParam != 0) {
          ticketCards.add(TicketCard(
            id: element.id,
            subject: element.subject,
            description: element.description,
            assigner: element.contactPerName,
            assignee: element.currentAssignee.assigneeName,
            project: element.solution.solutionName,
            status: element.status,
            conrtactPerName: element.contactPerName,
            conrtactPerEmail: element.contactPerEmail,
            conrtactPerMob: element.contactPerMobile,
            conrtactPerTel: element.contactPerPhone,
          ));
        } else if (widget.filteredStatusParam == 0) {
          ticketCards.add(TicketCard(
            id: element.id,
            subject: element.subject,
            description: element.description,
            assigner: element.contactPerName,
            assignee: element.currentAssignee.assigneeName,
            project: element.solution.solutionName,
            status: element.status,
            conrtactPerName: element.contactPerName,
            conrtactPerEmail: element.contactPerEmail,
            conrtactPerMob: element.contactPerMobile,
            conrtactPerTel: element.contactPerPhone,
          ));
        }
      },
    );
    return ticketCards;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initIssueData();
    Timer.periodic(const Duration(seconds: 150), locationUpdate_cb);
    _checkAndRequestLocationPermission();
  }

  locationUpdate_cb(Timer timer) async {
    String _userName = "";
    String _macAddr = "";
    Position? position;

    getCurrentLocation().then((value) => {
          position = value,
        });

    MacVerify()
        .getMacAddress(IpVerify().getNetWorkIP().toString())
        .then((value) => {
              _macAddr = value,
            });
    AuthController().getAccessKey().then((key) => {
          AuthController().getAccessKeyUserName().then((value) => {
                _userName = value as String,
                GeoController(jwtKey: key as String).create(Geo(
                    latitude: position!.latitude,
                    longitude: position!.longitude,
                    sourceTS: DateTime.timestamp().toIso8601String(),
                    userStaffCode: key,
                    domainUsername: _userName,
                    userFullName: _userName,
                    deviceId: _macAddr)),
              }),

          print(
              "Key : $key,latitude : ${position!.latitude},longitude : ${position!.longitude},source time zone : ${DateTime.timestamp().toIso8601String()},user staff code : $key, Domain user name : ${_userName}User full name : $_userName, Device ID : $_macAddr"),

          // print(key),
          // print(latitude: position.latitude);
          // longitude: position.longitude,
          // sourceTS: DateTime.timestamp().toIso8601String(),
          // userStaffCode: key,
          // domainUsername: _userName,
          // userFullName: _userName,
          // deviceId: _macAddr)),

          // GeoController(jwtKey: value as String).create(Geo(
          //     latitude: 54.2277562,
          //     longitude: -4.9024638,
          //     sourceTS: DateTime.timestamp().toIso8601String(),
          //     userStaffCode: "Device Developer",
          //     domainUsername: "Device Mobile User",
          //     userFullName: "Flutter native plugin issue user name",
          //     deviceId: "Flutter native plugin issue Mac Address")),
        });
  }

  Future<void> _checkAndRequestLocationPermission() async {
    if (await _hasLocationPermission()) {
      // Permission granted, proceed with location access
      // (call your location fetching function here)
    } else {
      await _requestLocationPermission();
    }
  }

  Future<bool> _hasLocationPermission() async {
    var status = await Permission.location.status;
    return status == PermissionStatus.granted;
  }

  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      print('Location permission granted');
    } else if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings(); // Open app settings for permission management
    } else {
      print('Location permission denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    initIssueData();
    // TicketCardsList().initIssueData();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // var icon = null;
    // Widget ui;
    // bool isLoadedWithNoErrs = falseRR;

    return Container(
        height: height * 1.125,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color.fromRGBO(216, 191, 216, 0.85),
              Color.fromRGBO(216, 191, 216, 0.675),
              Color.fromRGBO(216, 191, 216, 0.425),
              Color.fromRGBO(255, 245, 238, 0.7),
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: FutureBuilder<List<Ticket>>(
          initialData: tickets,
          future: TicketController(jwtKey: _jwtKey).getAllTickets(),
          builder: (context, snapshot) {
            dynamic ui = CircularProgressIndicator();
            List<Widget> cardsList = [];
            if (snapshot.hasError ||
                !snapshot.hasData! &&
                    snapshot.connectionState != ConnectionState.waiting) {
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
            } else if (!snapshot.hasError ||
                snapshot.data!.isNotEmpty &&
                    snapshot.connectionState != ConnectionState.waiting) {
              for (var i = 0; i < snapshot.data!.length; i++) {
                if (snapshot.data![i].status == widget.filteredStatusParam) {
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
                } else if (widget.filteredStatusParam == 0) {
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
              }
              ui = cardsList;
            }
            if (snapshot.connectionState != ConnectionState.waiting) {
              if (cardsList.isEmpty) {
                ui = Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Text("No tickets found!, create one instead?"),
                      TextButton.icon(
                        onPressed: () => {},
                        label: Text("Add ticket"),
                        icon: Icon(Icons.add),
                      )
                    ]));
              }
              if (cardsList.isNotEmpty) {
                // ListView.builder(itemBuilder: (context, int) {
                //   Column(children: cardsList);
                // });
                ui = SingleChildScrollView(
                  // physics: ScrollPhysics(),
                  child: Column(children: cardsList),
                );
              }
            }

            return ui;
          },
        ));
  }
}
