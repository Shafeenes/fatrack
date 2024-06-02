import 'package:fatracker/controllers/authcontroller.dart';
import 'package:fatracker/controllers/ticketcontroller.dart';
import 'package:fatracker/models/solution.dart';
import 'package:fatracker/models/ticket.dart';
import 'package:fatracker/pages/login.dart';
import 'package:fatracker/pages/ticket/create.dart';
import 'package:fatracker/utils/status_icon.dart';
// import 'package:fatracker/pages/ticketsilverlist.dart';
import 'package:fatracker/widgets/solutioncard.dart';
import 'package:fatracker/widgets/solutioncardslist.dart';
import 'package:fatracker/widgets/ticketcardslist.dart';
import "package:flutter/material.dart";
import 'dart:developer' as developer;

import 'package:select_field/select_field.dart';

class TicketCards extends StatelessWidget {
  List<Ticket> tickets = [];
  TicketCards({key});
  // final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  //     GlobalKey<RefreshIndicatorState>();
  retrieveTickets() {
    AuthController().getAccessKey().then((value) => {
          TicketController(jwtKey: value as String)
              .getAllTickets()
              .then((value) => {
                    tickets.addAll(tickets),
                  }),
        });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var _statusIcon = Padding(
        padding: EdgeInsets.only(top: height * 0.02),
        child: Icon(Icons.bug_report_rounded,
            color: Colors.red, size: (height * 0.135) * 0.112));
    List<Option<String>> statusOptions = [
      Option(label: 'All', value: '0'),
      Option(label: 'Open', value: '1'),
      Option(label: 'Assigned', value: '2'),
      Option(label: 'WaitingYourReply', value: '3'),
      Option(label: 'Solved', value: '4'),
      Option(label: 'Closed', value: '5'),
    ];
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        // dra
      ),
      home: TicketCardsPage(
        title: 'Flora Issue Tracker',
        ticketList: tickets,
      ),
    );
  }
}

class TicketCardsPage extends StatefulWidget {
  List<Ticket> ticketList;

  TicketCardsPage({key, required this.title, required this.ticketList});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<TicketCardsPage> createState() => _TicketCardsPageState();
}

class _TicketCardsPageState extends State<TicketCardsPage> {
  int _selectedStatus = 0;
  int currentPageIndex = 0;
  int _counter = 0;
  bool isDrawerOpen = false;

  late List<Ticket> tickets;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initTickets();
  }

  List<int> _statusVals = [0, 1, 2, 3, 4, 5];

  initTickets() {
    tickets = List.empty();
    AuthController().getAccessKey().then((value) => {
          TicketController(jwtKey: value as String)
              .getAllTickets()
              .then((value) => {
                    tickets.addAll(tickets),
                  }),
        });
  }

  bool _isPasswordVisible = false;
  bool _isLoggedIn = false;
  String _userName = "";
  String _passWord = "";
  // List<Ticket> tickets = [];
  String _jwtKey = "";
  int _filteredStatus = 0;
  bool _filteredAllStatus = true;
  bool _filteredOpenStatus = false;
  bool _filteredAssignedStatus = false;
  bool _filteredWaitingForReplyStatus = false;
  bool _filteredSolvedStatus = false;
  bool _filteredClosedStatus = false;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool isAuthorized() {
    // String _jwtKey;

    // AuthController().login(_userName, _passWord);
    // _jwtKey = AuthController().getToken();
    AuthController().getAccessKey().then((value) => {
          _jwtKey = value as String,
        });
    _isLoggedIn = _jwtKey.isNotEmpty;
    return _isLoggedIn;
  }

  void _loginIntoTracker() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      // _counter++;
      developer.log("Logging in!");

      // AuthController()
      //     .login(_userName, _passWord)
      //     .then((value) => {tickets.addAll(value)});

      tickets.addAll(getAllTickets());

      if (tickets.isNotEmpty) {
        // _isLoggedIn = true;
        developer.log("Found tickets for the user");
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TicketCardsPage(
                    title: "Tickets",
                    ticketList: getAllTickets(),
                  )),
        );
      }

      developer.log("No tickets for the user");
    });
  }

  List<Ticket> getAllTickets() {
    List<Ticket> ticketsArr = [];
    AuthController().getAccessKey().then((value) => {
          TicketController(jwtKey: value as String)
              .getAllTickets()
              .then((value) => {
                    ticketsArr.clear(),
                    ticketsArr.addAll(value),
                  }),
        });

    return ticketsArr;
  }

  void _changePassword(String value) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      // _counter++;
      _passwordController.text = value;
    });
  }

  void _changeUsername(String value) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      // _counter++;
      _usernameController.text = value;
    });
  }

  void _changePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _openAssistant() {}

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  _createTicket() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CreateTicketPage(title: "Create")),
    );
  }

  List<SolutionCard> gen_all_solution_cards_cb(
      ConnectionState connState, List<Solution> data) {
    List<SolutionCard> solutionCardList = <SolutionCard>[];
    if (data.isNotEmpty) {
      for (var solutionVal in data) {
        solutionCardList.add(SolutionCard(
          id: solutionVal.id,
          solutionName: solutionVal.solutionName,
          solutionOwner: solutionVal.solutionOwner,
        ));
        // }
      }
    }
    return solutionCardList;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int currentPageIndex = 0;
    getAllTickets().forEach((ticket) {
      tickets.add(ticket);
      setState(() {
        currentPageIndex = 1;
      });
    });

    Widget ui = TicketCardsList(
      key: "bhakhwasKey",
      filteredStatusParam: _filteredStatus,
    );
    switch (currentPageIndex) {
      case 0:
        ui = TicketCardsList(
          key: "bhakhwasKey",
          filteredStatusParam: _filteredStatus,
        );
        break;
      case 1:
        ui = SolutionCardsList(
          key: "bhakhwasKey",
        );
        break;
      case 2:
        ui = TicketCardsList(
          key: "bhakhwasKey",
          filteredStatusParam: _filteredStatus,
        );
      case 3:
        ui = TicketCardsList(
          key: "bhakhwasKey",
          filteredStatusParam: _filteredStatus,
        );
        break;
      default:
        ui = TicketCardsList(
          key: "bhakhwasKey",
          filteredStatusParam: _filteredStatus,
        );
        break;
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) appand trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          // Image.network(
          //   "https://www.floragroup.net/images/logo.png",
          //   width: width * 0.2125,
          //   height: height * 0.1225,
          // ),
          //Text(widget.title),
          TextButton.icon(
            icon: Icon(Icons.bug_report_outlined,
                color: Color.fromRGBO(111, 162, 208, 1)),
            label: Text("Issue Tracker",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: height * 0.0275,
                  // fontFamily: 'ArabDances',
                  fontFamily: 'Oswald',
                )),
            onPressed: () => {print("Issue tracker text header was clicked")},
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                // DrawerBu()
                // DrawerButton(style: ButtonStyle(),)
                IconButton(
                    onPressed: () => {
                          // o
                          // AuthController().Logout(),
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => const Login()),
                          // )
                          setState(() {
                            isDrawerOpen = !isDrawerOpen;
                          }),

                          if (isDrawerOpen == true)
                            {
                              _scaffoldKey.currentState!.closeDrawer(),
                            }
                          else if (isDrawerOpen == false)
                            {
                              _scaffoldKey.currentState!.openDrawer(),
                            }
                        },
                    icon: Icon(Icons.filter_list_alt,
                        color:
                            (isDrawerOpen) ? Colors.amber[400] : Colors.white)),
                IconButton(
                    onPressed: () => {
                          // AuthController().Logout(),
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => const Login()),
                          // )
                        },
                    icon: Icon(Icons.notifications)),
                IconButton(
                    onPressed: () => {
                          AuthController().Logout(),
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          )
                        },
                    icon: Icon(Icons.exit_to_app_rounded))
              ],
            ),
          ),
        ]),
        automaticallyImplyLeading: false,
      ),
      drawer: Drawer(
        width: width * 0.875,
        backgroundColor: Color.fromRGBO(211, 187, 255, 0.85),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Status",
                    style: TextStyle(
                        color: Colors.white, fontSize: height * 0.035),
                  ),
                  Row(
                    children: [
                      Container(
                        color: (_filteredAllStatus == true)
                            ? Color.fromRGBO(180, 41, 162, 0.847)
                            : Color.fromRGBO(216, 191, 216, 0.85),
                        padding: EdgeInsets.all(1.325),
                        margin: EdgeInsets.all(4),
                        child: TextButton.icon(
                            onPressed: () => {
                                  setState(() {
                                    _filteredAllStatus = !_filteredAllStatus;
                                    _filteredAssignedStatus = false;
                                    _filteredOpenStatus = false;
                                    _filteredSolvedStatus = false;
                                    _filteredClosedStatus = false;
                                    _filteredStatus = 0;
                                    _scaffoldKey.currentState!.closeDrawer();
                                  }),
                                },
                            icon: Icon(
                              Icons.all_inclusive_rounded,
                              color: (_filteredAllStatus == true)
                                  ? Colors.amber[400]
                                  : Colors.white,
                            ),
                            label: Text("All")),
                      ),
                      Container(
                        color: (_filteredOpenStatus == true)
                            ? Color.fromRGBO(180, 41, 162, 0.847)
                            : Color.fromRGBO(216, 191, 216, 0.85),
                        padding: EdgeInsets.all(1.325),
                        margin: EdgeInsets.all(4),
                        child: TextButton.icon(
                            onPressed: () => {
                                  setState(() {
                                    _filteredOpenStatus = !_filteredOpenStatus;
                                    _filteredWaitingForReplyStatus = false;
                                    _filteredAllStatus = false;
                                    _filteredSolvedStatus = false;
                                    _filteredClosedStatus = false;
                                    _filteredStatus = 1;
                                    _scaffoldKey.currentState!.closeDrawer();
                                  }),
                                },
                            icon: Icon(Icons.bug_report_rounded,
                                color: (_filteredOpenStatus == true)
                                    ? Colors.amber[400]
                                    : Colors.white),
                            label: Text("Open")),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        color: (_filteredAssignedStatus == true)
                            ? Color.fromRGBO(180, 41, 162, 0.847)
                            : Color.fromRGBO(216, 191, 216, 0.85),
                        padding: EdgeInsets.all(1.325),
                        margin: EdgeInsets.all(4),
                        child: TextButton.icon(
                            onPressed: () => {
                                  setState(() {
                                    _filteredAssignedStatus =
                                        !_filteredAssignedStatus;
                                    _filteredOpenStatus = false;
                                    _filteredWaitingForReplyStatus = false;
                                    _filteredAllStatus = false;
                                    _filteredSolvedStatus = false;
                                    _filteredClosedStatus = false;
                                    _filteredStatus = 2;
                                    _scaffoldKey.currentState!.closeDrawer();
                                  }),
                                },
                            icon: Icon(Icons.person_pin_rounded,
                                color: (_filteredAssignedStatus == true)
                                    ? Colors.amber[400]
                                    : Colors.white),
                            label: Text("Assigned")),
                      ),
                      Container(
                        color: (_filteredWaitingForReplyStatus == true)
                            ? Color.fromRGBO(180, 41, 162, 0.847)
                            : Color.fromRGBO(216, 191, 216, 0.85),
                        padding: EdgeInsets.all(1.325),
                        margin: EdgeInsets.all(4),
                        child: TextButton.icon(
                            onPressed: () => {
                                  setState(() {
                                    _filteredWaitingForReplyStatus =
                                        !_filteredWaitingForReplyStatus;
                                    _filteredAssignedStatus = false;
                                    _filteredOpenStatus = false;
                                    _filteredAllStatus = false;
                                    _filteredSolvedStatus = false;
                                    _filteredClosedStatus = false;
                                    _filteredStatus = 3;
                                    _scaffoldKey.currentState!.closeDrawer();
                                  }),
                                },
                            icon: Icon(Icons.reply_all_rounded,
                                color: (_filteredWaitingForReplyStatus == true)
                                    ? Colors.amber[400]
                                    : Colors.white),
                            label: Text("Waiting for reply")),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        color: (_filteredSolvedStatus == true)
                            ? Color.fromRGBO(180, 41, 162, 0.847)
                            : Color.fromRGBO(216, 191, 216, 0.85),
                        padding: EdgeInsets.all(1.325),
                        margin: EdgeInsets.all(4),
                        child: TextButton.icon(
                            onPressed: () => {
                                  setState(() {
                                    _filteredSolvedStatus =
                                        !_filteredSolvedStatus;
                                    _filteredAssignedStatus = false;
                                    _filteredOpenStatus = false;
                                    _filteredAllStatus = false;
                                    _filteredWaitingForReplyStatus = false;
                                    _filteredClosedStatus = false;
                                    _filteredStatus = 4;
                                    _scaffoldKey.currentState!.closeDrawer();
                                  }),
                                },
                            icon: Icon(Icons.verified_rounded,
                                color: (_filteredSolvedStatus == true)
                                    ? Colors.amber[400]
                                    : Colors.white),
                            label: Text("Solved")),
                      ),
                      Container(
                        color: (_filteredClosedStatus == true)
                            ? Color.fromRGBO(180, 41, 162, 0.847)
                            : Color.fromRGBO(216, 191, 216, 0.85),
                        margin: EdgeInsets.all(4),
                        padding: EdgeInsets.all(1.325),
                        child: TextButton.icon(
                            onPressed: () => {
                                  setState(() {
                                    _filteredClosedStatus =
                                        !_filteredClosedStatus;
                                    _filteredWaitingForReplyStatus = false;
                                    _filteredAssignedStatus = false;
                                    _filteredOpenStatus = false;
                                    _filteredAllStatus = false;
                                    _filteredSolvedStatus = false;
                                    _filteredStatus = 5;
                                    _scaffoldKey.currentState!.closeDrawer();
                                  }),
                                },
                            icon: Icon(Icons.closed_caption,
                                color: (_filteredClosedStatus == true)
                                    ? Colors.amber[400]
                                    : Colors.white),
                            label: Text("Closed")),
                      ),
                    ],
                  ),

                  // DropdownButton<int>(
                  //   value: _selectedStatus,
                  //   // icon: widget.getStatusIcon(),
                  //   elevation: 16,
                  //   borderRadius: BorderRadius.circular(8.0),
                  //   style: const TextStyle(color: Colors.black54),
                  //   // underline: Container(
                  //   //   margin: const EdgeInsets.all(8.25),
                  //   //   height: 1,
                  //   //   color: Colors.purple[200],
                  //   // ),
                  //   onChanged: (int? value) {
                  //     // This is called when the user selects an item.
                  //     // setState(() {
                  //     //   _selectedStatus = value!;
                  //     //   AuthController().getAccessKey().then((jwtValue) => {
                  //     //         // print(jwtValue),

                  //     //         TicketController(jwtKey: jwtValue as String)
                  //     //             .updateTicketStatus(
                  //     //                 widget.id, int.parse(value.toString()))
                  //     //             .then((value) async => {
                  //     //                   if (value! > 0)
                  //     //                     {
                  //     //                       await Future.delayed(
                  //     //                               const Duration(seconds: 3))
                  //     //                           .then((value) => {
                  //     //                                 Future.delayed(
                  //     //                                         const Duration(
                  //     //                                             seconds: 3))
                  //     //                                     .then((value) => {
                  //     //                                           ScaffoldMessenger
                  //     //                                                   .of(context)
                  //     //                                               .showMaterialBanner(
                  //     //                                             MaterialBanner(
                  //     //                                               padding: EdgeInsets
                  //     //                                                   .symmetric(
                  //     //                                                       horizontal:
                  //     //                                                           4,
                  //     //                                                       vertical:
                  //     //                                                           6),
                  //     //                                               content: Text(
                  //     //                                                 'Relevant ticket status has been updated!',
                  //     //                                                 style:
                  //     //                                                     TextStyle(
                  //     //                                                   fontSize:
                  //     //                                                       height *
                  //     //                                                           0.02,
                  //     //                                                   fontFamily:
                  //     //                                                       "Nunito",
                  //     //                                                   color: Colors
                  //     //                                                       .white,
                  //     //                                                 ),
                  //     //                                               ),
                  //     //                                               leading: Icon(
                  //     //                                                   Icons
                  //     //                                                       .refresh_rounded),
                  //     //                                               backgroundColor:
                  //     //                                                   Colors
                  //     //                                                       .deepPurple,
                  //     //                                               actions: <Widget>[
                  //     //                                                 TextButton.icon(
                  //     //                                                     icon: Icon(Icons.refresh_rounded, color: Colors.purpleAccent[200]),
                  //     //                                                     label: Text(
                  //     //                                                       'DISMISS',
                  //     //                                                       style:
                  //     //                                                           TextStyle(color: Colors.purpleAccent[200]),
                  //     //                                                     ),
                  //     //                                                     onPressed: () {
                  //     //                                                       // Navigator.push(
                  //     //                                                       //   context,
                  //     //                                                       //   MaterialPageRoute(builder: (context) => TicketCards()),
                  //     //                                                       // );
                  //     //                                                       ScaffoldMessenger.of(context)
                  //     //                                                           .hideCurrentMaterialBanner();
                  //     //                                                     }),
                  //     //                                               ],
                  //     //                                             ),
                  //     //                                           ),
                  //     //                                         }),
                  //     //                               }),
                  //     //                       // FadeOutFadeIn(
                  //     //                       //   fadingWidget:
                  //     //                       //       context.widget,
                  //     //                       //   duration: 150,
                  //     //                       // ),
                  //     //                       ScaffoldMessenger.of(context)
                  //     //                           .hideCurrentMaterialBanner(),
                  //     //                       Navigator.push(
                  //     //                         context,
                  //     //                         MaterialPageRoute(
                  //     //                             builder: (context) =>
                  //     //                                 TicketCards()),
                  //     //                       ),
                  //     //                     }
                  //     //                 }),
                  //     //       });
                  //     // });
                  //   },
                  //   items:
                  //       _statusVals.map<DropdownMenuItem<int>>((int value) {
                  //     return DropdownMenuItem<int>(
                  //       value: value,
                  //       child: Row(
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             StatusIcon()
                  //                 .getRenderedStatusIcon(value, height),
                  //             // getRenderedStatusIcon(value),
                  //             Text(
                  //               // _getWidgetStatusValKey(value),
                  //               StatusIcon().getWidgetStatusValKey(value),
                  //               style: TextStyle(
                  //                 fontFamily: 'Nunito',
                  //               ),
                  //             ),
                  //           ]),
                  //     );
                  //   }).toList(),
                  // ),
                ]),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.lightbulb_rounded),
            icon: Icon(Icons.home_outlined),
            label: 'Dashboard',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.lightbulb_rounded),
            icon: Icon(Icons.home_outlined),
            label: 'Solutions',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.support_agent_rounded)),
            label: 'Assignees',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('2'),
              child: Icon(Icons.person_add_alt_rounded),
            ),
            label: 'Assigners',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('2'),
              child: Icon(Icons.confirmation_num),
            ),
            label: 'Tickets',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page

        Container(
          child: Card(
            shadowColor: Colors.transparent,
            // margin: const EdgeInsets.all(8.0),
            child: SizedBox.expand(
              child: Center(
                child: Column(
                  children: [
                    // TicketGrid(
                    //   items: getAllTickets(),
                    // )
                    TicketCardsList(
                      key: "bhakhwasKey",
                      filteredStatusParam: _filteredStatus,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        /// Notifications page
        // const Padding(
        //   padding: EdgeInsets.all(8.0),
        //   child: Column(
        //     children: <Widget>[
        //       Card(
        //         child: ListTile(
        //           leading: Icon(Icons.notifications_sharp),
        //           title: Text('Notification 1'),
        //           subtitle: Text('This is a notification'),
        //         ),
        //       ),
        //       Card(
        //         child: ListTile(
        //           leading: Icon(Icons.notifications_sharp),
        //           title: Text('Notification 2'),
        //           subtitle: Text('This is a notification'),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),

        /// Messages page
        ListView.builder(
          reverse: true,
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(99, 102, 241, 1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Hello',
                    style: TextStyle(
                      color: Color.fromRGBO(99, 102, 241, 1),
                      fontFamily: "Nunito",
                    ),
                  ),
                ),
              );
            }
            if (index == 1) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(99, 102, 241, 1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Solutions',
                    style: TextStyle(
                      color: Color.fromRGBO(99, 102, 241, 1),
                      fontFamily: "Nunito",
                    ),
                  ),
                ),
              );
            }
            if (index == 2) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(99, 102, 241, 1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Assignees',
                    style: TextStyle(
                      color: Color.fromRGBO(99, 102, 241, 1),
                      fontFamily: "Nunito",
                    ),
                  ),
                ),
              );
            }
            if (index == 3) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(99, 102, 241, 1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text("Assigners"),
                ),
              );
            }
            if (index == 4) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(99, 102, 241, 1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text("Tickets"),
                ),
              );
            }
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(99, 102, 241, 1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Hi!',
                  style: TextStyle(
                    fontFamily: "Nunito",
                  ),
                ),
              ),
            );
          },
        ),
      ][currentPageIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: _createTicket,
        tooltip: 'Create',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
