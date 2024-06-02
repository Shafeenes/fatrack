import "dart:async";
import "dart:convert";
import 'dart:developer' as developer;

import "package:fatracker/controllers/authcontroller.dart";
import "package:fatracker/controllers/geocontroller.dart";
import "package:fatracker/controllers/ticketcontroller.dart";
import "package:fatracker/main.dart";
import "package:fatracker/models/geo.dart";
import "package:fatracker/models/ticket.dart";
import "package:fatracker/pages/solutioncardlist.dart";
import "package:fatracker/pages/ticketcardslist.dart";
import "package:fatracker/security/ipverify.dart";
import "package:fatracker/security/macverify.dart";
import "package:flutter/material.dart";
import "package:flutter_native_splash/flutter_native_splash.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:geolocator_android/geolocator_android.dart";
import "package:permission_handler/permission_handler.dart";

class Login extends StatelessWidget {
  const Login({key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        
      ),
      home: LoginPage(
        title: "Flora Issue Tracker",
        icon: Icon(Icons.location_off),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({key, required this.icon, required this.title});

  final String title;

  Icon icon;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  bool _isLoggedIn = false;
  String _userName = "";
  String _passWordVal = "";
  List<Ticket> tickets = [];
  String _jwtKey = "";
  List<Widget> ticketCards = [];

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initialization();
  
  }

  void initialization() async {
  
    await Future.delayed(const Duration(seconds: 3));
    // print('go!');
    FlutterNativeSplash.remove();

    AuthController().getAccessKey().then((value) => {
          if (value!.isNotEmpty)
            {
              TicketController(jwtKey: value as String)
                  .getAllTickets()
                  .then((tickets) => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TicketCardsPage(
                                    title: "Tickets",
                                    ticketList: tickets,
                                  )),
                        ),
                      }),
            }
        });
  }

  bool isAuthorized() {
    // String _jwtKey;

    AuthController().login(_userName, _passWordVal).then((value) => {
          print(value),
          _jwtKey = value as String,
        });

    _isLoggedIn = _jwtKey.isNotEmpty;
    return _isLoggedIn;
  }

  List<Ticket> getAllTickets(String jwtKey) {
    List<Ticket> tickets = [];

    AuthController().getAccessKey().then((value) => {
          TicketController(jwtKey: value as String)
              .getAllTickets()
              .then((value) => {
                    print(value),
                    tickets.addAll(value),
                  }),
        });

    print("Found : ${tickets.length} for you!");
    return tickets;
  }

  _gotoTicketCardsPage_cb() {
    AuthController().getAccessKey().then((value) => {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TicketCardsPage(
                      title: "Tickets",
                      ticketList: getAllTickets(value as String),
                    )),
          ),
        });
  }

  void _loginIntoTracker() async {
    final storage = new FlutterSecureStorage();

    developer.log("Logging in!");

    AuthController().login(_userName, _passWordVal).then(
          (value) => {
            // AuthController().getAccessKey().then((value) => {
            print(value),
            if (value.isNotEmpty)
              {
                _gotoTicketCardsPage_cb(),
                // authCallback(value, tickets),
                // print(tickets),
              }
            else if (value.isEmpty)
              {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Center(child: Text('Alert')),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              child: TextButton.icon(
                                label: Text(
                                    "Contact support or please check your network \n information and login credentials!"),
                                icon: Icon(Icons.support_agent_rounded),
                                onPressed: () => {},
                              ),
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  TextButton.icon(
                                      icon: Icon(Icons
                                          .no_encryption_gmailerrorred_sharp),
                                      label: Text("Try again"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      }),
                                ])
                          ],
                        ),
                      );
                    })
              }
            // }),
          },
        );
  }

  authCallback(String value, List<Ticket> ticketsarr) {
    bool verified = value.isNotEmpty;
    bool hasData = ticketsarr.length > 0;
    Future<dynamic> element = Future<dynamic>(() => {});
    if (hasData && verified) {
      AuthController().getAccessKey().then((value) => {
            TicketController(jwtKey: value as String)
                .getAllTickets()
                .then((ticketdata) => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TicketCardsPage(
                                title: "Tickets", ticketList: ticketdata)),
                      ),
                    }),
          });
    }
  }

  _changePassword(String passWord) {
    setState(() {

      _passWordVal = passWord;
    });
  }

  void _changeUsername(String userName) {
    setState(() {
   
      _userName = userName;
    });
  }

  void _changePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _openAssistant() {}

  bool isLoggedinState() {
    bool isLoggedIn = false;
    AuthController().getAccessKey().then((value) => {
          isLoggedIn = value!.isNotEmpty,
        });
    return isLoggedIn;
  }

  _renderTickets() {
    AuthController().getAccessKey().then((value) => {
          TicketController(jwtKey: value as String).getAllTickets().then(
                (tickets) => {
                  authCallback(value as String, tickets),
                },
              ),
        });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    List<Ticket> tickets = [];

    dynamic ui = (_isLoggedIn)
        ? _renderTickets
        : Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              // TRY THIS: Try changing the color here to a specific color (to
              // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
              // change color while the other colors stay the same.
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Issue Tracker",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: height * 0.0325,
                          // fontFamily: 'ArabDances',
                          fontFamily: 'Oswald',
                        )),
                    // ),
                  ]),
              automaticallyImplyLeading: false,
            ),
            body: Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.

              child: Container(
                // height: height * 0.85,
                // width: width * 0.8,
                // margin: EdgeInsets.all(5.0),
                // color: Color.fromRGBO(99, 102, 241, 1),
                // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                decoration: BoxDecoration(
                  // color: Color.fromRGBO(99, 102, 241, 1),

                  shape: BoxShape.rectangle,
                  // border: Border.all(color: Colors.transparent),
                  // borderRadius: BorderRadius.circular(16.0),
                  gradient: LinearGradient(
                    end: Alignment.topCenter,
                    begin: Alignment.bottomCenter,
                    // colors: [
                    //   Color.fromRGBO(128, 0, 0, 1),
                    //   Color.fromRGBO(128, 0, 0, 0.66),
                    //   Color.fromRGBO(179, 154, 17, 1),
                    //   Color.fromRGBO(255, 215, 0, 1),
                    //   Color.fromRGBO(255, 217, 0, 0.281),
                    // ],
                    // colors: <Color>[
                    //   Color.fromRGBO(216, 191, 216, 0.85),
                    //   Color.fromRGBO(216, 191, 216, 0.675),
                    //   Color.fromRGBO(216, 191, 216, 0.425),
                    //   Color.fromRGBO(255, 245, 238, 0.7),
                    // ],
                    // linear-gradient(90deg, rgba(58,180,175,1) 0%, rgba(69,180,252,1) 48%);
                    colors: <Color>[
                       Colors.white,
                      // Color.fromARGB(150, 109, 137, 151),
                      //back to orginal color
                      Colors.white,
                      Colors.white,
                    ],
                    tileMode: TileMode.mirror,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      height: (height * 0.021875) * 5,
                      width: (height * 0.021875) * 5,
                      // margin: EdgeInsets.only(
                      //   bottom: (height * 0.0206985) * 0.025,
                      // ),
                      child: Image.network(
                        "https://www.floragroup.net/images/logo.png",
                        width: width * 1.215,
                        height: height * 1.215,
                      ),
                    ),
                    // Container(
                    //     height: (height * 0.021875) * 2,
                    //     width: (height * 0.021875) * 2,
                    //     margin: EdgeInsets.only(
                    //       bottom: (height * 0.0206985) * 1.25,
                    //     ),
                    //     child: Icon(Icons.person_2_outlined,
                    //         size: 45.0, color: Color.fromRGBO(99, 102, 241, 1))),
                    Container(
                        // margin: EdgeInsets.only(bottom: height * 0.0206985),
                        child: Text(
                      "Flora Support System",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: height * 0.0425,
                        color: const Color.fromARGB(255, 255, 179, 0),
                        // fontFamily: 'OpenSans',
                        fontFamily: 'Oswald',
                      ),
                    )),
                    Container(
                      // margin: EdgeInsets.only(bottom: height * 0.0206985 * 2),
                      margin: EdgeInsets.all(8.0),
                      child: TextFormField(
                        // resizeToAvoidBottomInset: false,
                        decoration: InputDecoration(
                             label: Text(
                            "Enter username ",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 255, 179, 0),
                            ),
                            
                          ),
                                prefixIcon: const Icon(Icons.person),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                       
                          // contentPadding: EdgeInsetsDirectional.all(5.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2.25,
                              color: const Color.fromARGB(255, 255, 179, 0),
                            ),
                            
                          ),
                        ),
                        onChanged: (value) => {
                          _userName = value,
                        },
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.only(bottom: height * 0.0206985 * 2),
                      // height: height * 0.0206985 * 2,
                      margin: EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(
                            color: const Color.fromARGB(255, 255, 179, 0)),
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          suffix: IconButton(
                            onPressed: _changePasswordVisibility,
                            icon: Icon(
                                (_isPasswordVisible)
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: const Color.fromARGB(255, 255, 179, 0)),
                          ),
                          label: const Text(
                            "Enter password",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 255, 179, 0)),
                          ),
                              prefixIcon: const Icon(Icons.person),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                          contentPadding: EdgeInsetsDirectional.all(5.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.25,
                                color: const Color.fromARGB(255, 255, 179, 0)
                                // borderRadius: BorderRadius.circular(8.5)),
                                ),
                          ),
                        ),
                        onChanged: (value) => {
                          _passWordVal = value,
                        },
                      ),
                    ),
                    Container(
                      width: width * 0.414125,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(16.0),
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      child: TextButton.icon(
                          // clipBehavior: Clip.hardEdge,
                          icon: Icon(
                            Icons.login,
                            color: Colors.white,
                          ),
                          label: Text(
                            "SIGN IN",
                            style: TextStyle(
                              color: Colors.white,
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
            ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: _openAssistant,
            //   tooltip: 'Get help',
            //   child: const Icon(Icons.assistant),
            // ),
          );

    return ui;

    // return Scaffold(
    //   resizeToAvoidBottomInset: true,
    //   appBar: AppBar(
    //     // TRY THIS: Try changing the color here to a specific color (to
    //     // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
    //     // change color while the other colors stay the same.
    //     backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    //     // Here we take the value from the MyHomePage object that was created by
    //     // the App.build method, and use it to set our appbar title.
    //     title:
    //         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    //       Text("Issue Tracker",
    //           style: TextStyle(
    //             color: Colors.white,
    //             fontWeight: FontWeight.w500,
    //             fontSize: height * 0.0325,
    //             // fontFamily: 'ArabDances',
    //             fontFamily: 'Oswald',
    //           )),
    //       // ),
    //     ]),
    //     automaticallyImplyLeading: false,
    //   ),
    //   body: Center(
    //     // Center is a layout widget. It takes a single child and positions it
    //     // in the middle of the parent.

    //     child: Container(
    //       // height: height * 0.85,
    //       // width: width * 0.8,
    //       // margin: EdgeInsets.all(5.0),
    //       // color: Color.fromRGBO(99, 102, 241, 1),
    //       // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
    //       decoration: BoxDecoration(
    //         // color: Color.fromRGBO(99, 102, 241, 1),

    //         shape: BoxShape.rectangle,
    //         // border: Border.all(color: Colors.transparent),
    //         // borderRadius: BorderRadius.circular(16.0),
    //         gradient: LinearGradient(
    //           end: Alignment.topCenter,
    //           begin: Alignment.bottomCenter,
    //           // colors: [
    //           //   Color.fromRGBO(128, 0, 0, 1),
    //           //   Color.fromRGBO(128, 0, 0, 0.66),
    //           //   Color.fromRGBO(179, 154, 17, 1),
    //           //   Color.fromRGBO(255, 215, 0, 1),
    //           //   Color.fromRGBO(255, 217, 0, 0.281),
    //           // ],
    //           // colors: <Color>[
    //           //   Color.fromRGBO(216, 191, 216, 0.85),
    //           //   Color.fromRGBO(216, 191, 216, 0.675),
    //           //   Color.fromRGBO(216, 191, 216, 0.425),
    //           //   Color.fromRGBO(255, 245, 238, 0.7),
    //           // ],
    //           colors: <Color>[
    //             Color.fromRGBO(206, 124, 206, 0.847),
    //             Color.fromRGBO(216, 191, 216, 0.85),
    //             Color.fromRGBO(216, 191, 216, 0.675),
    //             Color.fromRGBO(216, 191, 216, 0.425),
    //             Color.fromRGBO(255, 245, 238, 0.7)
    //           ],
    //           tileMode: TileMode.mirror,
    //         ),
    //       ),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
    //         children: <Widget>[
    //           Container(
    //             height: (height * 0.021875) * 5,
    //             width: (height * 0.021875) * 5,
    //             // margin: EdgeInsets.only(
    //             //   bottom: (height * 0.0206985) * 0.025,
    //             // ),
    //             child: Image.network(
    //               "https://www.floragroup.net/images/logo.png",
    //               width: width * 1.025,
    //               height: height * 1.025,
    //             ),
    //           ),
    //           // Container(
    //           //     height: (height * 0.021875) * 2,
    //           //     width: (height * 0.021875) * 2,
    //           //     margin: EdgeInsets.only(
    //           //       bottom: (height * 0.0206985) * 1.25,
    //           //     ),
    //           //     child: Icon(Icons.person_2_outlined,
    //           //         size: 45.0, color: Color.fromRGBO(99, 102, 241, 1))),
    //           Container(
    //               // margin: EdgeInsets.only(bottom: height * 0.0206985),
    //               child: Text(
    //             "Flora support system",
    //             textAlign: TextAlign.center,
    //             style: TextStyle(
    //               fontWeight: FontWeight.w500,
    //               fontSize: height * 0.036222509,
    //               color: const Color.fromARGB(255, 255, 179, 0),
    //               // fontFamily: 'OpenSans',
    //               fontFamily: 'Oswald',
    //             ),
    //           )),
    //           Container(
    //             // margin: EdgeInsets.only(bottom: height * 0.0206985 * 2),
    //             margin: EdgeInsets.all(8.0),
    //             child: TextFormField(
    //               // resizeToAvoidBottomInset: false,
    //               decoration: InputDecoration(
    //                 label: Text(
    //                   "Username ",
    //                   style: TextStyle(
    //                     color: const Color.fromARGB(255, 255, 179, 0),
    //                   ),
    //                 ),
    //                 // contentPadding: EdgeInsetsDirectional.all(5.0),
    //                 focusedBorder: OutlineInputBorder(
    //                   borderSide: BorderSide(
    //                     width: 2.25,
    //                     color: const Color.fromARGB(255, 255, 179, 0),
    //                   ),
    //                 ),
    //               ),
    //               onChanged: (value) => {
    //                 _userName = value,
    //               },
    //             ),
    //           ),
    //           Container(
    //             // margin: EdgeInsets.only(bottom: height * 0.0206985 * 2),
    //             // height: height * 0.0206985 * 2,
    //             margin: EdgeInsets.all(8.0),
    //             child: TextFormField(
    //               style:
    //                   TextStyle(color: const Color.fromARGB(255, 255, 179, 0)),
    //               obscureText: !_isPasswordVisible,
    //               decoration: InputDecoration(
    //                 suffix: IconButton(
    //                   onPressed: _changePasswordVisibility,
    //                   icon: Icon(
    //                       (_isPasswordVisible)
    //                           ? Icons.visibility_off
    //                           : Icons.visibility,
    //                       color: const Color.fromARGB(255, 255, 179, 0)),
    //                 ),
    //                 label: Text(
    //                   "Password",
    //                   style: TextStyle(
    //                       color: const Color.fromARGB(255, 255, 179, 0)),
    //                 ),
    //                 contentPadding: EdgeInsetsDirectional.all(5.0),
    //                 focusedBorder: OutlineInputBorder(
    //                   borderSide: BorderSide(
    //                       width: 2.25,
    //                       color: const Color.fromARGB(255, 255, 179, 0)
    //                       // borderRadius: BorderRadius.circular(8.5)),
    //                       ),
    //                 ),
    //               ),
    //               onChanged: (value) => {
    //                 _passWordVal = value,
    //               },
    //             ),
    //           ),
    //           Container(
    //             width: width * 0.414125,
    //             decoration: BoxDecoration(
    //               shape: BoxShape.rectangle,
    //               border: Border.all(color: Colors.transparent),
    //               borderRadius: BorderRadius.circular(16.0),
    //               color: Theme.of(context).colorScheme.inversePrimary,
    //             ),
    //             child: TextButton.icon(
    //                 // clipBehavior: Clip.hardEdge,
    //                 icon: Icon(
    //                   Icons.login,
    //                   color: Colors.white,
    //                 ),
    //                 label: Text(
    //                   "SIGN IN",
    //                   style: TextStyle(
    //                     color: Colors.white,
    //                     fontWeight: FontWeight.w700,
    //                   ),
    //                 ),
    //                 onPressed: _loginIntoTracker,
    //                 style: ButtonStyle(
    //                     // textStyle: TextStyle(),
    //                     backgroundColor: MaterialStateColor.resolveWith(
    //                       (states) =>
    //                           Theme.of(context).colorScheme.inversePrimary,
    //                     ),
    //                     foregroundColor: MaterialStateColor.resolveWith(
    //                         (states) => Colors.white))),
    //           ),
    //         ],
    //       ),
    //       // ),
    //     ),
    //   ),
    //   // floatingActionButton: FloatingActionButton(
    //   //   onPressed: _openAssistant,
    //   //   tooltip: 'Get help',
    //   //   child: const Icon(Icons.assistant),
    //   // ),
    // );
  }
}
