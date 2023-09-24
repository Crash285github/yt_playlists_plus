import 'package:flutter/material.dart';

///A pre-styled `DropdownButton`
class StyledDropdown<T> extends DropdownButton {
  StyledDropdown({
    super.key,
    super.value,
    required super.items,
    required super.onChanged,
    super.borderRadius = const BorderRadius.all(Radius.circular(10)),
    super.padding = const EdgeInsets.symmetric(horizontal: 16),
    super.underline = const SizedBox.shrink(),
    super.alignment = Alignment.center,
    super.iconSize = 0,
  });
}
