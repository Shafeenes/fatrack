import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class FaDropDown extends StatefulWidget {
  List<Map<String, int>> list;
  FaDropDown({key, required this.list});

  @override
  State<FaDropDown> createState() => _FaDropDownCardState();
}

class _FaDropDownCardState extends State<FaDropDown> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> selectedDropdownValue = widget.list.first;
    return DropdownMenu<Map<String, dynamic>>(
      initialSelection: widget.list.first,
      onSelected: (Map<String, dynamic>? value) {
        // This is called when the user selects an item.
        setState(() {
          selectedDropdownValue = value!;
        });
      },
      dropdownMenuEntries: widget.list
          .map<DropdownMenuEntry<Map<String, dynamic>>>(
              (Map<String, dynamic> value) {
        return DropdownMenuEntry<Map<String, dynamic>>(
            value: value, label: value.toString());
      }).toList(),
    );
  }
}
