// import 'dart:io';

// import 'package:fatracker/pages/login.dart';
// import 'package:fatracker/widgets/permission.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// class PermissionHandlerWidget extends StatefulWidget {
//   /// Create a page containing the functionality of this plugin
//   // static LoginPage createPage() {
//   //   return LoginPage(
//   //       icon:, (context) => PermissionHandlerWidget());
//   // }

//   @override
//   _PermissionHandlerWidgetState createState() =>
//       _PermissionHandlerWidgetState();
// }

// class _PermissionHandlerWidgetState extends State<PermissionHandlerWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ListView(
//           children: Permission.values
//               .where((permission) {
//                 if (Platform.isIOS) {
//                   return permission != Permission.unknown &&
//                       permission != Permission.phone &&
//                       permission != Permission.sms &&
//                       permission != Permission.ignoreBatteryOptimizations &&
//                       permission != Permission.accessMediaLocation &&
//                       permission != Permission.activityRecognition &&
//                       permission != Permission.manageExternalStorage &&
//                       permission != Permission.systemAlertWindow &&
//                       permission != Permission.requestInstallPackages &&
//                       permission != Permission.accessNotificationPolicy &&
//                       permission != Permission.bluetoothScan &&
//                       permission != Permission.bluetoothAdvertise &&
//                       permission != Permission.bluetoothConnect &&
//                       permission != Permission.nearbyWifiDevices &&
//                       permission != Permission.videos &&
//                       permission != Permission.audio &&
//                       permission != Permission.scheduleExactAlarm &&
//                       permission != Permission.sensorsAlways;
//                 } else {
//                   return permission != Permission.unknown &&
//                       permission != Permission.mediaLibrary &&
//                       permission != Permission.photosAddOnly &&
//                       permission != Permission.reminders &&
//                       permission != Permission.bluetooth &&
//                       permission != Permission.appTrackingTransparency &&
//                       permission != Permission.criticalAlerts &&
//                       permission != Permission.assistant;
//                 }
//               })
//               .map((permission) => PermissionWidget(permission))
//               .toList()),
//     );
//   }
// }
