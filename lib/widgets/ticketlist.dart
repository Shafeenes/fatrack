import 'package:fatracker/controllers/authcontroller.dart';
import 'package:fatracker/controllers/ticketcontroller.dart';
import 'package:fatracker/models/ticket.dart';
import 'package:fatracker/widgets/ticketcard.dart';
import 'package:flutter/material.dart';

class TicketListPage extends StatefulWidget {
  final List<Ticket> items; // Replace with your data type

  const TicketListPage({Key? key, required this.items}) : super(key: key);

  @override
  State<TicketListPage> createState() => _TicketListPageState();
}

class _TicketListPageState extends State<TicketListPage> {
  Future<void> _refreshData() async {
    // Fetch new data (replace with your data fetching logic)
    // await Future.delayed(const Duration(seconds: 2)); // Simulate fetching

    setState(() {
      // Update data source
      loadTickets();
    });
  }

  loadTickets() {
    // String _key = "";
    AuthController().getAccessKey().then((value) => {
          TicketController(jwtKey: value as String)
              .getAllTickets()
              .then((value) => {
                    widget.items.addAll(value),
                  }),
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadTickets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pull to Refresh'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView.builder(
          itemCount: widget.items.length,
          itemBuilder: (context, index) => TicketCard(
              id: widget.items[index].id,
              subject: widget.items[index].subject,
              description: widget.items[index].description,
              assigner: widget.items[index].createdBy,
              assignee: widget.items[index].contactPerName,
              project: widget.items[index].solution.solutionName,
              status: widget.items[index].status,
              conrtactPerName: widget.items[index].contactPerName,
              conrtactPerEmail: widget.items[index].contactPerEmail,
              conrtactPerMob: widget.items[index].contactPerMobile,
              conrtactPerTel: widget.items[index].contactPerPhone),
        ),
      ),
    );
  }
}
