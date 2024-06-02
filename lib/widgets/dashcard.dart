import 'package:flutter/material.dart';

class IssueCardExample extends StatelessWidget {
  String countHeader;
  String count;
  String statusCountHeader;
  String statusCount;
  String type;

  IssueCardExample(
      {key,
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
      // width: width - 12,
      height: height * 0.102,
      child: Card(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        clipBehavior: Clip.hardEdge,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        icon: Icon(
                          Icons.ssid_chart_outlined,
                          color: Colors.amber,
                        ),
                        label: Text(countHeader,
                            style: TextStyle(
                              // height: height * 0.0012,
                              fontSize: height * 0.018,
                              color: Colors.white,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w600,
                            )),
                        onPressed: () {/* ... */},
                      ),
                      // const SizedBox(width: 8),
                      Container(
                        width: height * 0.052,
                        height: height * 0.052,
                        decoration: BoxDecoration(
                          // color: Color.fromRGBO(99, 102, 241, 1),

                          shape: BoxShape.circle,
                          // border: Border.all(color: Colors.transparent),
                          // borderRadius: BorderRadius.circular(16.0),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.grey,
                              Colors.blueGrey,
                            ],
                            tileMode: TileMode.clamp,
                          ),
                        ),
                        child: TextButton(
                          child: Text(count,
                              style: TextStyle(
                                // height: height * 0.0006,
                                fontSize: height * 0.008,
                                color: Colors.white,
                                fontFamily: "Nunito",
                              )),
                          onPressed: () {/* ... */},
                        ),
                      ),
                      // const SizedBox(width: 8),
                    ]),
                Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      TextButton.icon(
                        icon: Icon(
                          Icons.auto_graph_sharp,
                          color: Colors.red,
                        ),
                        label: Text(statusCountHeader,
                            style: TextStyle(
                              // height: height * 0.0008,
                              fontSize: height * 0.018,
                              color: Colors.white,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w600,
                            )),
                        onPressed: () {/* ... */},
                      ),
                      // const SizedBox(width: 8),
                      Container(
                          width: height * 0.052,
                          height: height * 0.052,
                          decoration: BoxDecoration(
                            // color: Color.fromRGBO(99, 102, 241, 1),

                            shape: BoxShape.circle,
                            // border: Border.all(color: Colors.transparent),
                            // borderRadius: BorderRadius.circular(16.0),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.grey,
                                Colors.blueGrey,
                              ],
                              tileMode: TileMode.clamp,
                            ),
                          ),
                          child: TextButton(
                            child: Text(statusCount,
                                style: TextStyle(
                                  // height: height * 0.0004,
                                  fontSize: height * 0.008,
                                  color: Colors.white,
                                  fontFamily: "Nunito",
                                )),
                            onPressed: () {/* ... */},
                          )),
                      // const SizedBox(width: 8),
                    ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
