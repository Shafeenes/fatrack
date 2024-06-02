import 'package:flutter/material.dart';

class StatusIcon {
  String getWidgetStatusValKey(int status) {
    String _ticketStatusVal = "Open";

    switch (status) {
      case 0:
        _ticketStatusVal = "All";
        break;
      case 1:
        _ticketStatusVal = "Open";
        break;
      case 2:
        _ticketStatusVal = "Assigned";
        break;
      case 3:
        _ticketStatusVal = "WaitingYourReply";
        break;
      case 4:
        _ticketStatusVal = "Solved";
        break;
      case 5:
        _ticketStatusVal = "Closed";
        break;
      default:
        _ticketStatusVal = "All";
        break;
    }
    return _ticketStatusVal;
  }

  Padding getRenderedStatusIcon(int renderingStatus, double heightParam) {
    Padding _statusIconParam = Padding(
      padding: EdgeInsets.only(right: heightParam * 0.02),
      child: Icon(Icons.filter_alt_off_rounded,
          color: Colors.amber[400], size: 24.5),
    );
    switch (renderingStatus) {
      case 1:
        _statusIconParam = Padding(
          padding: EdgeInsets.only(right: heightParam * 0.02),
          child: Icon(Icons.bug_report_rounded, color: Colors.red, size: 24.5),
        );

        break;
      case 2:
        _statusIconParam = Padding(
            padding: EdgeInsets.only(right: heightParam * 0.02),
            child: Icon(Icons.co_present_rounded,
                color: Colors.deepOrange, size: 24.5));
        break;
      case 3:
        _statusIconParam = Padding(
            padding: EdgeInsets.only(right: heightParam * 0.02),
            child: Icon(Icons.reply_rounded,
                color: Colors.amberAccent[300], size: 24.5));
        break;
      case 4:
        _statusIconParam = Padding(
            padding: EdgeInsets.only(right: heightParam * 0.02),
            child: Icon(Icons.verified,
                color: Colors.lightGreenAccent, size: 24.5));
        break;
      case 5:
        _statusIconParam = Padding(
            padding: EdgeInsets.only(right: heightParam * 0.02),
            child: Icon(Icons.closed_caption,
                color: Colors.blueGrey[600], size: 24.5));
        break;
      default:
        _statusIconParam = Padding(
          padding: EdgeInsets.only(right: heightParam * 0.02),
          child: Icon(Icons.filter_alt_off_rounded,
              color: Colors.amber[400], size: 24.5),
        );
        break;
    }
    return _statusIconParam;
  }
}
