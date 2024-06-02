import 'dart:async';
import 'dart:io';

import 'package:fatracker/controllers/authcontroller.dart';
import 'package:fatracker/controllers/geocontroller.dart';
import 'package:fatracker/controllers/ticketcontroller.dart';
import 'package:fatracker/models/geo.dart';
import 'package:fatracker/models/ticket.dart';
import 'package:fatracker/pages/login.dart';
import 'package:fatracker/pages/ticketcardslist.dart';
// import 'package:fatracker/pages/ticketcardslist.dart';
import 'package:fatracker/security/customhttp.dart';
import 'package:fatracker/security/ipverify.dart';
import 'package:fatracker/security/macverify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_android/geolocator_android.dart';
import 'package:permission_handler/permission_handler.dart';

// import 'package:geolocator/geolocator.dart';
bool isAuthed = false;
List<Ticket> tickets = [];
bool isAuthorized() {
  // AuthController().login("", "");

  AuthController().getAccessKey().then((key) => {
        isAuthed = key!.isNotEmpty,
        if (isAuthed)
          {
            TicketController(jwtKey: key as String)
                .getAllTickets()
                .then((ticketdata) => {
                      tickets.addAll(ticketdata),
                    }),
          }
      });

  return isAuthed;
}

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  isAuthorized();
  HttpOverrides.global = new CustomHttpOverrides();
  runApp(MyApp());
  Timer.periodic(const Duration(seconds: 150), locationUpdate_cb);
  FlutterNativeSplash.remove();
}

Future<Position> getCurrentLocation() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best, timeLimit: Duration(seconds: 30));
  return position;
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

class MyApp extends StatelessWidget {
  final ColorScheme colorScheme = const ColorScheme(
    primary: Color.fromRGBO(99, 102, 241, 1),
    secondary: Color(0xFFEFF3F3),
    background: Color(0xFF636363),
    surface: Color(0xFF808080),
    onBackground: Colors.white,
    error: Colors.redAccent,
    onError: Colors.redAccent,
    onPrimary: Colors.redAccent,
    onSecondary: Color(0xFF322942),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );

  MyApp({key});

  bool isAuthorized() {
    // AuthController().login("", "");

    AuthController().getAccessKey().then((key) => {
          isAuthed = key!.isNotEmpty,
          if (isAuthed)
            {
              TicketController(jwtKey: key as String)
                  .getAllTickets()
                  .then((ticketdata) => {
                        tickets.addAll(ticketdata),
                      }),
            }
        });

    return isAuthed;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    isAuthorized();
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
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
        colorScheme: ColorScheme.fromSeed(seedColor: colorScheme.primary),
        useMaterial3: true,
      ),
      home: (isAuthed)
          ? TicketCardsPage(title: "", ticketList: tickets)
          : LoginPage(
              key: "bakhwaskey", icon: const Icon(Icons.login), title: "Login"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

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
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        // Disable back navigation
        automaticallyImplyLeading: false,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
