// import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart';

// class FaPen extends StatefulWidget {
//   const FaPen({super.key});

//   @override
//   State<FaPen> createState() => _FaPenState();
// }

// class _FaPenState extends State<FaPen> {
//   QuillController _faPenController = QuillController.basic();

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     return Container(
//       width: width * 0.765,
//       child: Column(
//         children: [
//           QuillToolbar.simple(
//             configurations: QuillSimpleToolbarConfigurations(
//               controller: _faPenController,
//               sharedConfigurations: const QuillSharedConfigurations(
//                 locale: Locale('en'),
//               ),
//             ),
//           ),
//           Expanded(
//             child: QuillEditor.basic(
//               configurations: QuillEditorConfigurations(
//                 controller: _faPenController,
//                 readOnly: false,
//                 sharedConfigurations: const QuillSharedConfigurations(
//                   locale: Locale('en'),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
