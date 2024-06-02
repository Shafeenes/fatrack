import 'package:fatracker/animations/fadeoutfadein.dart';
import 'package:fatracker/controllers/authcontroller.dart';
import 'package:fatracker/controllers/ticketcontroller.dart';
import 'package:fatracker/controllers/usercontroller.dart';
import 'package:fatracker/pages/ticketcardslist.dart';
import 'package:fatracker/utils/esc_html_attr.dart';
import 'package:fatracker/widgets/editticketcard.dart';
import 'package:flutter/material.dart';
import 'package:select_field/select_field.dart';

class TicketCard extends StatefulWidget {
  int id = 0;
  String subject;
  String description;
  String assignee;
  String assigner;
  String project;
  int status;
  String conrtactPerName;
  String conrtactPerEmail;
  String conrtactPerMob;
  String conrtactPerTel;

  TicketCard({
    key,
    required this.id,
    required this.subject,
    required this.description,
    required this.assigner,
    required this.assignee,
    required this.project,
    required this.status,
    required this.conrtactPerName,
    required this.conrtactPerEmail,
    required this.conrtactPerMob,
    required this.conrtactPerTel,
  });

  @override
  _TicketCardState createState() => _TicketCardState(); //need to add
}

class _TicketCardState extends State<TicketCard> {
  int _selectedStatus = 1;
  int ticketId = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllUsers("a");
  }

  List<int> _statusVals = [1, 2, 3, 4, 5];

  List<String> getAllUsers(String searchKey) {
    List<String> users = [];
    AuthController().getAccessKey().then((value) => {
          UserController(jwtKey: value as String)
              .searchUsers(searchKey)
              .then((value) => {
                    value.forEach((element) {
                      users.add(element.name);
                    }),
                  }),
        });

    return users;
  }

  viewTicket(
      int id,
      String subject,
      String descrioption,
      String assifgner,
      String assignee,
      String project,
      int status,
      String contactPerEmail,
      String contactPerName,
      String contactPerMob,
      String contactPerTel) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditTicketPage(
                ticketId: ticketId,
                subject: subject,
                description: descrioption,
                assignee: assignee,
                assigner: assifgner,
                project: project,
                status: status,
                conrtactPerEmail: contactPerEmail,
                conrtactPerName: contactPerName,
                conrtactPerMob: contactPerMob,
                conrtactPerTel: contactPerTel,
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

  String _getWidgetStatusValKey(int status) {
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

  String formatHTMLTags(String html) {
    return EscHtmlAttr(htmlstr: html).getConvertedHtml();
  }

  saveTicketStatus(int status) {}

  @override
  Widget build(BuildContext context) {
    _selectedStatus = widget!.status;
    widget.description = widget.description.replaceAll("<p>", "");
    widget.description = widget.description.replaceAll("</p>", "");
    ticketId = widget.id;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var _statusIcon = Padding(
        padding: EdgeInsets.only(top: height * 0.02),
        child: Icon(Icons.bug_report_rounded,
            color: Colors.red, size: (height * 0.135) * 0.112));
    List<Option<String>> statusOptions = [
      Option(label: 'Open', value: '1'),
      Option(label: 'Assigned', value: '2'),
      Option(label: 'WaitingYourReply', value: '3'),
      Option(label: 'Solved', value: '4'),
      Option(label: 'Closed', value: '5'),
    ];

    Padding getRenderedStatusIcon(int renderingStatus) {
      switch (renderingStatus) {
        case 1:
          _statusIcon = Padding(
            padding: EdgeInsets.only(right: height * 0.02),
            child:
                Icon(Icons.bug_report_rounded, color: Colors.red, size: 24.5),
          );

          break;
        case 2:
          _statusIcon = Padding(
              padding: EdgeInsets.only(right: height * 0.02),
              child: Icon(Icons.co_present_rounded,
                  color: Colors.deepOrange, size: 24.5));
          break;
        case 3:
          _statusIcon = Padding(
              padding: EdgeInsets.only(right: height * 0.02),
              child: Icon(Icons.reply_rounded,
                  color: Colors.amberAccent[300], size: 24.5));
          break;
        case 4:
          _statusIcon = Padding(
              padding: EdgeInsets.only(right: height * 0.02),
              child: Icon(Icons.verified,
                  color: Colors.lightGreenAccent, size: 24.5));
          break;
        case 5:
          _statusIcon = Padding(
              padding: EdgeInsets.only(right: height * 0.02),
              child: Icon(Icons.closed_caption,
                  color: Colors.blueGrey[600], size: 24.5));
          break;
        default:
          _statusIcon = Padding(
              padding: EdgeInsets.only(right: height * 0.02),
              child: Icon(Icons.bug_report_rounded,
                  color: Colors.red, size: 24.5));
          break;
      }
      return _statusIcon;
    }

    Padding getStatusIcon() {
      switch (_selectedStatus) {
        case 1:
          _statusIcon = Padding(
            padding: EdgeInsets.only(left: height * 0.02),
            child:
                Icon(Icons.bug_report_rounded, color: Colors.red, size: 24.5),
          );

          break;
        case 2:
          _statusIcon = Padding(
              padding: EdgeInsets.only(left: height * 0.02),
              child: Icon(Icons.co_present_rounded,
                  color: Colors.deepOrange, size: 24.5));
          break;
        case 3:
          _statusIcon = Padding(
              padding: EdgeInsets.only(left: height * 0.02),
              child: Icon(Icons.reply_rounded,
                  color: Colors.amberAccent[300], size: 24.5));
          break;
        case 4:
          _statusIcon = Padding(
              padding: EdgeInsets.only(left: height * 0.02),
              child: Icon(Icons.verified,
                  color: Colors.lightGreenAccent, size: 24.5));
          break;
        case 5:
          _statusIcon = Padding(
              padding: EdgeInsets.only(left: height * 0.02),
              child: Icon(Icons.closed_caption,
                  color: Colors.blueGrey[600], size: 24.5));
          break;
        default:
          _statusIcon = Padding(
              padding: EdgeInsets.only(left: height * 0.02),
              child: Icon(Icons.bug_report_rounded,
                  color: Colors.red, size: 24.5));
          break;
      }
      return _statusIcon;
    }

    return Container(
      child: SizedBox(
        height: 95,
        child: Card(
          color: Theme.of(context).colorScheme.inversePrimary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          shadowColor: Colors.blueGrey,
          clipBehavior: Clip.hardEdge,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () => {
                  viewTicket(
                      ticketId,
                      widget.subject,
                      widget.description,
                      widget.assigner,
                      widget.assignee,
                      widget.project,
                      widget.status,
                      widget.conrtactPerEmail,
                      widget.conrtactPerName,
                      widget.conrtactPerMob,
                      widget.conrtactPerTel),
                },
                child: Container(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  alignment: Alignment.centerLeft,
                  width: width * 0.57,
                  padding: EdgeInsets.only(left: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.subject,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black,
                          )),
                      Text(widget.description,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.fade,
                          maxLines: 2,
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontStyle: FontStyle.italic,
                            fontSize: 10,
                            color: Colors.black,
                          )),
                      Text(widget.assigner,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: width * 0.325,
                  margin: EdgeInsets.only(top: 14, bottom: 14, left: 14),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                          (widget.conrtactPerName.isEmpty ||
                                  widget.conrtactPerName == null)
                              ? "Not assigned"
                              : widget.conrtactPerName,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black,
                          )),
                      Container(
                        height: height * 0.0425,
                        margin: EdgeInsets.only(top: 6),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DropdownButton<int>(
                              value: _selectedStatus,
                              icon: getStatusIcon(),
                              elevation: 16,
                              borderRadius: BorderRadius.circular(8.0),
                              style: const TextStyle(color: Colors.black54),
                              // underline: Container(
                              //   margin: const EdgeInsets.all(8.25),
                              //   height: 1,
                              //   color: Colors.purple[200],
                              // ),
                              onChanged: (int? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  _selectedStatus = value!;
                                  AuthController()
                                      .getAccessKey()
                                      .then((jwtValue) => {
                                            // print(jwtValue),

                                            TicketController(
                                                    jwtKey: jwtValue as String)
                                                .updateTicketStatus(widget.id,
                                                    int.parse(value.toString()))
                                                .then((value) async => {
                                                      if (value! > 0)
                                                        {
                                                          await Future.delayed(
                                                                  const Duration(
                                                                      seconds:
                                                                          3))
                                                              .then((value) => {
                                                                    Future.delayed(const Duration(
                                                                            seconds:
                                                                                3))
                                                                        .then((value) =>
                                                                            {
                                                                              ScaffoldMessenger.of(context).showMaterialBanner(
                                                                                MaterialBanner(
                                                                                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                                                                                  content: Text(
                                                                                    'Relevant ticket status has been updated!',
                                                                                    style: TextStyle(
                                                                                      fontSize: height * 0.02,
                                                                                      fontFamily: "Nunito",
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                  leading: Icon(Icons.refresh_rounded),
                                                                                  backgroundColor: Colors.deepPurple,
                                                                                  actions: <Widget>[
                                                                                    TextButton.icon(
                                                                                        icon: Icon(Icons.refresh_rounded, color: Colors.purpleAccent[200]),
                                                                                        label: Text(
                                                                                          'DISMISS',
                                                                                          style: TextStyle(color: Colors.purpleAccent[200]),
                                                                                        ),
                                                                                        onPressed: () {
                                                                                          // Navigator.push(
                                                                                          //   context,
                                                                                          //   MaterialPageRoute(builder: (context) => TicketCards()),
                                                                                          // );
                                                                                          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                                                                                        }),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            }),
                                                                  }),
                                                          // FadeOutFadeIn(
                                                          //   fadingWidget:
                                                          //       context.widget,
                                                          //   duration: 150,
                                                          // ),
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .hideCurrentMaterialBanner(),
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        TicketCards()),
                                                          ),
                                                        }
                                                    }),
                                          });
                                });
                              },
                              items: _statusVals
                                  .map<DropdownMenuItem<int>>((int value) {
                                return DropdownMenuItem<int>(
                                  value: value,
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        getRenderedStatusIcon(value),
                                        Text(
                                          _getWidgetStatusValKey(value),
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                          ),
                                        ),
                                      ]),
                                );
                              }).toList(),
                            ),
                            Text.rich(
                              TextSpan(
                                text: widget.description,
                              ),
                              softWrap: true,
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                                leadingDistribution:
                                    TextLeadingDistribution.proportional,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
