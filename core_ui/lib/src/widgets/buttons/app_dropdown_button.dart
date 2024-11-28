import 'package:core/core.dart';
import 'package:flutter/material.dart';

class AppDropdownButton extends StatelessWidget {
  const AppDropdownButton({
    required this.values,
    required this.onSelected,
    this.selectedValue,
    this.hasAllValue = true,
    super.key,
  });

  final List<String> values;
  final void Function(String) onSelected;
  final String? selectedValue;
  final bool hasAllValue;

  @override
  Widget build(BuildContext context) {
    final valuesString = [
      if (hasAllValue) LocaleKeys.general_all.tr(),
      ...values,
    ];

    return DropdownButton<String>(
      value: selectedValue ?? valuesString.first,
      icon: const Icon(Icons.arrow_downward),
      onChanged: (String? value) {
        if (value != null) onSelected(value);
      },
      items: valuesString.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
