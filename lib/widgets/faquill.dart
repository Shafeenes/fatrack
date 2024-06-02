// import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart';

// class FaQuillBoard extends StatefulWidget {
//   const FaQuillBoard({super.key});

//   @override
//   State<FaQuillBoard> createState() => _FaQuillBoardState();
// }

// class _FaQuillBoardState extends State<FaQuillBoard> {
//   @override
//   Widget build(BuildContext context) {
//       return FaQuillBoard(
//       configurations: QuillConfigurations(
//         controller: _controller,
//         sharedConfigurations: const QuillSharedConfigurations(
//           locale: Locale('de'),
//         ),
//       ),
//       child: Column(
//         children: [
//           const QuillToolbar(),
//           Expanded(
//             child: QuillEditor.basic(
//               configurations: const QuillEditorConfigurations(
//                 readOnly: false,
//                 controller: _controller,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
