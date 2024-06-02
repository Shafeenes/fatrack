// import 'package:flutter/material.dart';

// import 'package:fatracker/models/ticket.dart';

// class TicketCard extends StatefulWidget {
//   // Ticket ticket;
//   String header;
//   String countText;
//   String count;
//   String statusCountText;
//   String statusCount;
//   TicketCard(
//       {super.key,
//       required this.header,
//       required this.countText,
//       required this.count,
//       required this.statusCountText,
//       required this.statusCount});

//   @override
//   State<TicketCard> createState() => _TicketCardState();
// }

// class _TicketCardState extends State<TicketCard> {
//   Widget build(BuildContext context) {
//     return Center(
//       child: Card(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             const ListTile(
//               leading: Icon(Icons.album),
//               title: Text('The Enchanted Nightingale'),
//               subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: <Widget>[
//                 TextButton(
//                   child: const Text('BUY TICKETS'),
//                   onPressed: () {/* ... */},
//                 ),
//                 const SizedBox(width: 8),
//                 TextButton(
//                   child: const Text('LISTEN'),
//                   onPressed: () {/* ... */},
//                 ),
//                 const SizedBox(width: 8),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   // @override
//   // Widget build(BuildContext context) {
//   //   double width = MediaQuery.of(context).size.width;
//   //   double height = MediaQuery.of(context).size.height;
//   //   return SizedBox.expand(
//   //     // width: width - 12,
//   //     // height: height * 0.055,
//   //     // color: Color.fromRGBO(64, 65, 109, 0.894),
//   //     child: Column(
//   //       children: [
//   //         Row(
//   //           children: [Text(widget.header)],
//   //         ),
//   //         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//   //           // Ticket count for indivisual/all will be here
//   //           Text(widget.count),
//   //           Icon(Icons.tag),
//   //         ]),
//   //         //This is for the count of open/completed tickets count
//   //         Text("${widget.statusCount} Open tickets"),
//   //       ],
//   //     ),
//   //   );
//   // }
// }
