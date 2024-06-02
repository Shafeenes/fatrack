import 'package:flutter/material.dart';

class DashCard extends StatelessWidget {
  String countHeader;
  String count;
  String statusCountHeader;
  String statusCount;
  String type;
  Icon? icon;

  DashCard(
      {key,
      this.icon,
      required this.count,
      required this.countHeader,
      required this.statusCount,
      required this.statusCountHeader,
      required this.type});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    var icon = null;

    return SizedBox(
      width: 30,
      height: 20,
      child: Card(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        clipBehavior: Clip.hardEdge,
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: [
              Text(
                countHeader,
                style: TextStyle(
                  fontFamily: "Oswald",
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
              Text(
                count,
                style: TextStyle(
                  fontFamily: "Oswald",
                  color: Colors.black54,
                  fontSize: 16,
                ),
              ),
              Row(children: [
                this.icon!,
                Text(
                  statusCount,
                  style: TextStyle(
                    fontFamily: "Oswald",
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
