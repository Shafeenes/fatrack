// import "package:fatracker/models/ticket.dart";
// import "package:fatracker/widgets/fapen.dart";
// import "package:flutter/material.dart";
// import "package:flutter/services.dart";
// import "package:flutter/widgets.dart";

// class Single extends StatelessWidget {
//   Single({super.key, required this.ticket});

//   Ticket ticket;

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: SinglePage(title: 'Flutter Demo Home Page', ticket: ticket),
//     );
//   }
// }

// class SinglePage extends StatefulWidget {
//   SinglePage({super.key, required this.title, required this.ticket});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   Ticket ticket;

//   @override
//   State<SinglePage> createState() => _SinglePageState();
// }

// class _SinglePageState extends State<SinglePage> {
//   int _counter = 0;
//   TextEditingController _usernameController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   void _updateTicketController() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   void _mailTicketController() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   void _changeTicketTitle() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   void _changeTicketCC() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   void _changeTicketDescription() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   void _changeTicketStatus() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   void _openAssistant() {}

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.

//     String _getPriorityText(int status) {
//       String statusTxt = "";

//       switch (status) {
//         case 0:
//           statusTxt = "Low";
//           break;
//         case 1:
//           statusTxt = "Medium";
//           break;
//         case 2:
//           statusTxt = "High";
//           break;
//         case 3:
//           statusTxt = "Deadline";
//           break;
//         case 4:
//           statusTxt = "Feedback";
//           break;
//         case 5:
//           statusTxt = "Support";
//           break;
//         case 6:
//           statusTxt = "New client";
//           break;
//         case 7:
//           statusTxt = "Severe";
//           break;
//         default:
//           statusTxt = "Not set";
//           break;
//       }

//       return statusTxt;
//     }

//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         widthFactor: width - 13,
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             Column(
//               children: [
//                 //Title
//                 Text(widget.ticket.title),
//                 //Description
//                 Text(widget.ticket.name),
//                 //Priority based icon button
//                 TextButton.icon(
//                     onPressed: () => {},
//                     icon: Icon(Icons.arrow_downward_rounded),
//                     label: Text(_getPriorityText(widget.ticket.priority))),
//                 // Assignee icon button & assigned by icon button
//                 Row(children: [
//                   TextButton.icon(
//                       onPressed: () => {},
//                       icon: Icon(Icons.arrow_downward_rounded),
//                       label: Text(widget.ticket.assigneedId)),
//                   TextButton.icon(
//                       onPressed: () => {},
//                       icon: Icon(Icons.arrow_downward_rounded),
//                       label: Text(widget.ticket.assigneedId))
//                 ]),
//                 //Project progress bar
//                 LinearProgressIndicator(
//                   value: 0.67,
//                 ),
//                 //Task progress bar
//                 LinearProgressIndicator(
//                   value: 0.35,
//                 ),
//                 //Deadline & available working hours row
//                 Row(children: [
//                   Column(children: [
//                     Text(
//                       "Deadline",
//                       style: TextStyle(decoration: TextDecoration.underline),
//                     ),
//                     Text(
//                       widget.ticket.deadline,
//                       style: TextStyle(decoration: TextDecoration.underline),
//                     ),
//                     Column(children: [
//                       Text(
//                         "Available time",
//                         style: TextStyle(decoration: TextDecoration.underline),
//                       ),
//                       Text(
//                         widget.ticket.requestedWorkingHours.toString(),
//                         style: TextStyle(decoration: TextDecoration.underline),
//                       )
//                     ])
//                   ]),
//                   Row(children: [
//                     TextButton.icon(
//                         onPressed: () => {},
//                         icon: Icon(Icons.email_rounded),
//                         label: Text("Mail")),
//                     TextButton.icon(
//                         onPressed: () => {},
//                         icon: Icon(Icons.edit_rounded),
//                         label: Text("Update"))
//                   ])
//                 ])
//               ],
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _openAssistant,
//         tooltip: 'Get help',
//         child: const Icon(Icons.assistant),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
