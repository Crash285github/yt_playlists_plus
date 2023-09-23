import 'package:flutter/material.dart';

class StyledDropdown<T> extends DropdownButton {
  StyledDropdown({
    super.key,
    required super.items,
    required super.onChanged,
    super.value,
    super.alignment = Alignment.center,
    super.underline = const SizedBox.shrink(),
    super.padding = const EdgeInsets.symmetric(horizontal: 16),
    super.borderRadius = const BorderRadius.all(Radius.circular(10)),
    super.iconSize = 0,
  });
}
