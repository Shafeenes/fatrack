// import "package:fatracker/controllers/ticketcontroller.dart";
// import "package:fatracker/models/ticket.dart";
// import "package:fatracker/widgets/fapen.dart";
// import "package:fatracker/widgets/ticket.dart";
// import "package:flutter/material.dart";
// import "package:flutter/services.dart";
// import "package:flutter/widgets.dart";
// import "package:fatracker/constant/api_consts.dart";

// class CardList extends StatelessWidget {
//   const CardList({super.key});

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
//       home: CardListPage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class CardListPage extends StatefulWidget {
//   String title = '';
//   List<Ticket> tickets = [];
//   CardListPage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   @override
//   State<CardListPage> createState() => _CardListPageState();
// }

// class _CardListPageState extends State<CardListPage> {
//   List<Ticket> _tickets = [];
//   TextEditingController _usernameController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   void _loadAllTickets() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _tickets without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       var ticketList = TicketController().getAllTickets();
//       _tickets.addAll(ticketList);
//     });
//   }

//   void _viewTicket() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//     });
//   }

//   void _openAssistant() {}

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;

//     List<Ticket> _tickets = [];
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
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
//         child: ListView.builder(
//           itemCount: _tickets.length,
//           scrollDirection: Axis.horizontal,
//           shrinkWrap: true,
//           itemBuilder: (context, index) => TicketCard(
//               key: Key(_tickets[index].Id.toString()), ticket: _tickets[index]),
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
