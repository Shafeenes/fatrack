import 'package:fatracker/controllers/authcontroller.dart';
import 'package:fatracker/controllers/branchcontroller.dart';
import 'package:fatracker/controllers/clientcontroller.dart';
import 'package:fatracker/controllers/solutioncontroller.dart';
import 'package:fatracker/controllers/ticketcontroller.dart';
import 'package:fatracker/controllers/usercontroller.dart';
import 'package:fatracker/models/ticket.dart';
import 'package:fatracker/pages/ticketcardslist.dart';
import 'package:fatracker/widgets/camera.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'dart:developer' as developer;

import 'package:flutter/widgets.dart';

class EditSolution extends StatelessWidget {
  List<String> users = ["Please select a solution", "+ Edit a solution"];
  String id;
  String solutionName;
  String solutionOwner;

  EditSolution({
    key,
    required this.id,
    required this.solutionName,
    required this.solutionOwner,
  });

  _loadAllUsers() {
    AuthController().getAccessKey().then((value) => {
          UserController(jwtKey: value as String)
              .searchUsers("a")
              .then((value) => {
                    value.forEach((element) {
                      users.add(element.name);
                    }),
                  }),
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
      home: EditSolutionPage(
        key: Key(id),
        title: solutionName,
        id: id,
        solutionName: solutionName,
        solutionOwner: solutionOwner,
      ),
    );
  }
}

class EditSolutionPage extends StatefulWidget {
  String id;
  String solutionName;
  String solutionOwner;
  EditSolutionPage({
    super.key,
    required this.id,
    required this.solutionName,
    required this.solutionOwner,
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
  State<EditSolutionPage> createState() => _EditSolutuionPageState();
}

class _EditSolutuionPageState extends State<EditSolutionPage> {
  int _counter = 0;
  List<DropdownMenuItem> ownerDropdowns = [
    DropdownMenuItem(
        value: "Please select a user", child: Text("Please select a user"))
  ];
  List<DropdownMenuItem> clientDropdowns = [
    DropdownMenuItem(
        value: "Please select a client", child: Text("Please select a client"))
  ];
  List<DropdownMenuItem> branchDropdowns = [
    DropdownMenuItem(
        value: "Please select a branch", child: Text("Please select a branch"))
  ];
  List<DropdownMenuItem> solutionDropdowns = [
    DropdownMenuItem(
        value: "Please select a solution",
        child: Text("Please select a solution"))
  ];
  String _selectedOwner = "Please select a owner";
  String _selectedClient = "Please select a client";
  String _selectedBranch = "Please select a branch";
  String _selectedSolution = "Please select a solution";
  int _selectedStatus = 1;
  List<Ticket> tickets = [];
  String _solutionName = "";
  String _solutionOwner = "";
  String _contactPersonEmail = "";
  String _contactPersonTelephone = "";
  String _contactPersonSubject = "";
  String _contactPersonComments = "";
  //List<String> solutions = ["Please select a solution", "+ Edit a solution"];
  //List<String> branches = ["Please select a branch", "+ Edit a branch"];
  //List<String> clients = ["Please select a client", "+ Edit a client"];
  //List<String> users = ["Please select a user", "+ Edit a user"];
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
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

  // Ticket value controllers
  TextEditingController _solutionController = TextEditingController();
  TextEditingController _clientController = TextEditingController();
  TextEditingController _branchController = TextEditingController();
  TextEditingController _userController = TextEditingController();
  TextEditingController _solutionNameController = TextEditingController();
  TextEditingController _contactSolutionController = TextEditingController();
  TextEditingController _contactPersonEmailController = TextEditingController();
  TextEditingController _contactPersonTelephoneController =
      TextEditingController();
  TextEditingController _contactPersonSubjectontroller =
      TextEditingController();
  TextEditingController _contactPersonCommentsController =
      TextEditingController();

  bool isAuthorized() {
    // String _jwtKey;

    // AuthController().login("", "");
    // _jwtKey = AuthController().getToken();

    // print(jsonDecode(tickets));
    _isLoggedIn = _jwtKey.isNotEmpty;
    return _isLoggedIn;
  }

  resetValues() {
    ownerDropdowns = [
      DropdownMenuItem(
          value: "Please select a user", child: Text("Please select a user"))
    ];
    clientDropdowns = [
      DropdownMenuItem(
          value: "Please select a client",
          child: Text("Please select a client"))
    ];
    branchDropdowns = [
      DropdownMenuItem(
          value: "Please select a branch",
          child: Text("Please select a branch"))
    ];
    solutionDropdowns = [
      DropdownMenuItem(
          value: "Please select a solution",
          child: Text("Please select a solution"))
    ];
  }

  List<DropdownMenuItem> getAllSolutions() {
    List<DropdownMenuItem> solutionDropDowns = [];
    AuthController().getAccessKey().then((value) => {
          SolutionController(jwtKey: value as String)
              .getAllSolutions()
              .then((value) => {
                    value.forEach((element) {
                      solutionDropDowns.add(DropdownMenuItem(
                          value: element.id,
                          child: Column(children: [
                            Text(element.solutionName),
                            Text(element.solutionOwner)
                          ])));
                    }),
                  }),
        });

    return solutionDropdowns;
  }

  List<Ticket> getAllTickets(String jwtKey) {
    List<Ticket> tickets = [];

    TicketController(jwtKey: jwtKey).getAllTickets().then((value) => {
          tickets.addAll(value),
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

      AuthController()
          .login(_usernameController.text, _passwordController.text)
          .then((value) => {
                AuthController().getAccessKey().then((value) => {
                      _jwtKey = value as String,
                    }),
              });

      tickets.addAll(getAllTickets(_jwtKey));

      if (tickets.isNotEmpty) {
        // _isLoggedIn = true;
        developer.log("Found tickets for the user");
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditSolution(
                    id: widget.id,
                    solutionName: widget.solutionName,
                    solutionOwner: widget.solutionName,
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
      _userName = _usernameController.text;
    });
  }

  void _changePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _changeSolutionName(String solutionName) {
    _solutionName = _solutionNameController.text;
  }

  void _changeSolutionOwner(String contactSolutionOwner) {
    _solutionOwner = _contactSolutionController.text;
  }

  List<DropdownMenuItem> getAllSolutionDropdowns() {
    resetValues();
    AuthController().getAccessKey().then((value) => {
          SolutionController(jwtKey: value as String)
              .getAllSolutions()
              .then((value) => {
                    value.forEach((element) {
                      solutionDropdowns.add(DropdownMenuItem(
                          value: element.id,
                          child: Text(element.solutionName)));
                    }),
                  }),
        });

    return solutionDropdowns;
  }

  List<DropdownMenuItem> getAllBranches() {
    resetValues();
    AuthController().getAccessKey().then((value) => {
          BranchController(jwtKey: value as String)
              .getAllClientBranches(int.parse(_selectedClient))
              .then((value) => {
                    value.forEach((element) {
                      branchDropdowns.add(DropdownMenuItem(
                          value: element.id, child: Text(element.branchName)));
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
                          value: element.id, child: Text(element.clientName)));
                    }),
                  }),
        });

    return clientDropdowns;
  }

  List<DropdownMenuItem> getAllUsers(String searchKey) {
    resetValues();
    AuthController().getAccessKey().then((value) => {
          UserController(jwtKey: value as String)
              .searchUsers("a")
              .then((value) => {
                    value.forEach((element) {
                      ownerDropdowns.add(DropdownMenuItem(
                        value: element.email,
                        child: Text("@${element.username}"),
                      ));
                    }),
                  }),
        });
    return ownerDropdowns;
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
  void selectOwnerValue_cb(selectedOwnerVal) {
    if (selectedOwnerVal is String) {
      setState(() {
        _selectedOwner = selectedOwnerVal;
      });
    }
  }

  _createTicket() {
    // ;
    AlertDialog(
        content: Column(
      children: [
        Text("Owner : " + _selectedOwner),
      ],
    ));
    print(
      "Selected Owner : $_selectedOwner",
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
      _selectedOwner,
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
          Image.network(
            "https://www.floragroup.net/images/logo.png",
            width: width * 0.2125,
            height: height * 0.1225,
          ),
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
                        controller: _usernameController,
                        onChanged: (value) => {
                          _userController.text = value,
                        },
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
                        controller: _passwordController,
                        onChanged: (value) => {
                          _passwordController.text = value,
                        },
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
                                      .inversePrimary),
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
                              child: DropdownButton(
                                isExpanded: true,
                                isDense: true,
                                value: _selectedOwner,
                                hint: Text("Please select a solution owner"),
                                icon: Icon(
                                  Icons.alternate_email_rounded,
                                  color: Color.fromRGBO(99, 102, 241, 1),
                                ),
                                iconSize: 40,
                                underline: Container(
                                  height: 1,
                                  color: Colors.transparent,
                                ),
                                onTap: () => {},
                                onChanged: selectOwnerValue_cb,
                                items: ownerDropdowns,
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
                              child: DropdownButton<dynamic>(
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
                                onTap: () => {
                                  getAllClients(),
                                },
                                onChanged: (val) {
                                  _selectedClient = val.toString();
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
                              child: DropdownButton<dynamic>(
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
                                onTap: () => {
                                  getAllBranches(),
                                },
                                onChanged: (val) {
                                  _selectedBranch = val.toString();
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
                              child: DropdownButton<dynamic>(
                                value: solutionDropdowns[0].value,
                                hint: Text("Please enter solution name"),
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
                                onTap: () => {
                                  getAllSolutions(),
                                },
                                onChanged: (val) {
                                  _selectedSolution = val.toString();
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
                          child: TextFormField(
                            initialValue: widget.solutionName,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.computer_rounded,
                                color: Color.fromRGBO(99, 102, 241, 1),
                              ),
                              label: Text("Solution name"),
                              contentPadding: EdgeInsetsDirectional.all(5.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(99, 102, 241, 1),
                                  // borderRadius: BorderRadius.circular(8.5)),
                                ),
                              ),
                            ),
                            onChanged: _changeSolutionName,
                          ),
                        ),

                        // Container(
                        //   margin:
                        //       EdgeInsets.only(bottom: height * 0.0206985 * 2),
                        //   width: width * 0.85,
                        //   padding:
                        //       EdgeInsets.symmetric(horizontal: width * 0.035),
                        //   child: TextButton(
                        //     child: Text('UPLOAD FILE'),
                        //     onPressed: () async {
                        //       var picked =
                        //           await FilePicker.platform.pickFiles();
                        //       if (picked != null) {
                        //         print(picked.files.first.name);
                        //       }
                        //     },
                        //   ),
                        // child: CameraPictureScreen(
                        //     camera: CameraDescription(
                        //         name: "Issue file update",
                        //         lensDirection: CameraLensDirection.back,
                        //         sensorOrientation: 90)),
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
                      .then((ticketData) => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TicketCardsPage(
                                        title: 'Home',
                                        ticketList: ticketData,
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
