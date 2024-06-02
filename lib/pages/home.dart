import 'package:fatracker/controllers/authcontroller.dart';
import 'package:fatracker/controllers/ticketcontroller.dart';
import 'package:fatracker/models/ticket.dart';
import 'package:fatracker/widgets/dashcard.dart';
import 'package:fatracker/widgets/ticketcard.dart';
import 'package:fatracker/widgets/ticket.dart';
import "package:flutter/material.dart";
import 'dart:developer' as developer;

class Home extends StatelessWidget {
  const Home({key});

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
      home: const HomePage(title: 'Flora Issue Tracker'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  List<Ticket> tickets = [];

  String getTicketListingAuthTokenTickets() {
    AuthController().getAccessKey().then((value) => {
          _jwtKey = value as String,
          TicketController(jwtKey: value).getAllTickets().then((value) => {
                tickets.addAll(tickets),
              })
        });
    print("JWT Key is : " + _jwtKey);
    return _jwtKey;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // String _key = getTicketListingAuthToken();
    getTicketListingAuthTokenTickets();
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

    // AuthController().login("", "");
    // _jwtKey = AuthController().getToken();

    // print(jsonDecode(tickets));
    _isLoggedIn = _jwtKey.isNotEmpty;
    return _isLoggedIn;
  }

  List<Ticket> getAllTickets(String jwtKey) {
    List<Ticket> tickets = [];

    String _jwtKey = "";

    AuthController().getAccessKey().then((val) => {_jwtKey = val!});

    TicketController(jwtKey: _jwtKey).getAllTickets().then((value) => {
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

      // AuthController()
      //     .login(_userName, _passWord)
      //     .then((value) => {tickets.addAll(value)});

      tickets.addAll(getAllTickets(_jwtKey));

      if (tickets.isNotEmpty) {
        // _isLoggedIn = true;
        developer.log("Found tickets for the user");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
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

    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white60,
        width: width * 0.66,
      ),
      body: (_isLoggedIn)
          ? Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.

              child: Container(
                height: height * 0.85,
                width: width * 0.8,
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.045, vertical: height * 0.055),
                decoration: BoxDecoration(
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
          : (Center(
              child: Container(
                child: Column(
                  children: [
                    // List
                  ],
                ),
              ),
            )),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
