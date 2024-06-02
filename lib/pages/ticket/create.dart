import 'package:camera/camera.dart';
import 'package:fatracker/controllers/authcontroller.dart';
import 'package:fatracker/controllers/branchcontroller.dart';
import 'package:fatracker/controllers/clientcontroller.dart';
import 'package:fatracker/controllers/solutioncontroller.dart';
import 'package:fatracker/controllers/ticketcontroller.dart';
import 'package:fatracker/controllers/usercontroller.dart';
import 'package:fatracker/models/ticket.dart';
import 'package:fatracker/pages/ticketcardslist.dart';
import 'package:fatracker/widgets/camera.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'dart:developer' as developer;

import 'package:flutter/widgets.dart';

class CreateTicket extends StatelessWidget {
  List<String> users = ["Please select a solution", "+ Edit a solution"];

  String title = "";

  CreateTicket({
    key,
    required title,
  });

  _loadAllUsers() {
    AuthController().getAccessKey().then((value) => {
          if (value!.isNotEmpty)
            {
              UserController(jwtKey: value).searchUsers("a").then((value) => {
                    value.forEach((element) {
                      users.add(element.name);
                    }),
                  }),
            }
        });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _loadAllUsers();
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
      home: CreateTicketPage(
        title: 'Flora Issue Tracker',
      ),
    );
  }
}

class CreateTicketPage extends StatefulWidget {
  CreateTicketPage({
    key,
    required this.title,
  });

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<CreateTicketPage> createState() => _CreateTicketPageState();
}

class _CreateTicketPageState extends State<CreateTicketPage> {
  int _counter = 0;
  List<DropdownMenuItem<DropdownMenuItem<dynamic>>> userDropdowns = [
    DropdownMenuItem(
        value: DropdownMenuItem(
            value: "Please select a user", child: Text("Please select a user")),
        child: Text("Please select a user"))
  ];
  List<DropdownMenuItem<DropdownMenuItem<dynamic>>> clientDropdowns = [
    DropdownMenuItem(
        value: DropdownMenuItem(
            value: "Please select a client",
            child: Text("Please select a client")),
        child: Text("Please select a client"))
  ];
  List<DropdownMenuItem<DropdownMenuItem<dynamic>>> branchDropdowns = [
    DropdownMenuItem(
        value: DropdownMenuItem(
            value: "Please select a branch",
            child: Text("Please select a branch")),
        child: Text("Please select a branch"))
  ];
  List<DropdownMenuItem<DropdownMenuItem<dynamic>>> solutionDropdowns = [
    DropdownMenuItem(
        value: DropdownMenuItem(
            value: "Please select a solution",
            child: Text("Please select a solution")),
        child: Text("Please select a solution"))
  ];
  DropdownMenuItem _selectedUser = DropdownMenuItem(
      value: "Please select a user", child: Text("Please select a user"));
  DropdownMenuItem _selectedClient = DropdownMenuItem(
    value: "Please select a client",
    child: Text("Please select a client"),
  );
  DropdownMenuItem _selectedBranch = DropdownMenuItem(
      value: "Please select a branch", child: Text("Please select a branch"));
  DropdownMenuItem _selectedSolution = DropdownMenuItem(
      value: "Please select a solution",
      child: Text("Please select a solution"));
  int _selectedStatus = 1;
  List<Ticket> tickets = [];
  String _contactPersonName = "";
  String _contactPersonMobile = "";
  String _contactPersonEmail = "";
  String _contactPersonTelephone = "";
  String _contactPersonSubject = "";
  String _contactPersonComments = "";

  TextEditingController _contactPersonNameController = TextEditingController();
  TextEditingController _contactPersonMobileController =
      TextEditingController();
  TextEditingController _contactPersonEmailController = TextEditingController();
  TextEditingController _contactPersonTelephoneController =
      TextEditingController();
  TextEditingController _contactPersonSubjectController =
      TextEditingController();
  TextEditingController _contactPersonCommentsController =
      TextEditingController();
  //List<String> solutions = ["Please select a solution", "+ Edit a solution"];
  //List<String> branches = ["Please select a branch", "+ Edit a branch"];
  //List<String> clients = ["Please select a client", "+ Edit a client"];
  //List<String> users = ["Please select a user", "+ Edit a user"];

  contactPersonNameEdit() {
    _contactPersonNameController.addListener(() {
      String text = _contactPersonNameController.text.toLowerCase();
      _contactPersonNameController.value =
          _contactPersonNameController.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }

  contactPersonMobileEdit() {
    _contactPersonMobileController.addListener(() {
      String text = _contactPersonMobileController.text.toLowerCase();
      _contactPersonMobileController.value =
          _contactPersonMobileController.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }

  contactPersonEmailEdit() {
    _contactPersonEmailController.addListener(() {
      String text = _contactPersonEmailController.text.toLowerCase();
      _contactPersonEmailController.value =
          _contactPersonEmailController.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }

  contactPersonTelephoneEdit() {
    _contactPersonTelephoneController.addListener(() {
      String text = _contactPersonTelephoneController.text.toLowerCase();
      _contactPersonTelephoneController.value =
          _contactPersonTelephoneController.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }

  contactPersonSubjectEdit() {
    _contactPersonSubjectController.addListener(() {
      String text = _contactPersonSubjectController.text.toLowerCase();
      _contactPersonSubjectController.value =
          _contactPersonSubjectController.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }

  contactPersonCommentsEdit() {
    _contactPersonCommentsController.addListener(() {
      String text = _contactPersonCommentsController.text.toLowerCase();
      _contactPersonCommentsController.value =
          _contactPersonCommentsController.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _contactPersonNameController.dispose();
    _contactPersonMobileController.dispose();
    _contactPersonEmailController.dispose();
    _contactPersonTelephoneController.dispose();
    super.dispose();
  }

  void _setContactPersonNameValue() {
    final text = _contactPersonNameController.text;
    print('Contact person name text field: $text (${text.characters.length})');
  }

  void _setContactPersonMobileValue() {
    final text = _contactPersonMobileController.text;
    print('Contact person mobile field: $text (${text.characters.length})');
  }

  void _setContactPersonEmailValue() {
    final text = _contactPersonEmailController.text;
    print('Contact person email field: $text (${text.characters.length})');
  }

  void _setContactPersonTelephoneValue() {
    final text = _contactPersonTelephoneController.text;
    print('Contact person telephone field: $text (${text.characters.length})');
  }

  void _setContactPersonSubjectValue() {
    final text = _contactPersonSubjectController.text;
    print('Contact person subject field: $text (${text.characters.length})');
  }

  void _setContactPersonCommentValue() {
    final text = _contactPersonCommentsController.text;
    print('Contact person comments field: $text (${text.characters.length})');
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    AuthController().getAccessKey().then((value) => {
          TicketController(jwtKey: value as String)
              .getAllTickets()
              .then((value) => {
                    tickets.addAll(tickets),
                  }),
        });

    // Start listening to changes.
    _contactPersonNameController.addListener(_setContactPersonNameValue);
    _contactPersonMobileController.addListener(_setContactPersonMobileValue);
    _contactPersonEmailController.addListener(_setContactPersonEmailValue);
    _contactPersonTelephoneController
        .addListener(_setContactPersonTelephoneValue);
  }

  bool _isPasswordVisible = false;
  bool _isLoggedIn = false;
  String _userName = "";
  String _passWord = "";
  // List<Ticket> tickets = [];
  String _jwtKey = "";

  // Login authentication controllers
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool isAuthorized() {
    // String _jwtKey;

    // AuthController().login("", "");
    // _jwtKey = AuthController().getToken();

    // print(jsonDecode(tickets));
    _isLoggedIn = _jwtKey.isNotEmpty;
    return _isLoggedIn;
  }

  resetValues() {
    userDropdowns = [
      DropdownMenuItem(
          value: DropdownMenuItem(
              value: "Please select a user",
              child: Text("Please select a user")),
          child: Text("Please select a user"))
    ];
    clientDropdowns = [
      DropdownMenuItem(
          value: DropdownMenuItem(
              value: "Please select a user",
              child: Text("Please select a user")),
          child: Text("Please select a user"))
    ];
    branchDropdowns = [
      DropdownMenuItem(
          value: DropdownMenuItem(
              value: "Please select a branch",
              child: Text("Please select a branch")),
          child: Text("Please select a branch"))
    ];
    solutionDropdowns = [
      DropdownMenuItem(
          value: DropdownMenuItem(
              value: "Please select a solution",
              child: Text("Please select a solution")),
          child: Text("Please select a solution"))
    ];
  }

  List<Ticket> getAllTickets(String jwtKey) {
    List<Ticket> tickets = [];

    AuthController().getAccessKey().then((value) => {
          TicketController(jwtKey: value as String)
              .getAllTickets()
              .then((value) => {
                    tickets.addAll(value),
                  }),
        });

    print("Found : ${tickets.length} for you!");
    return tickets;
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

      AuthController().getAccessKey().then((value) => {
            tickets.addAll(getAllTickets(value as String)),
          });

      if (tickets.isNotEmpty) {
        // _isLoggedIn = true;
        developer.log("Found tickets for the user");
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CreateTicketPage(
                    title: "",
                  )),
        );
      }

      developer.log("No tickets for the user");
    });
  }

  void _changePassword() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      // _counter++;
      _passWord = _passwordController.text;
    });
  }

  void _changeUsername() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      // _counter++;
      _userName = _usernameController.text;
    });
  }

  void _changePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _changeContactPeronName(String contactPersonName) {
    _contactPersonName = contactPersonName;
  }

  void _changeContactPeronMobile(String contactPersonMobile) {
    _contactPersonMobile = contactPersonMobile;
  }

  void _changeContactPeronEmail(String contactPersonEmail) {
    _contactPersonEmail = contactPersonEmail;
  }

  void _changeContactPeronTelephone(String contactPersonTelephone) {
    _contactPersonTelephone = contactPersonTelephone;
  }

  void _changeTicketSubject(String contactPersonSubject) {
    _contactPersonSubject = contactPersonSubject;
  }

  void _changeTicketComments(String contactPersonComments) {
    _contactPersonComments = contactPersonComments;
  }

  List<DropdownMenuItem> getAllSolutions() {
    resetValues();
    AuthController().getAccessKey().then((value) => {
          SolutionController(jwtKey: value as String)
              .getAllSolutions()
              .then((value) => {
                    value.forEach((element) {
                      solutionDropdowns.add(DropdownMenuItem(
                          value: _selectedSolution,
                          child: Text(element.solutionName)));
                    })
                  }),
        });

    return solutionDropdowns;
  }

  List<DropdownMenuItem> getAllBranches() {
    resetValues();
    AuthController().getAccessKey().then((value) => {
          BranchController(jwtKey: value as String)
              .getAllClientBranches(_selectedClient as int)
              .then((value) => {
                    value.forEach((element) {
                      branchDropdowns.add(DropdownMenuItem(
                          value: _selectedBranch,
                          child: Text(element.branchName)));
                    }),
                  }),
        });

    return branchDropdowns;
  }

  List<DropdownMenuItem> getAllClients() {
    resetValues();
    AuthController().getAccessKey().then((value) => {
          ClientController(jwtKey: value as String)
              .getAllClients()
              .then((value) => {
                    value.forEach((element) {
                      clientDropdowns.add(DropdownMenuItem(
                          value: _selectedClient,
                          child: Text(element.clientName)));
                    }),
                  }),
        });

    return clientDropdowns;
  }

  List<DropdownMenuItem> getAllUsers(String searchKey) {
    resetValues();
    AuthController().getAccessKey().then((value) => {
          UserController(jwtKey: value as String)
              .searchUsers(searchKey)
              .then((value) => {
                    value.forEach((element) {
                      userDropdowns.add(DropdownMenuItem(
                        value: _selectedUser,
                        child: Column(children: [
                          // Text(
                          //   "${element.name}",
                          //   style: TextStyle(
                          //     fontSize: 14,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          Text("@${element.username}")
                        ]),
                      ));
                    }),
                  }),
        });

    return userDropdowns;
  }

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

  _updateTicket() {}

  _createTicket() {
    AlertDialog(
        content: Column(
      children: [
        Text("User : " + _selectedUser.value),
        Text("Client : " + _selectedClient.value),
        Text("Branch : " + _selectedBranch.value),
        Text("Solution : " + _selectedSolution.value),
        Text("Subject : " + _contactPersonSubject),
        Text("Comments : " + _contactPersonComments),
      ],
    ));
    print(
      _selectedUser,
    );
    print(
      _selectedClient,
    );
    print(
      _selectedBranch,
    );
    print(
      _selectedSolution,
    );
    print(
      _selectedUser,
    );
    print(
      _contactPersonSubject,
    );
    print(
      _contactPersonComments,
    );
    print(
      _selectedStatus,
    );
  }

  @override
  Widget build(BuildContext context) {
    getAllUsers("a");
    getAllClients();
    getAllBranches();
    getAllSolutions();
    getAllClients();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String branchSelection;

    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
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
          Text(widget.title),
          TextButton.icon(
            icon: Icon(Icons.bug_report_outlined,
                color: Color.fromRGBO(111, 162, 208, 1)),
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
        ]),
      ),

      // drawer: Drawer(
      //   backgroundColor: Colors.white60,
      //   width: width * 0.66,
      // ),
      body: (_isLoggedIn)
          ? Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.

              child: Container(
                height: height * 0.85,
                width: width * 0.8,
                // color: Color.fromRGBO(99, 102, 241, 1),
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.045, vertical: height * 0.055),
                decoration: BoxDecoration(
                  // color: Color.fromRGBO(99, 102, 241, 1),

                  shape: BoxShape.rectangle,
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(16.0),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(99, 102, 241, 1),
                      Color.fromRGBO(33, 150, 243, 0),
                    ],
                    tileMode: TileMode.mirror,
                  ),
                ),
                // constraints: BoxConstraints.expand(
                //   height: height * 0.842173350,
                //   width: width * 0.3846125,
                // ),
                // Column is also a layout widget. It takes a list of children and
                // arranges them vertically. By default, it sizes itself to fit its
                // children horizontally, and tries to be as tall as its parent.
                //
                // Column has various properties to control how it sizes itself and
                // how it positions its children. Here we use mainAxisAlignment to
                // center the children vertically; the main axis here is the vertical
                // axis because Columns are vertical (the cross axis would be
                // horizontal).
                //
                // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
                // action in the IDE, or press "p" in the console), to see the
                // wireframe for each widget.
                // mainAxisAlignment: MainAxisAlignment.start,
                // linear-gradient(180deg, var(--primary-color) 10%, rgba(33, 150, 243, 0) 30%)
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(56),
                //     gradient: LinearGradient(colors: [
                //       Color.fromRGBO(99, 102, 241, 1),
                //       Color.fromRGBO(33, 150, 243, 0),
                //     ], tileMode: TileMode.mirror)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: (height * 0.021875) * 5,
                      width: (height * 0.021875) * 5,
                      margin: EdgeInsets.only(
                        bottom: (height * 0.0206985) * 0.025,
                      ),
                      child: Image.network(
                        "https://www.floragroup.net/images/logo.png",
                        width: width * 1.25,
                        height: height * 1.25,
                      ),
                    ),
                    Container(
                        height: (height * 0.021875) * 2,
                        width: (height * 0.021875) * 2,
                        margin: EdgeInsets.only(
                          bottom: (height * 0.0206985) * 1.25,
                        ),
                        child: Icon(Icons.person_2_outlined,
                            size: 45.0,
                            color: Color.fromRGBO(99, 102, 241, 1))),
                    Container(
                        margin: EdgeInsets.only(bottom: height * 0.0206985),
                        child: Text(
                          "Flora support system",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: height * 0.036222509,
                          ),
                        )),
                    Container(
                        margin: EdgeInsets.only(bottom: height * 0.0206985 * 2),
                        child: Text(
                          "Sign into continue",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: height * 0.01811125,
                          ),
                        )),
                    Container(
                      margin: EdgeInsets.only(bottom: height * 0.0206985 * 2),
                      child: TextFormField(
                        decoration: InputDecoration(
                          label: Text("Username (Domain / LDAP Username)"),
                          contentPadding: EdgeInsetsDirectional.all(5.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(99, 102, 241, 1),
                              // borderRadius: BorderRadius.circular(8.5)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: height * 0.0206985 * 2),
                      child: TextFormField(
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          suffix: IconButton(
                              onPressed: _changePasswordVisibility,
                              icon: Icon((_isPasswordVisible)
                                  ? Icons.visibility_off
                                  : Icons.visibility)),
                          label: Text("Password"),
                          contentPadding: EdgeInsetsDirectional.all(5.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(99, 102, 241, 1),
                              // borderRadius: BorderRadius.circular(8.5)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: width * 0.414125,
                      // color: Color.fromRGBO(90, 102, 241, 1),
                      decoration: BoxDecoration(
                        // color: Color.fromRGBO(99, 102, 241, 1),

                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(16.0),
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      child: TextButton.icon(
                          icon: Icon(Icons.login),
                          label: Text(
                            "SIGN IN",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          onPressed: _loginIntoTracker,
                          style: ButtonStyle(
                              // textStyle: TextStyle(),
                              backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ),
                              foregroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white))),
                    ),
                  ],
                ),
                // ),
              ),
            )
          : Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.055, horizontal: 16),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1),
                  children: [
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          width: width * 0.85,
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.035),
                          margin:
                              EdgeInsets.only(bottom: height * 0.0206985 * 2),
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton<DropdownMenuItem<dynamic>>(
                                isExpanded: true,
                                isDense: true,
                                value: _selectedUser,
                                hint: Text("Please select a user"),
                                icon: Icon(
                                  Icons.alternate_email_rounded,
                                  color: Color.fromRGBO(99, 102, 241, 1),
                                ),
                                iconSize: 40,
                                underline: Container(
                                  height: 1,
                                  color: Colors.transparent,
                                ),
                                onChanged: (val) => {
                                  print("Value : " + val!.value.toString()),
                                  setState(() => {
                                        _selectedUser = val!,
                                      }),
                                },
                                items: userDropdowns,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(bottom: height * 0.0206985 * 2),
                          width: width * 0.85,
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.035),
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton<DropdownMenuItem<dynamic>>(
                                value: _selectedClient,
                                hint: Text("Please select a client"),
                                icon: Icon(
                                  Icons.supervised_user_circle_rounded,
                                  color: Color.fromRGBO(99, 102, 241, 1),
                                ),
                                iconSize: 40,
                                underline: Container(
                                  height: 1,
                                  color: Colors.transparent,
                                ),
                                // Get and display all the clients from the controller here
                                items: clientDropdowns,
                                onChanged: (val) {
                                  _selectedClient = _selectedClient;
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(bottom: height * 0.0206985 * 2),
                          width: width * 0.85,
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.035),
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton<DropdownMenuItem<dynamic>>(
                                value: branchDropdowns[0].value,
                                hint: Text("Please select a branch"),
                                icon: Icon(
                                  Icons.alt_route_rounded,
                                  color: Color.fromRGBO(99, 102, 241, 1),
                                ),
                                iconSize: 40,
                                underline: Container(
                                  height: 1,
                                  color: Colors.transparent,
                                ),
                                // Get and display all the clients from the controller here
                                items: branchDropdowns,
                                onChanged: (val) {
                                  _selectedBranch = _selectedBranch;
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(bottom: height * 0.0206985 * 2),
                          width: width * 0.85,
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.022),
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton<DropdownMenuItem<dynamic>>(
                                value: solutionDropdowns[0].value,
                                hint: Text("Please select a solution"),
                                icon: Icon(
                                  Icons.folder_copy_rounded,
                                  color: Color.fromRGBO(99, 102, 241, 1),
                                ),
                                iconSize: 40,
                                underline: Container(
                                  height: 1,
                                  color: Colors.transparent,
                                ),
                                // Get and display all the clients from the controller here
                                items: solutionDropdowns,
                                onChanged: (val) {
                                  _selectedSolution = _selectedSolution;
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(bottom: height * 0.0206985 * 2),
                          width: width * 0.85,
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.035),
                          child: TextField(
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.contact_mail_rounded,
                                color: Color.fromRGBO(99, 102, 241, 1),
                              ),
                              label: Text("Contact person name"),
                              contentPadding: EdgeInsetsDirectional.all(5.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(99, 102, 241, 1),
                                  // borderRadius: BorderRadius.circular(8.5)),
                                ),
                              ),
                            ),
                            controller: _contactPersonNameController,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: height * 0.0206985),
                          width: width * 0.85,
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.035),
                          child: TextFormField(
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.contact_phone_rounded,
                                color: Color.fromRGBO(99, 102, 241, 1),
                              ),
                              label: Text("Contact person mobile"),
                              contentPadding: EdgeInsetsDirectional.all(5.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(99, 102, 241, 1),
                                  // borderRadius: BorderRadius.circular(8.5)),
                                ),
                              ),
                            ),
                            controller: _contactPersonMobileController,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: height * 0.0206985),
                          width: width * 0.85,
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.035),
                          child: TextFormField(
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.contact_mail_outlined,
                                color: Color.fromRGBO(99, 102, 241, 1),
                              ),
                              label: Text("Contact person email"),
                              contentPadding: EdgeInsetsDirectional.all(5.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(99, 102, 241, 1),
                                  // borderRadius: BorderRadius.circular(8.5)),
                                ),
                              ),
                            ),
                            controller: _contactPersonEmailController,
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(bottom: height * 0.0206985 * 2),
                          width: width * 0.85,
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.035),
                          child: TextFormField(
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.phone,
                                color: Color.fromRGBO(99, 102, 241, 1),
                              ),
                              label: Text("Contact person telephone no."),
                              contentPadding: EdgeInsetsDirectional.all(5.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(99, 102, 241, 1),
                                  // borderRadius: BorderRadius.circular(8.5)),
                                ),
                              ),
                            ),
                            controller: _contactPersonTelephoneController,
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(bottom: height * 0.0206985 * 2),
                          width: width * 0.85,
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.035),
                          child: TextFormField(
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.open_in_new_rounded,
                                color: Color.fromRGBO(99, 102, 241, 1),
                              ),
                              label: Text("Subject"),
                              contentPadding: EdgeInsetsDirectional.all(5.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(99, 102, 241, 1),
                                  // borderRadius: BorderRadius.circular(8.5)),
                                ),
                              ),
                            ),
                            controller: _contactPersonSubjectController,
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(bottom: height * 0.0206985 * 2),
                          width: width * 0.85,
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.035),
                          child: TextFormField(
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.comment_rounded,
                                color: Color.fromRGBO(99, 102, 241, 1),
                              ),
                              label: Text("Comments"),
                              contentPadding: EdgeInsetsDirectional.all(5.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(99, 102, 241, 1),
                                  // borderRadius: BorderRadius.circular(8.5)),
                                ),
                              ),
                            ),
                            controller: _contactPersonCommentsController,
                          ),
                        ),
                        // Container(
                        //   margin:
                        //       EdgeInsets.only(bottom: height * 0.0206985 * 2),
                        //   width: width * 0.85,
                        //   padding:
                        //       EdgeInsets.symmetric(horizontal: width * 0.035),
                        //   child: CameraPictureScreen(
                        //       camera: CameraDescription(
                        //           name: "Issue file",
                        //           lensDirection: CameraLensDirection.back,
                        //           sensorOrientation: 90)),
                        // child: (
                        //   decoration: InputDecoration(
                        //     icon: Icon(
                        //       Icons.file_copy_rounded,
                        //       color: Color.fromRGBO(99, 102, 241, 1),
                        //     ),
                        //     label: Text("Documents"),
                        //     contentPadding: EdgeInsetsDirectional.all(5.0),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //         color: Color.fromRGBO(99, 102, 241, 1),
                        //         // borderRadius: BorderRadius.circular(8.5)),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.only(bottom: height * 0.0206985 * 2),
                        //   child: Row(children: [
                        //     TextButton.icon(
                        //         onPressed: () => {},
                        //         icon: Icon(Icons.arrow_back_ios_new_rounded),
                        //         label: Text(
                        //           "Back",
                        //           style: TextStyle(
                        //             fontFamily: "Nunito",
                        //             fontWeight: FontWeight.w500,
                        //             fontSize: height * 0.002,
                        //           ),
                        //         ))
                        //   ]),
                        //   // child: TextFormField(
                        //   //   decoration: InputDecoration(
                        //   //     label: Text("Documents"),
                        //   //     contentPadding: EdgeInsetsDirectional.all(5.0),
                        //   //     focusedBorder: OutlineInputBorder(
                        //   //       borderSide: BorderSide(
                        //   //         color: Color.fromRGBO(99, 102, 241, 1),
                        //   //         // borderRadius: BorderRadius.circular(8.5)),
                        //   //       ),
                        //   //     ),
                        //   //   ),
                        //   // ++-+++++++++-------------------------
                      ],
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          onPressed: () => {
            AuthController().getAccessKey().then((value) => {
                  TicketController(jwtKey: value as String)
                      .getAllTickets()
                      .then((ticketdata) => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TicketCardsPage(
                                        title: 'Home',
                                        ticketList: ticketdata,
                                      )),
                            ),
                          }),
                }),
          },
          tooltip: 'Cancel',
          child: const Icon(Icons.home_filled),
        ),
        Padding(padding: EdgeInsets.all(8.0)),
        FloatingActionButton(
          onPressed: () => {_createTicket()},
          tooltip: 'Save',
          child: const Icon(Icons.save_rounded),
        ),
      ]), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
