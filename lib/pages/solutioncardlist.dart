import 'dart:convert';

import 'package:fatracker/controllers/authcontroller.dart';
import 'package:fatracker/controllers/solutioncontroller.dart';
import 'package:fatracker/controllers/ticketcontroller.dart';
import 'package:fatracker/models/solution.dart';
import 'package:fatracker/models/ticket.dart';
import 'package:fatracker/pages/home.dart';
import 'package:fatracker/pages/login.dart';
import 'package:fatracker/pages/ticket/create.dart';
import 'package:fatracker/widgets/solutioncard.dart';
import 'package:fatracker/widgets/ticketcard.dart';
import 'package:fatracker/widgets/ticketcardslist.dart';
import "package:flutter/material.dart";
import 'dart:developer' as developer;

class SolutionCards extends StatelessWidget {
  const SolutionCards({key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
      home: const SolutionCardsPage(title: 'Flora Issue Tracker'),
    );
  }
}

class SolutionCardsPage extends StatefulWidget {
  const SolutionCardsPage({key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<SolutionCardsPage> createState() => _SolutionCardsPageState();
}

class _SolutionCardsPageState extends State<SolutionCardsPage> {
  int currentPageIndex = 0;
  int _counter = 0;
  List<Solution> solutions = [];

  List<Solution> getAllSolutions_cb() {
    AuthController().getAccessKey().then((value) => {
          SolutionController(jwtKey: value as String)
              .getAllSolutions()
              .then((solutions) => {
                    solutions.addAll(solutions),
                  }),
        });
    return solutions;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllSolutions_cb();
  }

  bool _isPasswordVisible = false;
  bool _isLoggedIn = false;
  String _userName = "";
  String _passWord = "";
  // List<Ticket> tickets = [];
  String _jwtKey = "";

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

      solutions.addAll(getAllSolutions_cb());

      if (solutions.isNotEmpty) {
        // _isLoggedIn = true;
        developer.log("Found tickets for the user");
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const SolutionCardsPage(
                    title: "Tickets",
                  )),
        );
      }

      developer.log("No tickets for the user");
    });
  }

  // List<Solution> getAllSolutions() {
  //   List<Solution> solutions = [];

  //   SolutionController(jwtKey: _jwtKey).getAllSolutions().then((value) => {
  //         solutions.addAll(value),
  //       });

  //   return solutions;
  // }

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
    Widget ui;
    switch (currentPageIndex) {
      case 0:
        ui = TicketCardsList(
          key: "bhakhwasKey",
          filteredStatusParam: 0,
        );
        break;
      case 1:
        break;
      default:
    }

    return Scaffold(
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
            icon: Icon(
              Icons.bug_report_outlined,
              color: Color.fromARGB(255, 255, 115, 0),
            ),
            label: Text("Issue Tracker",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: height * 0.0275,
                  // fontFamily: 'Nunito',
                  fontFamily: 'Oswald',
                )),
            onPressed: () => {print("Issue tracker text header was clicked")},
          ),
          IconButton(
              onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    )
                  },
              icon: Icon(Icons.exit_to_app_rounded))
        ]),
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
            margin: const EdgeInsets.all(8.0),
            child: SizedBox.expand(
              child: Center(
                child: Column(children: []
                    // ],
                    // child: FutureBuilder(
                    //   initialData: getAllTickets(),
                    //   future: TicketController(jwtKey: _jwtKey).getAllTickets(),
                    //   builder: (context, snapshot) {
                    //     dynamic ui;
                    //     List<Widget> cardsList = [];
                    //     if (snapshot.connectionState == ConnectionState.done) {
                    //       if (!snapshot.hasData) {
                    //         Center(
                    //           child: Column(children: [
                    //             Text("No tickets found!, create one instead?"),
                    //             TextButton.icon(
                    //                 onPressed: () => {},
                    //                 icon: Icon(Icons.add),
                    //                 label: Text("Add ticket")),
                    //           ]),
                    //         );
                    //       }
                    //       if (snapshot.hasData &&
                    //           snapshot.connectionState != ConnectionState.waiting) {
                    //         if (snapshot.hasData) {
                    //           List<Ticket> tickets = List.empty();

                    //           if (tickets.isEmpty) {
                    //             ui = Center(
                    //               child: Column(children: [
                    //                 Text(
                    //                     "No tickets were found!, create one instead?"),
                    //                 TextButton.icon(
                    //                     onPressed: () => {
                    //                           Navigator.push(
                    //                             context,
                    //                             MaterialPageRoute(
                    //                                 builder: (context) =>
                    //                                     CreateTicketPage(
                    //                                         title: "Create")),
                    //                           )
                    //                         },
                    //                     icon: Icon(Icons.add_circle_outline_sharp),
                    //                     label: Text("Add ticket")),
                    //               ]),
                    //             );
                    //           } else if (tickets.isNotEmpty) {
                    //             tickets.addAll(Ticket.toList(snapshot.data! as List));
                    //             cardsList = gen_all_ticket_cards_cb(
                    //                 snapshot.connectionState, tickets);
                    //           }
                    //         }

                    //         // for (var ticketVal in snapshot.data!) {
                    //         //   cardsList.add(TicketCard(
                    //         //     ticket: ticketVal,
                    //         //   ));
                    //         // }
                    //       }
                    //       if (snapshot.hasError) {
                    //         ui = Center(
                    //           child: Text(
                    //               "Aw snap error!, it was us this time!${snapshot.error}"),
                    //         );
                    //       }
                    //     }

                    //     if (snapshot.connectionState == ConnectionState.waiting) {
                    //       ui = CircularProgressIndicator();
                    //     }
                    //     if (cardsList.isEmpty) {
                    //       return ui;
                    //     } else {
                    //       return Column(children: cardsList);
                    //     }
                    //   },
                    ),
              ),
            ),
          ),
        ),

        /// Notifications page
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 1'),
                  subtitle: Text('This is a notification'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 2'),
                  subtitle: Text('This is a notification'),
                ),
              ),
            ],
          ),
        ),

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
