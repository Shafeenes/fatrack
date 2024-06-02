import 'package:fatracker/controllers/authcontroller.dart';
import 'package:fatracker/controllers/ticketcontroller.dart';
import 'package:fatracker/models/ticket.dart';
import 'package:fatracker/widgets/ticketcard.dart';
import 'package:flutter/material.dart';

class TicketSilverList extends StatefulWidget {
  final List<Ticket> items; // Replace with your data type

  const TicketSilverList({Key? key, required this.items}) : super(key: key);

  @override
  State<TicketSilverList> createState() => _TicketSilverGridState();
}

class _TicketSilverGridState extends State<TicketSilverList> {
  Future<void> _refreshData() async {
    // Fetch new data (replace with your data fetching logic)
    String _key = "";

    AuthController().getAccessKey().then((value) => {
          _key = value as String,
        });

    setState(() {
      // Update data source
      TicketController(jwtKey: _key).getAllTickets().then((value) => {
            widget.items.addAll(value),
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      // ... your grid configuration
      delegate: SliverChildBuilderDelegate(
        (context, index) => TicketCard(
            id: widget.items[index].id,
            subject: widget.items[index].subject,
            description: widget.items[index].description,
            assigner: widget.items[index].createdBy,
            assignee: widget.items[index].currentAssignee.assigneeName,
            project: widget.items[index].solution.solutionName,
            status: widget.items[index].status,
            conrtactPerName: widget.items[index].contactPerName,
            conrtactPerEmail: widget.items[index].contactPerEmail,
            conrtactPerMob: widget.items[index].contactPerMobile,
            conrtactPerTel: widget.items[index].contactPerPhone),
        childCount: widget.items.length,
      ),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
    );
  }
}
