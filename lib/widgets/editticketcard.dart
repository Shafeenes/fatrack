import 'package:camera/camera.dart';
import 'package:fatracker/controllers/authcontroller.dart';
import 'package:fatracker/controllers/branchcontroller.dart';
import 'package:fatracker/controllers/clientcontroller.dart';
import 'package:fatracker/controllers/solutioncontroller.dart';
import 'package:fatracker/controllers/ticketcontroller.dart';
import 'package:fatracker/controllers/usercontroller.dart';
import 'package:fatracker/models/ticket.dart';
import 'package:fatracker/pages/home.dart';
import 'package:fatracker/pages/ticketcardslist.dart';
import 'package:fatracker/utils/esc_html_attr.dart';
import 'package:fatracker/widgets/camera.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'dart:developer' as developer;

import 'package:flutter/widgets.dart';
// import 'package:flutter_quill/flutter_quill.dart';

class EditTicket extends StatelessWidget {
  List<String> users = ["Please select a solution", "+ Edit a solution"];
  int ticketId;
  String subject;
  String description;
  String assigner;
  String assignee;
  String project;
  int status;
  String conrtactPerName;
  String conrtactPerEmail;
  String conrtactPerMob;
  String conrtactPerTel;

  EditTicket(
      {key,
      required this.ticketId,
      required this.subject,
      required this.description,
      required this.assigner,
      required this.assignee,
      required this.project,
      required this.status,
      required this.conrtactPerName,
      required this.conrtactPerEmail,
      required this.conrtactPerMob,
      required this.conrtactPerTel});

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
      home: EditTicketPage(
        ticketId: ticketId,
        title: 'Flora Issue Tracker',
        subject: subject,
        description: description,
        assigner: assigner,
        assignee: assignee,
        project: project,
        status: status,
        conrtactPerEmail: conrtactPerEmail,
        conrtactPerMob: conrtactPerMob,
        conrtactPerName: conrtactPerName,
        conrtactPerTel: conrtactPerTel,
      ),
    );
  }
}

class EditTicketPage extends StatefulWidget {
  int ticketId;
  String subject;
  String description;
  String assigner;
  String assignee;
  String project;
  int status;
  String conrtactPerName;
  String conrtactPerEmail;
  String conrtactPerMob;
  String conrtactPerTel;
  EditTicketPage({
    super.key,
    required this.ticketId,
    required this.subject,
    required this.title,
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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<EditTicketPage> createState() => _EditTicketPageState();
}

class _EditTicketPageState extends State<EditTicketPage> {
  int _selectedStatus = 1;
  int ticketId = 0;
  int _counter = 0;
  List<DropdownMenuItem> userDropdowns = [
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
  String _selectedUser = "Please select a user";
  String _selectedClient = "Please select a client";
  String _selectedBranch = "Please select a branch";
  String _selectedSolution = "Please select a solution";
  // int _selectedStatus = 1;
  List<Ticket> tickets = [];
  String _contactPersonName = "";
  String _contactPersonMobile = "";
  String _contactPersonEmail = "";
  String _contactPersonTelephone = "";
  String _contactPersonSubject = "";
  String _contactPersonComments = "";
  TextEditingController _contactPersonCommentsController =
      TextEditingController();
  //List<String> solutions = ["Please select a solution", "+ Edit a solution"];
  //List<String> branches = ["Please select a branch", "+ Edit a branch"];
  //List<String> clients = ["Please select a client", "+ Edit a client"];
  //List<String> users = ["Please select a user", "+ Edit a user"];
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    TicketController(jwtKey: AuthController().getToken())
        .getAllTickets()
        .then((value) => {
              tickets.addAll(tickets),
            });
    _contactPersonCommentsController.text =
        EscHtmlAttr(htmlstr: widget.description).getConvertedHtml();
  }

  bool _isPasswordVisible = false;
  bool _isLoggedIn = false;
  String _userName = "";
  String _passWord = "";
  // List<Ticket> tickets = [];
  String _jwtKey = "";
  String _fileName = "No file selected";

  // Login authentication controllers
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // Ticket value controllers
  TextEditingController _solutionController = TextEditingController();
  TextEditingController _clientController = TextEditingController();
  TextEditingController _branchController = TextEditingController();
  TextEditingController _userController = TextEditingController();
  TextEditingController _contactPersonNameController = TextEditingController();
  TextEditingController _contactPersonMobileController =
      TextEditingController();
  TextEditingController _contactPersonEmailController = TextEditingController();
  TextEditingController _contactPersonTelephoneController =
      TextEditingController();
  TextEditingController _contactPersonSubjectontroller =
      TextEditingController();

  // Comment Rich text editor controller
  // QuillController _commentController = QuillController.basic();

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
              builder: (context) => EditTicket(
                    ticketId: widget.ticketId,
                    subject: widget.subject,
                    description: EscHtmlAttr(htmlstr: widget.description)
                        .getConvertedHtml(),
                    assigner: widget.assigner,
                    assignee: widget.assignee,
                    project: widget.project,
                    status: widget.status,
                    conrtactPerName: widget.conrtactPerName,
                    conrtactPerEmail: widget.conrtactPerEmail,
                    conrtactPerMob: widget.conrtactPerMob,
                    conrtactPerTel: widget.conrtactPerTel,
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

  void _changeContactPeronName(String contactPersonName) {
    _contactPersonName = _contactPersonNameController.text;
  }

  void _changeContactPeronMobile(String contactPersonMobile) {
    _contactPersonMobile = _contactPersonMobileController.text;
  }

  void _changeContactPeronEmail(String contactPersonEmail) {
    _contactPersonEmail = _contactPersonEmailController.text;
  }

  void _changeContactPeronTelephone(String contactPersonTelephone) {
    _contactPersonTelephone = _contactPersonTelephoneController.text;
  }

  void _changeTicketSubject(String contactPersonSubject) {
    _contactPersonSubject = _contactPersonSubjectontroller.text;
  }

  void _changeTicketComments(String contactPersonComments) {
    _contactPersonComments = _contactPersonCommentsController.text;
  }

  List<DropdownMenuItem> getAllSolutions() {
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
                      userDropdowns.add(DropdownMenuItem(
                        value: element.email,
                        child: Text("@${element.username}"),
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

  _updateTicket() {
    print(
        "Ticket ID : ${widget.ticketId}Column : descriptionContact person comment : ${_contactPersonCommentsController.text}");
    AuthController().getAccessKey().then((value) => {
          TicketController(jwtKey: value as String)
              .updateTicket(widget.ticketId, "description",
                  _contactPersonCommentsController.text)
              .then((value) => {
                    if (value! > 0)
                      {
                        ScaffoldMessenger.of(context).showMaterialBanner(
                          MaterialBanner(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 6),
                            content: Text(
                              'Relevant ticket description has been updated!',
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
                                fontFamily: "Nunito",
                                color: Colors.white,
                              ),
                            ),
                            leading: Icon(Icons.refresh_rounded),
                            backgroundColor: Colors.deepPurple,
                            actions: <Widget>[
                              TextButton(
                                  child: Text(
                                    'DISMISS',
                                    style: TextStyle(
                                        color: Colors.purpleAccent[200]),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TicketCards()),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentMaterialBanner();
                                  }),
                            ],
                          ),
                        ),
                      }
                  }),
        });
  }

  _createTicket() {
    AlertDialog(
        content: Column(
      children: [
        Text("User : " + _selectedUser),
        Text("Client : " + _selectedClient),
        Text("Branch : " + _selectedBranch),
        Text("Solution : " + _selectedSolution),
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

  List<int> _statusVals = [1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    String branchSelection;

    int _selectedStatus = widget!.status;
    ticketId = widget.ticketId;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    var _statusIcon = Padding(
        padding: EdgeInsets.only(top: height * 0.02),
        child: Icon(Icons.bug_report_rounded,
            color: Colors.red, size: (height * 0.135) * 0.112));

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

    Future<void> _pickFile() async {
      // final result = await FilePicker.platform.pickFiles(allowMultiple: false);
      // if (result != null) {
      //   setState(() {
      //     _fileName = result.files.first.name;
      //   });
      // }
    }

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
          Text(
            widget.title,
            style: TextStyle(fontFamily: "Nunito", fontSize: height * 0.0325),
          ),
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
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Color.fromRGBO(206, 124, 206, 0.847),
                      Color.fromRGBO(216, 191, 216, 0.85),
                      Color.fromRGBO(216, 191, 216, 0.675),
                      Color.fromRGBO(216, 191, 216, 0.425),
                      Color.fromRGBO(255, 245, 238, 0.7),
                    ],
                    // colors: [
                    //   Color.fromRGBO(99, 102, 241, 1),
                    //   Color.fromRGBO(33, 150, 243, 0),
                    // ],
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
          : Scrollable(
              viewportBuilder: (context, position) {
                // return Center(
                return Container(
                  padding: EdgeInsets.symmetric(
                      vertical: height * 0.055, horizontal: 16),
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1),
                    physics: BouncingScrollPhysics(
                        decelerationRate: ScrollDecelerationRate.normal),
                    children: [
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            width: width * 0.85,
                            decoration: BoxDecoration(
                              // color: Color.fromRGBO(99, 102, 241, 0.25),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Color.fromRGBO(99, 102, 241, 0.25),
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.035),
                            margin: EdgeInsets.only(
                                bottom: height * 0.0206985 * 0.75),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.person_3_rounded,
                                      size: height * 0.0285,
                                      color: Color.fromRGBO(99, 102, 241, 1),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: height * 0.01425),
                                      child: Text(
                                        "Assigner",
                                        style: TextStyle(
                                            fontSize: height * 0.0275,
                                            fontFamily: 'Nunito',
                                            color: Color.fromRGBO(
                                                99, 102, 241, 1)),
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.assigner,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: height * 0.02,
                                        fontFamily: 'Nunito',
                                        color: Color.fromRGBO(99, 102, 241, 1)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Container(
                          //   margin: EdgeInsets.only(
                          //       bottom: height * 0.0206985 * 0.75),
                          //   width: width * 0.85,
                          //   padding:
                          //       EdgeInsets.symmetric(horizontal: width * 0.035),
                          //   decoration: BoxDecoration(
                          //     // color: Color.fromRGBO(99, 102, 241, 0.25),
                          //     shape: BoxShape.rectangle,
                          //     border: Border.all(
                          //       color: Color.fromRGBO(99, 102, 241, 0.25),
                          //     ),
                          //     borderRadius: BorderRadius.circular(8.0),
                          //   ),
                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Row(
                          //         children: [
                          //           Icon(
                          //             Icons.groups_rounded,
                          //             size: height * 0.0285,
                          //             color: Color.fromRGBO(99, 102, 241, 1),
                          //           ),
                          //           Padding(
                          //             padding: EdgeInsets.only(
                          //                 left: height * 0.01425),
                          //             child: Text(
                          //               "Assigneee",
                          //               style: TextStyle(
                          //                   fontSize: height * 0.0275,
                          //                   fontFamily: 'Nunito',
                          //                   color: Color.fromRGBO(
                          //                       99, 102, 241, 1)),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //       Align(
                          //         alignment: Alignment.centerLeft,
                          //         child: Text(
                          //           widget.conrtactPerName,
                          //           textAlign: TextAlign.left,
                          //           style: TextStyle(
                          //               fontSize: height * 0.02,
                          //               fontFamily: 'Nunito',
                          //               color: Color.fromRGBO(99, 102, 241, 1)),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Container(
                          //   margin: EdgeInsets.only(
                          //       bottom: height * 0.0206985 * 0.75),
                          //   width: width * 0.85,
                          //   decoration: BoxDecoration(
                          //     // color: Color.fromRGBO(99, 102, 241, 0.25),
                          //     shape: BoxShape.rectangle,
                          //     border: Border.all(
                          //       color: Color.fromRGBO(99, 102, 241, 0.25),
                          //     ),
                          //     borderRadius: BorderRadius.circular(8.0),
                          //   ),
                          //   padding:
                          //       EdgeInsets.symmetric(horizontal: width * 0.022),
                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Row(
                          //         children: [
                          //           Icon(
                          //             Icons.folder_copy_rounded,
                          //             size: height * 0.0285,
                          //             color: Color.fromRGBO(99, 102, 241, 1),
                          //           ),
                          //           Padding(
                          //             padding: EdgeInsets.only(
                          //                 left: height * 0.01425),
                          //             child: Text(
                          //               "Branch",
                          //               style: TextStyle(
                          //                   fontSize: height * 0.0275,
                          //                   fontFamily: 'Nunito',
                          //                   color: Color.fromRGBO(
                          //                       99, 102, 241, 1)),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //       Align(
                          //         alignment: Alignment.centerLeft,
                          //         child: Text(
                          //           widget.project,
                          //           textAlign: TextAlign.left,
                          //           style: TextStyle(
                          //               fontSize: height * 0.02,
                          //               fontFamily: 'Nunito',
                          //               color: Color.fromRGBO(99, 102, 241, 1)),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Container(
                            margin: EdgeInsets.only(
                                bottom: height * 0.0206985 * 0.75),
                            decoration: BoxDecoration(
                              // color: Color.fromRGBO(99, 102, 241, 0.25),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Color.fromRGBO(99, 102, 241, 0.25),
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            width: width * 0.85,
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.035),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.open_in_new_rounded,
                                      size: height * 0.0285,
                                      color: Color.fromRGBO(99, 102, 241, 1),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: height * 0.01425),
                                      child: Text(
                                        "Subject",
                                        style: TextStyle(
                                            fontSize: height * 0.0275,
                                            fontFamily: 'Nunito',
                                            color: Color.fromRGBO(
                                                99, 102, 241, 1)),
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${widget.subject} #Ref ${widget.ticketId}",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: height * 0.02,
                                        fontFamily: 'Nunito',
                                        color: Color.fromRGBO(99, 102, 241, 1)),
                                  ),
                                ),
                              ],
                              // onChanged: _changeContactPeronName,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                bottom: height * 0.0206985 * 0.75),
                            width: width * 0.85,
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.035),
                            decoration: BoxDecoration(
                              // color: Color.fromRGBO(99, 102, 241, 0.25),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Color.fromRGBO(99, 102, 241, 0.25),
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: DropdownButton<int>(
                              value: _selectedStatus,
                              // icon: getStatusIcon(),
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
                                                .updateTicketStatus(
                                                    widget.ticketId,
                                                    int.parse(value.toString()))
                                                .then((value) => {
                                                      if (value! > 0)
                                                        {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showMaterialBanner(
                                                            MaterialBanner(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          4,
                                                                      vertical:
                                                                          6),
                                                              content: Text(
                                                                'Relevant ticket status has been updated!',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      height *
                                                                          0.02,
                                                                  fontFamily:
                                                                      "Nunito",
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              leading: Icon(Icons
                                                                  .refresh_rounded),
                                                              backgroundColor:
                                                                  Colors
                                                                      .deepPurple,
                                                              actions: <Widget>[
                                                                TextButton.icon(
                                                                    icon: Icon(
                                                                        Icons
                                                                            .refresh_rounded,
                                                                        color: Colors.purpleAccent[
                                                                            200]),
                                                                    label: Text(
                                                                      'DISMISS',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.purpleAccent[200]),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                TicketCards()),
                                                                      );
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .hideCurrentMaterialBanner();
                                                                    }),
                                                              ],
                                                            ),
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
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                bottom: height * 0.0206985 * 0.75),
                            width: width * 0.85,
                            decoration: BoxDecoration(
                              // color: Color.fromRGBO(99, 102, 241, 0.25),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Color.fromRGBO(99, 102, 241, 0.25),
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.035),
                            child: TextFormField(
                              readOnly: false,
                              enabled: true,
                              controller: _contactPersonCommentsController,
                              // expands: true,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.comment_rounded,
                                  size: height * 0.0285,
                                  color: Color.fromRGBO(99, 102, 241, 1),
                                ),
                                label: Text(
                                  "Description",
                                  style: TextStyle(fontFamily: "Nunito"),
                                ),
                                contentPadding: EdgeInsetsDirectional.all(12.0),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(99, 102, 241, 1),
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                // _changeTicketComments(value);
                                _contactPersonCommentsController.text = value;
                                print(
                                    "Comment : ${_contactPersonCommentsController.text}");
                              },
                            ),
                            // Column(
                            //   children: [
                            //     Expanded(
                            //       child: QuillEditor.basic(
                            //         configurations: QuillEditorConfigurations(
                            //             controller: _commentController),
                            //         // readOnly:
                            //         //     false, // Set to true for read-only mode
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // child: TextFormField(
                            //   readOnly: false,
                            //   enabled: true,
                            //   controller: _contactPersonCommentsController,
                            //   // expands: true,
                            //   keyboardType: TextInputType.multiline,
                            //   maxLines: null,
                            //   decoration: InputDecoration(
                            //     icon: Icon(
                            //       Icons.comment_rounded,
                            //       size: height * 0.0285,
                            //       color: Color.fromRGBO(99, 102, 241, 1),
                            //     ),
                            //     label: Text(
                            //       "Description",
                            //       style: TextStyle(fontFamily: "Nunito"),
                            //     ),
                            //     contentPadding: EdgeInsetsDirectional.all(12.0),
                            //     focusedBorder: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(8),
                            //       borderSide: BorderSide(
                            //         color: Color.fromRGBO(99, 102, 241, 1),
                            //       ),
                            //     ),
                            //   ),
                            //   onChanged: (value) {
                            //     // _changeTicketComments(value);
                            //     _contactPersonCommentsController.text = value;
                            //     print(
                            //         "Comment : ${_contactPersonCommentsController.text}");
                            //   },
                            // ),
                          ),
                          // Container(
                          //   margin: EdgeInsets.only(
                          //       bottom: height * 0.0206985 * 0.75),
                          //   width: width * 0.85,
                          //   decoration: BoxDecoration(
                          //     // color: Color.fromRGBO(99, 102, 241, 0.25),
                          //     shape: BoxShape.rectangle,
                          //     border: Border.all(
                          //       color: Color.fromRGBO(99, 102, 241, 0.25),
                          //     ),
                          //     borderRadius: BorderRadius.circular(8.0),
                          //   ),
                          //   padding:
                          //       EdgeInsets.symmetric(horizontal: width * 0.035),
                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: <Widget>[
                          //       Text('Selected File: $_fileName'),
                          //       TextButton(
                          //         onPressed: _pickFile,
                          //         child: Text('Select File'),
                          //       ),
                          //     ],
                          //   ),
                          // child: Uri.file(
                          //   readOnly: false,
                          //   enabled: true,
                          //   controller: _contactPersonCommentsController,
                          //   // expands: true,
                          //   keyboardType: TextInputType.multiline,
                          //   maxLines: null,
                          //   decoration: InputDecoration(
                          //     icon: Icon(
                          //       Icons.comment_rounded,
                          //       size: height * 0.0285,
                          //       color: Color.fromRGBO(99, 102, 241, 1),
                          //     ),
                          //     label: Text(
                          //       "Comments",
                          //       style: TextStyle(fontFamily: "Nunito"),
                          //     ),
                          //     contentPadding: EdgeInsetsDirectional.all(5.0),
                          //     focusedBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(8),
                          //       borderSide: BorderSide(
                          //         color: Color.fromRGBO(99, 102, 241, 1),
                          //       ),
                          //     ),
                          //   ),
                          //   onChanged: (value) {
                          //     // _changeTicketComments(value);
                          //     _contactPersonCommentsController.text = value;
                          //     print(
                          //         "Comment : ${_contactPersonCommentsController.text}");
                          //   },
                          // ),
                          // ),
                          // Container(
                          //   margin: EdgeInsets.only(
                          //       bottom: height * 0.0206985 * 0.75),
                          //   width: width * 0.85,
                          //   padding:
                          //       EdgeInsets.symmetric(horizontal: width * 0.035),
                          //   child: CameraPictureScreen(
                          //       camera: CameraDescription(
                          //           name: "Issue file",
                          //           lensDirection: CameraLensDirection.back,
                          //           sensorOrientation: 90)),
                          // ),
                        ],
                      ),
                    ],
                  ),
                );
                // );
              },
            ),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          onPressed: () {
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
                          })
                });
          },
          tooltip: 'Cancel',
          child: const Icon(Icons.home_filled),
        ),
        Padding(padding: EdgeInsets.all(8.0)),
        FloatingActionButton(
          onPressed: () {
            _updateTicket();
          },
          tooltip: 'Save',
          child: const Icon(Icons.save_rounded),
        ),
      ]),
    );
  }
}
