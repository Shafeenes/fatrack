// import 'package:flutter/material.dart';
// // import 'package:flutter_quill/flutter_quill.dart';
// // import 'package:flutter_quill/quill_delta.dart';

// class FaMCEEditor extends StatefulWidget {
//   dynamic quillEditorContent;

//   FaMCEEditor({required this.quillEditorContent});

//   @override
//   _FaMCEEditorState createState() => _FaMCEEditorState();
// }

// class _FaMCEEditorState extends State<FaMCEEditor> {
//   final _quillController = QuillController.basic();

//   @override
//   void initState() {
//     super.initState();
//     // Optionally set initial content
//     _quillController.document =
//         Document.fromDelta(Delta()..insert(0, widget.quillEditorContent));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return QuillEditor(
//         focusNode: FocusNode(canRequestFocus: true),
//         scrollController: ScrollController(),
//         configurations: QuillEditorConfigurations(
//           controller: QuillController(
//               document: Document.fromJson(widget.quillEditorContent),
//               selection: const TextSelection(baseOffset: 10, extentOffset: 10)),
//         ));
//   }
// }
