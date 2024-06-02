import 'package:flutter/material.dart';

class FaSelect extends StatefulWidget {
  final List<String> options;
  final String? selectedValue;
  final void Function(String?) onChanged;

  const FaSelect({
    Key? key,
    required this.options,
    this.selectedValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<FaSelect> createState() => _FaSelectState();
}

class _FaSelectState extends State<FaSelect> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      initialValue: _selectedValue,
      onSelected: (String? value) {
        setState(() {
          _selectedValue = value;
        });
        widget.onChanged(value);
      },
      child: Text(_selectedValue ?? "Select"),
      itemBuilder: (BuildContext context) => widget.options
          .map((String option) => PopupMenuItem<String>(
                value: option,
                child: Text(option),
              ))
          .toList(),
    );
  }
}
